augroup neovim_stuff
  au!
  autocmd FileType javascript JsPreTmpl html
augroup END

let b:ale_fixers = ['prettier']
let b:ale_linters = ['eslint']
nnoremap <buffer> <C-]> :ALEGoToDefinition<cr>
nnoremap <buffer> <Leader>r :ALEFindReferences<cr>
