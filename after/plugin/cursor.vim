augroup cursor
  au!
  autocmd InsertEnter * setlocal nocursorline
  autocmd InsertLeave * setlocal cursorline
augroup END
