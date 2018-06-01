autocmd FileType javascript JsPreTmpl html

" Congwen
nnoremap <Leader>kk <Plug>(Prettier)
" Scott: What it does is pastes over the cursor's current word and set marker p
" <Leader>y yanks the cursor's current word and set marker y.
let g:prettier#config#single_quote = 'false'
let g:prettier#config#bracket_spacing = 'true'
let g:prettier#config#trailing_comma = 'none'

" on reload file, reset
augroup nprettier
  au!
  au BufWrite *.js Prettier
augroup END

nnoremap <silent> g= :call SaveViewExecute('<Plug>(Prettier)')<CR>
