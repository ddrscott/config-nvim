setlocal spell
" setlocal nonumber
" setlocal norelativenumber
setlocal wrap
setlocal tw=100
setlocal colorcolumn=+5
" hi ColorColumn ctermbg=lightgrey guibg=lightgrey

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
