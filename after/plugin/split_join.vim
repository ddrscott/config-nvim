if !exists(':SplitjoinJoin')
  finish
endif

" Split Join {{{
let g:splitjoin_split_mapping = ''
let g:splitjoin_join_mapping = ''
" [jo]in and [sp]lit
nmap <Leader>jo :SplitjoinJoin<cr>
nmap <Leader>sp :SplitjoinSplit<cr>
" }}}
