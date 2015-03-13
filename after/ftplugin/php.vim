" php-doc
let g:pdv_cfg_Author    = "Kebing Yu"
let g:pdv_cfg_Copyright = "Copyright 2015 Quinstreet Inc."
let g:pdv_print_access = 0
let g:pdv_print_name = 0

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
