if !&rtp=~ 'vim-window'
  finish
endif

" Window Mappings for improved layout commands {{{
" Important: `:<C-U>` is required the function doesn't get called multiple times.
nnoremap ]r :<C-u>call window#rotate(-1 * v:count1)<cr>
nnoremap [r :<C-u>call window#rotate(1 * v:count1)<cr>

nmap <C-w>r ]r
nmap <C-w><C-r> ]r

nnoremap <C-w>x :<C-u>call window#exchange(v:count)<cr>
nnoremap <C-w><c-x> :<C-u>call window#exchange(v:count)<cr>

nnoremap <C-w>o :call window#only()<cr>
nnoremap <C-w><c-o> :call window#only()<cr>

nnoremap <C-w>gl :<C-u>call window#join('rightbelow vsplit', v:count) <BAR>normal 100zh<CR>
nnoremap <C-w>gh :<C-u>call window#join('leftabove vsplit', v:count)  <BAR>normal 100zh<CR>
nnoremap <C-w>gj :<C-u>call window#join('belowright split', v:count)  <BAR>normal 100zh<CR>
nnoremap <C-w>gk :<C-u>call window#join('aboveleft split', v:count)   <BAR>normal 100zh<CR>

command! -nargs=* LayoutH call window#layout('ball', 'H', <args>)
command! -nargs=* LayoutJ call window#layout('vertical ball', 'J', <args>) 
command! -nargs=* LayoutK call window#layout('vertical ball', 'K', <args>) 
command! -nargs=* LayoutL call window#layout('ball', 'L', <args>)

command! -nargs=* WinH call window#layout('windo wincmd J', 'H', <args>)
" }}}
