" Extreme Mode Highlighting {{{
augroup extreme_insert_mode_indicator
  au InsertEnter * hi LineNr ctermfg=18 ctermbg=3
  au InsertLeave * hi LineNr ctermfg=8 ctermbg=18
augroup END
" }}}
