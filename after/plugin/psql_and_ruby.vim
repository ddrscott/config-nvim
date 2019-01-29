" Disabled: Wasn't ever working perfectly.
" We'll get back to this eventually.
finish

" Execute SQL and open resulting CSV file {{{
let g:psql_prg='psql -X -A --pset footer'

function! PsqlExecuteAndOpen(type, ...) abort
  let sel_save = &selection
  let &selection = "inclusive"
  let z=@z
  try
    if a:0  " Invoked from Visual mode, use gv command.
      silent exe "normal! gv\"zy"
    elseif a:type == 'line'
      silent exe "normal! '[V']\"zy"
    else
      silent exe "normal! `[v`]\"zy"
    endif
    let dst="/tmp/" . strftime("%Y-%m-%dT%H:%M:%S") . ".csv"
    let sql = substitute(@z, ';', '', '')
    let sql_copy="COPY (" . sql . ") TO STDOUT CSV HEADER"
    echo "running query..."
    call system(g:psql_prg . " > " . dst, sql_copy)
    echo "opening: " . dst
    call system("open " . dst)
  finally
    let &selection = sel_save
    let @z=z
  endtry
endfunction

if has('ruby')
  function! PsqlExecuteAndOpenRuby(type, ...) abort
    let sel_save = &selection
    let &selection = "inclusive"
    let z=@z
    try
      if a:0  " Invoked from Visual mode, use gv command.
        silent exe "normal! gv\"zy"
      elseif a:type == 'line'
        silent exe "normal! '[V']\"zy"
      else
        silent exe "normal! `[v`]\"zy"
      endif
      ruby << RUBY
      require 'open3'
      started = Time.now.to_f
      dst = "/tmp/#{Time.now.strftime('%Y-%m-%dT%H:%M:%S')}.csv"
      sql = VIM::evaluate('@z').gsub(';', '')
      sql_copy="COPY (#{sql}) TO STDOUT CSV HEADER"
      VIM::message('running query...')
      buffer = VIM::Buffer.current
      first_line = buffer[1]
      db_prg = first_line[/db_prg=(.*)$/, 1]
      out, _status = Open3.capture2(db_prg, stdin_data: sql_copy)
      File.open(dst, 'w') {|f| f.write(out)}
      duration = Time.now.to_f - started
      puts "duration: #{duration}"
      RUBY
    finally
      let &selection = sel_save
      let @z=z
    endtry
  endfunction
endif


" Send text object to PSQL 
nnoremap <silent> <Leader>ep :set opfunc=PsqlExecuteAndOpen<CR>g@

" Send visual selection to PSQL
vnoremap <silent> <Leader>ep :<C-u>call PsqlExecuteAndOpen(visualmode(), 1)<CR>

nmap <silent> <Leader>ee <Leader>epi;
"}}}
