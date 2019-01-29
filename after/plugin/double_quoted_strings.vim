" DoubleToSingleQuote {{{
func! DoubleToSingleQuote(a, b)
  call Gsub(a:a, a:b, 's/\v"([^"#]+)"/''\1''/ge')
endf

func! DoubleToSingleQuoteOperation(type)
  call DoubleToSingleQuote('[', ']')
endf

nnoremap <Leader>zq <Esc>:set opfunc=DoubleToSingleQuoteOperation<CR>g@
vnoremap <Leader>zq <Esc>:call DoubleToSingleQuote('<','>')<CR>
" }}}
