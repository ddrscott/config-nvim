if !exists(':CocConfig')
  finish
endif

nmap <C-g><C-d> <Plug>(coc-definition)
nmap <C-g><C-t> <Plug>(coc-type-definition)
nmap <C-g><C-i> <Plug>(coc-implementation)
nmap <C-g><C-r> <Plug>(coc-references)
nmap <C-g><C-n> <Plug>(coc-rename)

" Compensate for Windows Double Ctrl-o entry.
nnoremap <silent> <C-o><C-o> <C-o>

" Use <c-space> for trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> for confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

augroup after_plugin_coc_vim
    au!
    " set term title to current file
    autocmd BufReadPost * if !filereadable("tags") | nmap <buffer> <silent> <C-]> :<C-u>call CocAction('jumpDefinition') <bar> exec('norm! zz')<CR> | endif
augroup END
