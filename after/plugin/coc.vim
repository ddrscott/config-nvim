if !exists(':CocConfig')
  finish
endif

nmap <C-g><C-d> <Plug>(coc-definition)
nmap <C-g><C-t> <Plug>(coc-type-definition)
nmap <C-g><C-i> <Plug>(coc-implementation)
nmap <C-g><C-r> <Plug>(coc-references)

" Compensate for Windows Double Ctrl-o entry.
nnoremap <silent> <C-o><C-o> <C-o>
