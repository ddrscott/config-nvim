if !exists(':SideSearch')
  finish
endif

" Side Search {{{
let g:side_search_prg = 'ag --word-regexp'
      \. " --ignore='*.js.map'"
      \. " --ignore='*.csv'"
      \. " --ignore='*tags'"
      \. " --ignore='ui/public/client'"
      \. " --ignore='cassettes/'"
      \. " --ignore='components/help'"
      \. " --heading --stats -C 2 --group"
let g:side_search_splitter = 'vnew'
let g:side_search_split_pct = 0.4

" SideSearch current word and return to original window
nnoremap <Leader>ss :SideSearch <C-r><C-w><CR> | wincmd p

" SS shortcut and return to original window
command! -complete=file -nargs=+ SS execute 'SideSearch <args>'
" }}}
