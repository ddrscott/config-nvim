if !&rtp=~ 'vim-submode'
  finish
endif

" Submode Plugins {{{
" Exit submodes after a 2 seconds. Think fast!
let g:submode_always_show_submode=1
let g:submode_timeout=1
let g:submode_timeoutlen=2000
" }}}
"
" Window Submode {{{
call submode#enter_with('window', 'n', '', '<Leader>w')
call submode#leave_with('window', 'n', '', '<Esc>')
for key in ['a','b','c','d','e','f',
      \ 'g','h','i','j','k','l',
      \ 'm','n','o','p','r','s',
      \ 't','u','v','w','x','y','z']
  call submode#map('window', 'n', '', key, '<C-w>' . key)
  call submode#map('window', 'n', '', toupper(key), '<C-w>' . toupper(key))
  call submode#map('window', 'n', '', '<C-' . key . '>', '<C-w>' . '<C-'.key . '>')
endfor
call submode#map('window', 'n', '', 'q', '<C-w>c')
call submode#map('window', 'n', '', '<C-q>', '<C-w>c')
call submode#map('window', 'n', '', 'v', ':vnew<CR>')
call submode#map('window', 'n', '', '<C-v>', ':vnew<CR>')
call submode#map('window', 'n', '', '\', ':vertical resize 80<CR>')
call submode#map('window', 'n', '', '+', '3<C-w>+')
call submode#map('window', 'n', '', '-', '3<C-w>-')
call submode#map('window', 'n', '', '<', '10<C-w><')
call submode#map('window', 'n', '', '>', '10<C-w>>')
call submode#map('window', 'n', '', '=', '<C-w>=')
" }}}

" 'z' submode {{{
call submode#enter_with('Z', 'n', '', '<Leader>zz', 'zz')
call submode#leave_with('Z', 'n', '', '<Esc>')
call submode#map('Z', 'n', '', 't', 'zt')
call submode#map('Z', 'n', '', 'b', 'zb')
call submode#map('Z', 'n', '', 'l', 'zl')
call submode#map('Z', 'n', '', 'h', 'zh')
call submode#map('Z', 'n', '', 'L', 'zL')
call submode#map('Z', 'n', '', 'H', 'zH')
call submode#map('Z', 'n', '', 'j', 'zjzz')
call submode#map('Z', 'n', '', 'k', 'zkzz')
call submode#map('Z', 'n', '', 'z', 'zz')

" folding
call submode#map('Z', 'n', '', 'a', 'za')
call submode#map('Z', 'n', '', 'm', 'zm')
call submode#map('Z', 'n', '', 'o', 'zo')
call submode#map('Z', 'n', '', 'r', 'zr')
call submode#map('Z', 'n', '', 'A', 'zA')
call submode#map('Z', 'n', '', 'M', 'zM')
call submode#map('Z', 'n', '', 'O', 'zO')
call submode#map('Z', 'n', '', 'R', 'zR')
" }}}

" g-changes submode {{{
call submode#enter_with('g-changes', 'n', '', 'g;', 'g;')
call submode#enter_with('g-changes', 'n', '', 'g,', 'g,')
call submode#leave_with('g-changes', 'n', '', '<Esc>')
call submode#map('g-changes', 'n', '', ';', 'g;')
call submode#map('g-changes', 'n', '', ',', 'g,')
" }}}
