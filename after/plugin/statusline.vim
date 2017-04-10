" Statusline {{{
" Thanks: https://github.com/airblade/dotvim/blob/master/vimrc
hi clear StatusLine
hi clear StatusLineNC
hi StatusLine   term=none ctermfg=0 ctermbg=18
hi StatusLineNC term=bold ctermfg=0 ctermbg=0

" highlight values in terminal vim, colorscheme solarized
hi User1                      ctermbg=18 ctermfg=9          guifg=#40ffff            " Identifier
hi User2                      ctermbg=18 ctermfg=2 gui=bold guifg=#ffff60            " Statement
hi User3 term=bold cterm=bold ctermbg=18 ctermfg=1          guifg=White   guibg=Red  " Error
hi User4                      ctermbg=18 ctermfg=1          guifg=Orange             " Special
hi User5                      ctermbg=18 ctermfg=10         guifg=#80a0ff            " Comment
hi User6 term=bold cterm=bold ctermbg=18 ctermfg=1          guifg=Red                " WarningMsg

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
set statusline+=%1*%m%r%*                          " modified, readonly
set statusline+=%5*%{pathshorten(expand('%:h'))}/               " relative path to file's directory
set statusline+=%2*%t%*                            " file name
set statusline+=\ %=                               " switch to RHS
set statusline+=%5*%L%*%2*g                        " number of lines
set statusline+=\ %3*%{TrailingSpaceWarning()}%*     " trailing whitespace
set statusline+=\ %2*#%-3.3{WindowNumber()}%*        " window number
" }}}
