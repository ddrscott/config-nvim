" ensures a positive modulo
function! util#mod(n,m)
	return ((a:n % a:m) + a:m) % a:m
endfunction

" return dicitionay of winnr to bufnr mappings
function! util#winnr_bufnr_dict()
	let result = {}
	" collect all the buffer numbers
	let i = winnr('$')
	while i > 0
		let result[i] = winbufnr(i)
		let i -= 1
	endwhile
  return result
endfunction

" return dicitionay of winnr to bufnr mappings
function! util#bufnr_winnr_dict()
  let result = {}
  " collect all the buffer numbers
  let i = winnr('$')
  while i > 0
    let result[winbufnr(i)] = i
    let i -= 1
  endwhile
  return result
endfunction
