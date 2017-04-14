" Statusline {{{
" Thanks: https://github.com/airblade/dotvim/blob/master/vimrc
let s:bg=19
hi clear StatusLine
hi clear StatusLineNC
exec 'hi StatusLine   ctermfg=3 ctermbg=' . s:bg
exec 'hi StatusLineNC ctermfg=3 ctermbg=19' . ' cterm=italic'

" highlight values in terminal vim, colorscheme solarized
" Identifier
exec 'hi User1  ctermfg=9   ctermbg='.s:bg.' cterm=bold'
exec 'hi User2  ctermfg=3   ctermbg='.s:bg.' cterm=bold,reverse'

function! WindowNumber()
  return tabpagewinnr(tabpagenr())
endfunction

function! TrailingSpaceWarning()
  if !exists("b:statline_trailing_space_warning")
    let lineno = search('\s$', 'nw')
    if lineno != 0
      let b:statline_trailing_space_warning = ' '.lineno.'!'
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

function! statusline#buffers_for(type) abort
  let i = bufnr('$')
  let result = ''
  while i > 0
    if buflisted(i)
      let current = bufnr('%')
      if a:type == 'prev' && i < current
        let result = ' '. i . ':' . fnamemodify(bufname(i), ':t') . ' ' . result
      elseif a:type == 'next' && i > current
        let result = ' '. i . ':' . fnamemodify(bufname(i), ':t') . ' ' . result
      endif
    endif
    let i -= 1
  endwhile
  return result
endfunction

function! statusline#buf_display_name(bufexpr) abort
  let short_name = fnamemodify(bufname(a:bufexpr),":t")

  let display_buftype = ''

  if &buftype != ''
    let display_buftype = ' ('. &buftype . ')'
  endif
  

  let unlisted = ''
  if buflisted(bufnr('%')) == 0
    let unlisted = '~'
  endif

  return unlisted . short_name . display_buftype
endfunction

function! statusline#build() abort
  let line = '%1*%([%M%H%W%R]%)%q%*'
  let line = line . '%='
  let line = line . '%{statusline#buffers_for("prev")} '
  let line = line .    '%{bufnr("%") != g:actual_curbuf ? "[ ".statusline#buf_display_name("%")." ]" : ""}'
  let line = line . '%2*%{bufnr("%") == g:actual_curbuf ? "[ ".statusline#buf_display_name("%")." ]" : ""}%*'
  let line = line . ' %{statusline#buffers_for("next")}'
  let line = line . '%='
  let line = line . ' %Lg'
  let line = line . '%1*%{TrailingSpaceWarning()}%*'
  let line = line . ' #%-3{WindowNumber()}'
  return line
endfunction

set statusline=%!statusline#build()

augroup ShowStats
  au!
  " Show file status when entering a buffer
  autocmd BufEnter * exec "normal \<C-g>"
augroup END

" }}}
