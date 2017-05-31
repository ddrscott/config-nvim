" Always start git commits in insert mode
augroup AutoInsert
  au!
  autocmd BufReadPost COMMIT_EDITMSG startinsert
augroup END
