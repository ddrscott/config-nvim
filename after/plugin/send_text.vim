if !exists(':SendTextCurrentLine') || !$ITERM_PROFILE
  finish
endif

" SendText Mappings {{{
" Send current line
nnoremap <silent> <Leader>i<CR> :SendTextCurrentLine<CR>

" Send in/around text object
nnoremap <silent> <Leader>i :set opfunc=sendtext#iTermSendOperator<CR>g@

" Send visual selection
vnoremap <silent> <Leader>i :<C-u>call sendtext#iTermSendOperator(visualmode(), 1)<CR>
" }}}

