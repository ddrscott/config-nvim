if !exists('*textobj#user#plugin')
  finish
endif

" Any character {{{
" Thanks: https://github.com/rhysd/vim-textobj-anyblock/blob/master/plugin/textobj/anyblock.vim
call textobj#user#plugin('anyblock', {
      \ '-' : {
      \      'select-a' : 'a.', '*select-a-function*' : 'textobj#anyblock#select_a',
      \      'select-i' : 'i.', '*select-i-function*' : 'textobj#anyblock#select_i',
      \   },
      \ })
" }}}
