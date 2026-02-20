" Statusline {{{
" Thanks: https://github.com/airblade/dotvim/blob/master/vimrc
let s:bg=19

" Custom statusline highlights for base16-ocean
" User1: Warning/error color (red, bold)
" User2: Active buffer name (yellow background for contrast)
function! statusline#setup_highlights() abort
  " base16-ocean colors
  let bg_dark = '#2b303b'
  let bg_mid  = '#343d46'
  let gray    = '#65737e'
  let yellow  = '#ebcb8b'
  let red     = '#bf616a'
  let fg      = '#c0c5ce'

  hi clear StatusLine
  hi clear StatusLineNC

  " Active statusline
  exec 'hi StatusLine   guifg=' . fg . ' guibg=' . bg_mid . ' gui=NONE'
  " Inactive statusline (dimmed)
  exec 'hi StatusLineNC guifg=' . gray . ' guibg=' . bg_dark . ' gui=italic'
  " User1: warnings/errors (red)
  exec 'hi User1 guifg=' . red . ' guibg=' . bg_mid . ' gui=bold'
  " User2: active buffer name - yellow bg, dark text for contrast
  exec 'hi User2 guifg=' . bg_dark . ' guibg=' . yellow . ' gui=bold'
  " User3: stats and scrollbar - yellow foreground
  exec 'hi User3 guifg=' . yellow . ' guibg=' . bg_mid . ' gui=NONE'

  " Gutter highlights - distinct from code area
  let gutter_bg = bg_mid
  exec 'hi LineNr       guifg=' . gray . ' guibg=' . gutter_bg
  exec 'hi CursorLineNr guifg=' . yellow . ' guibg=' . gutter_bg
  exec 'hi SignColumn   guifg=' . fg . ' guibg=' . gutter_bg
  exec 'hi FoldColumn   guifg=' . gray . ' guibg=' . gutter_bg

  " Subtle highlights - between bg_dark and bg_mid, matching ocean tint
  let bg_subtle = '#313a44'
  exec 'hi ColorColumn guibg=' . bg_subtle
  exec 'hi CursorLine  guibg=' . bg_subtle . ' gui=NONE'
endfunction

" Apply highlights now and after any colorscheme change
call statusline#setup_highlights()
augroup statusline_colors
  autocmd!
  autocmd ColorScheme * call statusline#setup_highlights()
augroup END

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

" Click handler for buffer labels
function! statusline#switch_buf(minwid, clicks, btn, mods) abort
  if a:btn ==# 'l'
    execute 'buffer ' . a:minwid
  elseif a:btn ==# 'r'
    execute 'bdelete ' . a:minwid
  endif
endfunction

function! statusline#buffers_prev(max) abort
  let i = bufnr('$')
  let result = ''
  let found = 0
  while i > 0
    if buflisted(i)
      let current = bufnr('%')
      if i < current
        " %{bufnr}@Function@ makes it clickable, %X ends clickable region
        let label = i . ':' . fnamemodify(bufname(i), ':t')
        let result = '%' . i . '@statusline#switch_buf@ ' . label . ' %X' . result
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
        let label = i . ':' . fnamemodify(bufname(i), ':t')
        let result = result . '%' . i . '@statusline#switch_buf@ ' . label . ' %X'
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
  " Embed buffer labels directly so clickable %@...@ syntax works
  if &buftype == '' && &previewwindow == 0
    let line = line . statusline#buffers_prev(3) . ' '
  else
    let line = line . ' '
  endif
  if a:state == 'active'
    let line = line . ' %2*%{" ".statusline#buf_display_name("%")." "}%* '
    if &buftype ==# "terminal"
      return ''
    endif
  else
    let line = line .    '%{"[ ".statusline#buf_display_name("%")." ]"}'
  endif
  if &buftype == '' && &previewwindow == 0
    let line = line . ' ' . statusline#buffers_next(3)
  endif
  let line = line . '%='
  let line = line . '%3* %L:%3c'
  let line = line . '%1*%{TrailingSpaceWarning()}%* '
  if a:state == 'active'
    " Only add scrollbar if plugin is loaded
    if exists('g:noscrollbar_loaded')
      let line = line . "%3*%{noscrollbar#statusline(20,'=','█',['▐'],['▌'])}%*"
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
