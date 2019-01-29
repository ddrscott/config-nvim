" Performs a "_d against them motion or visual selection.
func! BlackHoleDeleteOperator(type, ...)
  if a:type ==# 'char'
    execute 'normal! `[v`]"_d'
  elseif a:type ==# 'line'
    execute 'normal! `[V`]"_d'
  else
    execute 'normal! `<' . a:type . '`>"_d'
  endif
endf
" Too intrusive to accidental BS use. Keep the visual mapping cause it's neat.
" nnoremap <silent> <BS> :set opfunc=BlackHoleDeleteOperator<CR>g@
vnoremap <silent> <BS> :<C-u>call BlackHoleDeleteOperator(visualmode(), 1)<CR>
