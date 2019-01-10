" Gsub {{{
function! Gsub(a, b, re)
  try
    let z=@/
    exe "'" . a:a . ",'" . a:b . a:re
  finally
    let @/=z
  endtry
endfunction
" }}}

" SymbolizeHash {{{
func! SymbolizeHash(a, b)
  call Gsub(a:a, a:b, 's/\v(''|")([^\1]+)\1\s*\=\>\s*/\2: /ge')
endf

func! SymbolizeHashOperation(type)
  call SymbolizeHash('[', ']')
endf

nnoremap <Leader>zh <Esc>:set opfunc=SymbolizeHashOperation<CR>g@
vnoremap <Leader>zh <Esc>:call SymbolizeHash('<','>')<CR>
" }}}

