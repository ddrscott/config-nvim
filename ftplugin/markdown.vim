setlocal spell
" setlocal nonumber
" setlocal norelativenumber
setlocal wrap
setlocal tw=0
setlocal colorcolumn=0

setlocal nofoldenable
let g:vim_markdown_frontmatter=1
let g:vim_markdown_fenced_languages=['c++=cpp', 'viml=vim', 'bash=sh', 'ini=dosini', 'rb=ruby']

" augroup prose
"   au!
"   autocmd InsertEnter * set formatoptions+=a
"   autocmd InsertLeave * set formatoptions-=a
" augroup END

" htmlH1         xxx links to Title
highlight link htmlH1 Label

setlocal makeprg=diction\ % errorformat=%f:%l:\ %m
