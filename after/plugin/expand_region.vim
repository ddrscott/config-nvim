if !exists('*expand_region#custom_text_objects')
  finish
endif

" Warning: takes over visual mode. Get use to it! Totally Sweet!
"          Defaults to `viw` which is usually what I want anyway.
vmap v <Plug>(expand_region_expand)
vmap V <Plug>(expand_region_shrink)

call expand_region#custom_text_objects('ruby', {
      \ 'ir' :0,
      \ 'ar' :1,
      \ })
