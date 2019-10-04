" Statusline {{{
" Thanks: https://github.com/airblade/dotvim/blob/master/vimrc
let s:bg=19
hi clear StatusLine
hi clear StatusLineNC
exec 'hi StatusLine   ctermfg=3 ctermbg=' . s:bg
exec 'hi StatusLineNC ctermfg=3 ctermbg=' . s:bg . ' cterm=italic'

" highlight values in terminal vim, colorscheme solarized
" Identifier
exec 'hi User1  ctermfg=9   ctermbg=' . s:bg . ' cterm=bold'
exec 'hi User2  ctermfg=3   ctermbg=' . s:bg . ' cterm=bold,reverse'

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

function! statusline#buffers_prev(max) abort
  let i = bufnr('$')
  let result = ''
  let found = 0
  while i > 0
    if buflisted(i)
      let current = bufnr('%')
      if i < current
        let result = ' '. i . ':' . fnamemodify(bufname(i), ':t') . ' ' . result
        let found += 1
        if found >= a:max
          return result
        endif
      endif
    endif
    let i -= 1
  endwhile
  return result
endfunction

function! statusline#buffers_next(max) abort
  let i = 0
  let last = bufnr('$')
  let result = ''
  let found = 0
  while i <= l:last
    if buflisted(i)
      let current = bufnr('%')
      if i > current
        let result = result . ' '. i . ':' . fnamemodify(bufname(i), ':t') . ' '
        let found += 1
        if found >= a:max
          return result
        endif
      endif
    endif
    let i += 1
  endwhile
  return result
endfunction

function! statusline#buf_display_name(bufexpr) abort
  let short_name = fnamemodify(bufname(a:bufexpr),":t")
  let display_buftype = ''
  if &buftype != ''
    " let display_buftype = ' ('. &buftype . ')'
    return '~' . short_name
  endif
  let unlisted = ''
  if buflisted(bufnr('%')) == 0
    let unlisted = '*'
  endif
  return unlisted . short_name . display_buftype
endfunction

function! statusline#build(state) abort
  let line = '%1*%([%M%H%W%R]%)%q%*'
  let line = line . '%='
  let line = line . '%{&buftype == "" && &previewwindow == 0 ? statusline#buffers_prev(3) : ""} '
  if a:state == 'active'
    let line = line . ' %2*%{" ".statusline#buf_display_name("%")." "}%* '
    if &buftype ==# "terminal"
      return ''
    endif
  else
    let line = line .    '%{"[ ".statusline#buf_display_name("%")." ]"}'
  endif
  let line = line . ' %{&buftype == "" && &previewwindow == 0 ? statusline#buffers_next(3) : ""}'
  let line = line . '%='
  let line = line . ' %L:%3c'
  let line = line . '%1*%{TrailingSpaceWarning()}%* '
  if a:state == 'active'
    " Only add scrollbar if plugin is loaded
    if exists('g:noscrollbar_loaded')
      let line = line . "%{noscrollbar#statusline(20,'=','█',['▐'],['▌'])}"
    endif
  endif
  return line
endfunction

setlocal statusline=%!statusline#build('inactive')

augroup ShowStats
  au!
  " Show file status when entering a buffer
  autocmd BufEnter,WinEnter * exec "normal \<C-g>"
    \ | setlocal statusline=%!statusline#build('active')

  " Set inactive statusline when leaving stuff
  autocmd BufLeave,WinLeave * setlocal statusline=%!statusline#build('inactive')
augroup END
" }}}
