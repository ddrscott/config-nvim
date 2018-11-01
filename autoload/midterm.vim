" More information: https://github.com/ddrscott/vim-termite
"
"
" Copyright (c) 2016 Scott Pierce
"
" MIT License
"
" Permission is hereby granted, free of charge, to any person obtaining
" a copy of this software and associated documentation files (the
" "Software"), to deal in the Software without restriction, including
" without limitation the rights to use, copy, modify, merge, publish,
" distribute, sublicense, and/or sell copies of the Software, and to
" permit persons to whom the Software is furnished to do so, subject to
" the following conditions:
"
" The above copyright notice and this permission notice shall be
" included in all copies or substantial portions of the Software.
"
" THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
" EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
" MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
" NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
" LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
" OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
" WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

" TODO uncomment when complete
" if exists('g:loaded_termite')
"   finish
" endif
" let g:loaded_termite = 1

let s:cpo_save = &cpo
set cpo&vim

function! midterm#init(...)
  call s:define_commands()

  return 1
endfunction

function! midterm#find_largest_winnr()
  let largest = 0
  let size = 0

  let i = winnr('$')
  while i > 0
    let area = winheight(i) * winwidth(i)
    if area >= size
      let largest = i
      let size = area
    endif
    let i -= 1
  endwhile
  return largest
endfunction

function! s:define_commands()
  " command! -nargs=+ -bar Plug call s:Plug(<args>)
  " if !executable('git')
  "   return s:err('`git` executable not found. Most commands will not be available. To suppress this message, prepend `silent!` to `call plug#begin(...)`.')
  " endif
  " command! -nargs=* -bar -bang -complete=customlist,s:names PlugInstall call s:install(<bang>0, [<f-args>])
  " command! -nargs=* -bar -bang -complete=customlist,s:names PlugUpdate  call s:update(<bang>0, [<f-args>])
  " command! -nargs=0 -bar -bang PlugClean call s:clean(<bang>0)
  " command! -nargs=0 -bar PlugUpgrade if s:upgrade() | execute 'source' s:esc(s:me) | endif
  " command! -nargs=0 -bar PlugStatus  call s:status()
  " command! -nargs=0 -bar PlugDiff    call s:diff()
  " command! -nargs=? -bar -bang -complete=file PlugSnapshot call s:snapshot(<bang>0, <f-args>)
endfunction

function! s:to_a(v)
  return type(a:v) == s:TYPE.list ? a:v : [a:v]
endfunction

function! s:to_s(v)
  return type(a:v) == s:TYPE.string ? a:v : join(a:v, "\n") . "\n"
endfunction

function! s:trim(str)
  return substitute(a:str, '[\/]\+$', '', '')
endfunction



let &cpo = s:cpo_save
unlet s:cpo_save

