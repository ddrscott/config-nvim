" Rotate Windows {{{
" Assuming we have a window layout such as:
"    ----------------------
"    |            |   B   |
"    |     A*     |-------|
"    |            |   C   |
"    ----------------------
" And focus is on A*.
" This will move the window positions from A to B, B to C, and C to A.
" Or the reverse: A to C, C to B, and B to A.
"
" This is better than the default <C-w>r because the windows can be on
" different axis.
"
" This will also keep the same widths.
"
" Mapping:
"   nnoremap ]e :call window#rotate('K', winnr('$'))<cr>
"   nnoremap [e :call window#rotate('J', 2)<cr>
function! window#rotate(dir, idx) abort
  " assume left is main window
  exec '1wincmd w'
  let w = winwidth(1)
  exec 'wincmd '.a:dir
  let dst = (a:dir == 'K' ? 0 : -1) + a:idx
  exec dst . 'wincmd w'
  wincmd H
  exec 'vertical resize' w
endfunction

" Sets window's buffer number to next/previous windows buffer number
" This effective rotates the contents of the windows instead of the
" actual window.
" It has a similar effect window#rotate, but handles all sorts of window
" layouts.
function! window#buffer_rotate(dir) abort
  let current = winnr()
  " assume left is main window
  let winnr_to_bufnr = util#winnr_bufnr_dict()
  " collect all the buffer numbers
  let max = winnr('$')
  let i = max
  while i > 0
    let dst = (a:dir + i) - 1
    let mod = util#mod(dst,max) + 1
    call window#set_winnr_to_bufnr(i, winnr_to_bufnr[mod])
    let i -= 1
  endwhile
  exec 'keepjumps '.current.'wincmd w'
endfunction

function! window#winnr_by_area()
  let largest = 0
  let size = 0

  let i = winnr('$')
  while i > 0
    let area = winheight(i) * winwidth(i)
    if area >= size
      let largest = i
      let size = area
    endif
    let i -= 1
  endwhile
  return largest
endfunction

function! window#set_winnr_to_bufnr(window_num, buffer_num)
  exec 'keepjumps '.a:window_num.'wincmd w'
  exec 'silent keepjumps buffer '.a:buffer_num
endfunction

" Similar to `wincmd x`, but works regardless of layout.
" When other is < 1, will exchange with previous window according to
" `wincmd p`.
function! window#exchange(other) abort
  let current = winnr()
  let winnr_to_bufnr = util#winnr_bufnr_dict()
  let other_winnr = s:other_winnr(a:other)
  if current == other_winnr
    return
  endif
  let other_bufnr = winnr_to_bufnr[other_winnr]
  if other_bufnr
    call window#set_winnr_to_bufnr(other_winnr, winnr_to_bufnr[current])
    call window#set_winnr_to_bufnr(current, winnr_to_bufnr[other_winnr])
  endif
endfunction

" Tab Split Current Window
" Mapping:
"   nnoremap <c-w>o :call window#only()<cr>
"   nnoremap <c-w><c-o> :call window#only()<cr>
function! window#only()
  if winnr('$') > 1
    tab split
  endif
endfunction

function! s:other_winnr(other)
  let other_winnr = a:other
  if other_winnr < 1
    wincmd p
    let other_winnr = winnr()
    wincmd p
  endif
  return other_winnr
endfunction

function! window#join(splitter, other) abort
  let current = winnr()
  let other_winnr = s:other_winnr(a:other)
  if current == other_winnr
    return
  endif
  let winnr_to_bufnr = util#winnr_bufnr_dict()
  let other_bufnr = winnr_to_bufnr[other_winnr]
  wincmd p
  exec other_winnr.'quit'
  wincmd p
  exec a:splitter
  exec 'buffer '.other_bufnr
endfunction
