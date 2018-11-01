func! ListMonths()
  call complete(col('.'), ['January', 'February', 'March',
        \ 'April', 'May', 'June', 'July', 'August', 'September',
        \ 'October', 'November', 'December'])
  return ''
endfunc
inoremap <F5> <C-R>=ListMonths()<CR>
