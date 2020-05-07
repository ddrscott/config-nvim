function! DetectSQL()
  if getline(1) =~? 'select\|with'
    setfiletype sql
  endif
endfunction

augroup sql_stuff
  au!
  au BufNewFile,BufRead *.bqsql set filetype=sql
  au BufRead,BufNewFile * call DetectSQL()
augroup END
