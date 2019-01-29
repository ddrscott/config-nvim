" Make sure Vim returns to the same line when you reopen a file.
" Thanks, Amit
augroup line_return_vim
  au!
  au BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \     execute 'normal! g''"zvzz' |
        \ endif
augroup END
