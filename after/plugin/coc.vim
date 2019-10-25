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


" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
