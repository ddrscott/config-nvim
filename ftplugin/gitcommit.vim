" Always start cursor at upper left!!!
augroup gitcommit_vim
  au! BufEnter COMMIT_EDITMSG call setpos('.', [0, 1, 1, 0])
augroup END
