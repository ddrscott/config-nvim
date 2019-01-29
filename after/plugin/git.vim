" Fugitive Stuff {{{
augroup git_vim
  au!
  autocmd BufEnter fugitive://* setlocal foldenable
augroup END
" }}}

let g:fugitive_replace_status_on_commit=1

" Git Mappings {{{
nnoremap <Leader>gd :Gvdiff<cr>
nnoremap <Leader>gs :Gstatus<cr>
nnoremap <Leader>ga :Gadd<cr>
nnoremap <Leader>gb :Gblame<cr>
"nnoremap <Leader>gco :Gcheckout<cr>
"nnoremap <Leader>gci :Gcommit<cr>
"nnoremap <Leader>gm :Gmove<cr>
"nnoremap <Leader>gw :Gwrite<cr>
"nnoremap <Leader>gr :Gremove<cr>
"nnoremap <Leader>gl :Shell git gl -18<cr>:wincmd \|<cr>
" }}}


" Git Gutter {{{
nmap [h <Plug>GitGutterPrevHunk
nmap ]h <Plug>GitGutterNextHunk
nmap <Leader>hs <Plug>GitGutterStageHunk
nmap <Leader>hr <Plug>GitGutterRevertHunk
nmap <Leader>hp <Plug>GitGutterPreviewHunk
nmap <Leader>hcc <Plug>GitGutterStageHunk:Gcommit<cr>
nmap <Leader>hca <Plug>GitGutterStageHunk:Gcommit --amend<cr>
" }}}

" Git Functions {{{
function! GitBranchPoint()
  return system('git log --graph --oneline -99 | grep -A 1 -E ''^\* [0-9a-f]{7}'' | cut -c 5-11 | tail -1')
endfunction
command! DiffBranchPoint execute(':Gvdiff ' . GitBranchPoint())
" [d]iff [v]isually, same as fugitives mapping
nnoremap <Leader>dv :DiffBranchPoint<CR>
" }}}

