" Example Mappings:
" nnoremap <silent> y :call steady#pos()<bar>set opfunc=steady#yank<CR>g@
" nnoremap <silent> y :call steady#anything('steady#yank')<CR>
" nnoremap <expr> y steady#anything('steady#yank')
" vnoremap <silent> y :<C-u>call steady#yank(visualmode(), 1)<CR>
"
" nnoremap <silent> y :call steady#opfunc('steady#yank')<CR>g@
" nnoremap <silent> yy :call steady#save() <bar> steady#yank<CR>
"2345678901234567890
let b:steady_pos = getcurpos()
function! steady#yank(type, ...)
  echom a:type
  if a:type ==# 'char'
    execute 'normal! `[v`]"'.v:register.'y'
  elseif a:type ==# 'line'
    execute 'normal! ''[v'']"'.v:register.'y'
  else
    execute 'normal! `<' . a:type . '`>"' . v:register . 'y'
  endif
  call steady#restore()
endfunction

function! steady#save() abort
  let b:steady_pos = getcurpos()
endfunction

function! steady#restore() abort
  call cursor(b:steady_pos[1], b:steady_pos[2], b:steady_pos[3])
endfunction

function! steady#opfunc(thing) abort
  call steady#save()
  let &opfunc=a:thing
endfunction

function! steady#call(thing) abort
  call steady#save()
endfunction
