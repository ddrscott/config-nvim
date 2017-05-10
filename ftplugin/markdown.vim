setlocal spell
setlocal nonumber
setlocal norelativenumber
setlocal formatoptions=t1

setlocal nofoldenable
let g:vim_markdown_frontmatter=1

" augroup prose
"   au!
"   autocmd InsertEnter * set formatoptions+=a
"   autocmd InsertLeave * set formatoptions-=a
" augroup END

" htmlH1         xxx links to Title
highlight link htmlH1 Label

