if !executable('fzf')
  finish
endif

set runtimepath+=~/.fzf
let g:fzf_action = {
      \ 'ctrl-t': 'tab split',
      \ 'ctrl-s': 'split',
      \ 'ctrl-v': 'vsplit' }

" Fuzzy Finder FZF helpers {{{
" Super charged File finder
let g:fzf_file_name_only=" -d '/' --nth=-1"
let g:fzf_preview_source=" --preview 'pygmentize -g {} 2>/dev/null \|\| head -200 {}'"
nnoremap <silent> <Leader><Leader> :call fzf#vim#files('.', {'options': g:fzf_preview_source . g:fzf_file_name_only })<CR>
nnoremap <silent> <Leader>ff :call fzf#vim#files('.', {'options': g:fzf_preview_source })<CR>
nnoremap <silent> <Leader>fh :call fzf#vim#history({'options': g:fzf_preview_source . g:fzf_file_name_only })<CR>
nnoremap <silent> <Leader>fm :Marks<CR>
nnoremap <silent> <Leader>ft :Tags<CR>
nnoremap <silent> <Leader>fb :Buffers<CR>
nnoremap <silent> <Leader>ls :Buffers<CR>
inoremap <silent> <expr> <c-k> fzf#complete({
      \ 'source':  'cat /usr/share/dict/words',
      \ 'options': "--height 10 --preview 'wn {} -over \| fold'",
      \ 'down': '~30%'
      \ })

command! SinceDev call fzf#run({'source': 'git diff --name-only dev..', 'down': '33%', 'sink': 'edit', 'options': '-m'})
nnoremap <silent> <Leader>fd :SinceDev<CR>
" }}
