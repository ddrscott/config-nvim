" Statusline {{{
" Thanks: https://github.com/airblade/dotvim/blob/master/vimrc
let s:bg=19
hi clear StatusLine
hi clear StatusLineNC
exec 'hi StatusLine   ctermfg=3 ctermbg='.s:bg
exec 'hi StatusLineNC ctermfg=3 ctermbg='.s:bg

" highlight values in terminal vim, colorscheme solarized
" Identifier
exec 'hi User1  ctermfg=9   ctermbg='.s:bg.' cterm=bold'
exec 'hi User2  ctermfg=2   ctermbg='.s:bg.' cterm=bold'
exec 'hi User3  ctermfg=1   ctermbg='.s:bg.' cterm=bold'
exec 'hi User4  ctermfg=1   ctermbg='.s:bg.' cterm=bold'
exec 'hi User5  ctermfg=10  ctermbg='.s:bg.' cterm=bold'
exec 'hi User6  ctermfg=1   ctermbg='.s:bg.' cterm=bold'

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction
function! TrailingSpaceWarning()
  if !exists("b:statline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statline_trailing_space_warning = ''.lineno.'!'
    else
      let b:statline_trailing_space_warning = ''
    endif
  endif
  return b:statline_trailing_space_warning
endfunction

" recalculate when idle, and after saving
augroup statline_trail
  autocmd!
  autocmd cursorhold,bufwritepost * unlet! b:statline_trailing_space_warning
augroup END

set statusline=
set statusline+=%1*%([%M%H%W%R]%)%q%*                    " modified, readonly
set statusline+=%5*\ %{pathshorten(expand('%:h'))}/        " relative path to file's directory
set statusline+=%2*%t\ %*                            " file name
set statusline+=\ %=                               " switch to RHS
set statusline+=%5*\ %L%*%2*g                        " number of lines
set statusline+=%3*\ %{TrailingSpaceWarning()}%*     " trailing whitespace
set statusline+=%2*\ #%-3.3{WindowNumber()}%*        " window number
" }}}
