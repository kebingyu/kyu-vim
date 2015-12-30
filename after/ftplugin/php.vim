" php-doc
let g:pdv_cfg_Author    = ''
let g:pdv_cfg_Copyright = ''
let g:pdv_cfg_License   = 'All rights reserved'
let g:pdv_print_access  = 0
let g:pdv_print_name    = 0

inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
nnoremap <C-P> :call PhpDocSingle()<CR>
vnoremap <C-P> :call PhpDocRange()<CR>
