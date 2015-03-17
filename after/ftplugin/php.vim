" php-doc
let g:pdv_cfg_Author    = 'Kebing Yu (kyu@quinstreet.com)'
let g:pdv_cfg_Copyright = 'Copyright (c) 2011 Quinstreet, Inc. (www.quinstreet.com)'
let g:pdv_cfg_License   = 'All rights reserved'
let g:pdv_print_access  = 0
let g:pdv_print_name    = 0

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
