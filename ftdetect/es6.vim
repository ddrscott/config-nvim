augroup es6_stuff
  au!
  au BufNewFile,BufRead *.es6 set filetype=javascript.jsx
  au BufNewFile,BufRead *.js set filetype=javascript.jsx
augroup END

highlight link xmlTagName xmlTag
highlight link xmlEndName xmlTag
