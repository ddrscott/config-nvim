" ctag helpers {{{
command! Ctag !ctags --verbose --languages=ruby --recurse -f tags .
command! CtagBundle !ctags --verbose --languages=ruby --recurse -f gem.tags $(bundle list --paths | grep -v $(pwd))
command! Rtag !ripper-tags -R -f tags .
command! RtagBundle !ripper-tags -R -f gem.tags $(bundle list --paths | grep -v $(pwd))
" }}}
