" This is a work around for using clipboard+=unnamedplus and block paste
" Thanks: https://github.com/neovim/neovim/issues/1822#issuecomment-70386284
" I modified slighty to accept different registers
function! BlockPaste(...)
  " Default to '+' system register
  let reg = '+'
  if a:0 > 0
    let l:reg = a:1
  endif
  let c = split(getreg(l:reg), '\n', 1)
  let lenght =  len(c)
  let start = line('.')
  let end = start + lenght -1
  let col = col('.') - 1
  let op_lines = range(start, end)
  let idx = 0
  for line in op_lines
    let line_orig = getline(line)
    let head = line_orig[:col-1]
    exe "let tail = line_orig[".col.":]"
    if len(head) < col
      let spaces = col - len(head)
      let head = head.repeat(' ', spaces)
    endif
    let new_line = head . c[idx] . tail
    call setline(line, new_line)
    let idx += 1
  endfor
endfunction
command! BlockPaste call BlockPaste('+')
