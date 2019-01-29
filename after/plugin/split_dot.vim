" Split Dot {{{
command! SplitDot
      \ let _s=@/                               <bar>
      \ s/\v\.\w+%(\([^)]+\)|\{[^}]+})*/\r\0/g  <bar>
      \ let @/=_s                               <bar>
      \ keepjumps normal! ``=']']

nnoremap <Leader>sd :SplitDot<CR>
" }}}
