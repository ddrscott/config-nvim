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

function! window#buffer_rotate(dir) abort
  " assume left is main window
  let winnr_to_bufnr = util#winnr_bufnr_dict()
  " collect all the buffer numbers
  let max = winnr('$')
  let i = max
  while i > 0
    exec 'keepjumps '.i.'wincmd w'
    setlocal winfixwidth
    let dst = (a:dir + i) - 1
    let mod = util#mod(dst,max) + 1
    exec 'silent keepjumps buffer '.winnr_to_bufnr[mod]
    let i -= 1
  endwhile
endfunction
