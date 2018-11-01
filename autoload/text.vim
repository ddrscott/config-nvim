
" Remove surrounding single or double quotes {{{
function! text#unquote(text)
  return substitute(a:text, '\v<([''"])(.*)\1>', '\2', '')
endfunction
" }}}
