" Inspired by some ajh17's save view routine
" Thanks: https://github.com/ajh17/dotfiles/blob/master/.vim/autoload/format.vim
function! SaveViewNormal(cmd)
  let winview = winsaveview()
  execute 'keepjumps normal! ' . a:cmd
  call winrestview(winview)
endfunction

function! SaveViewExecute(cmd)
  let winview = winsaveview()
  execute 'keepjumps ' . a:cmd
  call winrestview(winview)
endfunction

" Indent all lines without changing jumps or cursor position.
nnoremap <silent> g= :call SaveViewExecute('normal! gg=G')<CR>
command! Reformat call SaveViewExecute('normal! gggqG')
