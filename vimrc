"
" Environment {"{{{
	set nocompatible
	execute pathogen#infect()
	execute pathogen#helptags()
	let s:vim_path        = $HOME."/.vim/"
	let s:working_path    = "/var/www/sites/"
	let s:tag_base_path   = s:vim_path."tags/"
	let s:vim_bundle_path = s:vim_path."bundle/"
" }"}}}
"
" General {"{{{
	set history=100
    set undolevels=1000
	set background=dark					" assume a dark background
	filetype plugin indent on			" indent automatically depending on filetype
	syntax on							" syntax highlighting
    set synmaxcol=128
    set ttyfast                         " a fast terminal
    set ttyscroll=3
    set lazyredraw
	"set mouse=a						" automatically enable mouse usage
	scriptencoding utf-8
    set fileencodings=utf-8,gb2312,gbk,gb18030
    set termencoding=utf-8
	set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore				" allow for cursor beyond last character
	"set spell							" spell checking on
	set ffs=unix,dos,mac
	set nobackup
	set noswapfile
	let mapleader = ","					" do extra key combinations with a map leader 
	"set autochdir						" automatically change working dir to current opened file
	set sessionoptions=blank,buffers,curdir,folds,globals,help,localoptions,options,resize,tabpages,winsize,winpos
" }"}}}
"
" Vim UI {"{{{
    if has("gui_running")
        if has("gui_macvim")
            set guifont=Menlo\ Regular:h14
        elseif has("gui_win32")
            set guifont=Consolas:h11:cANSI
        else 
            set guifont=DejaVu\ Sans\ Mono\ 10
        endif
    else 
	    set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
    endif
	set t_Co=256
	colorscheme wombat256mod
    "colorscheme PaperColor
	"set cursorline			" hightlight current line
	"set cursorcolumn
	set laststatus=2		" always show status line even when only one file open
	if has("statusline")
		set statusline=%<%f								" Filename
		set statusline+=\ %w%h%m%r						" Options
		set statusline+=\ [%{HasPaste()}]				" check paste
		"set statusline+=\ [%{getcwd()}]				" current dir
		"set statusline+=\ [A=\%03.3b/H=\%02.2B]		" ASCII / Hexadecimal value of char
		set statusline+=%=
		set statusline+=%#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}	" display syntax error by Syntastic plugin
		set statusline+=%*
		set statusline+=\ [%{&ff}/%Y]					" filetype
		set statusline+=\ \ %-14.(%l,%c%V%)\ %p%%		" Right aligned file nav info
		hi StatusLine   ctermbg=25 ctermfg=white		" active status line
		hi StatusLineNC ctermbg=237 ctermfg=245			" inactive status line
	endif
	set ru
	set backspace=start,indent,eol
	set ic					" case insensitive search
	set hls					" highlight search
	set incsearch			" Show the next match while entering a search
	"set lbr				" wrap text instead of being on one line
	set wildmenu			" enable wildmenu
	set wildmode=longest:full
	set winminheight=0		" windows can be 0 line high
	" ignore these files while expanding wild chars
	set wildignore+=.svn,CVS,.git
	set wildignore+=*.o,*.a,*.class,*.mo,*.la,*.so,*.lo,*.la,*.obj,*.pyc
	set wildignore+=*.exe,*.zip,*.jpg,*.png,*.gif,*.jpeg
	"set list
    "set listchars=tab:>.,trail:.,extends:#,nbsp:. " Highlight problematic whitespace
	set splitbelow
	set cmdheight=2
" }"}}}
"
" Formatting {"{{{
    " line margin when moving cursor, use 999 to keep the cursor centered when switching buffer.
    " See http://vim.wikia.com/wiki/Avoid_scrolling_when_switch_buffers
	set scrolloff=999
	set wrapscan
	"set paste						" prevent vim from adding incremented tabs when pasting
	set ai							" auto increment: not compatible with paste
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	set expandtab
	set ts=4
	set sw=4
	set softtabstop=4 				" let backspace delete indent
    "set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
    augroup vimrc_autocmd
        " clear autogroup
        autocmd!
        autocmd BufWritePost ~/.vim/vimrc source %
        " highlight current line when entering a new window
        "autocmd WinEnter * setlocal cursorline
        "autocmd WinLeave * setlocal nocursorline
        " filetype
        autocmd FileType c,cpp,cc  set cindent
        autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd FileType js setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
        autocmd FileType html,xhtml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
        autocmd FileType php set omnifunc=phpcomplete#CompletePHP
        " remove '-' from word end list
        autocmd FileType php setlocal iskeyword-=-
        au BufRead,BufNewFile *.vue set filetype=html
        "au BufRead,BufNewFile *.mtml set filetype=xhtml
        "au BufRead,BufNewFile *.js set syntax=jquery
        " save/load view
        "au BufWinLeave * silent! mkview	" make vim save view (state) (folds, cursor, etc)
        "au BufWinEnter * silent! loadview	" make vim load view (state) (folds, cursor, etc)
    augroup END
	set foldmethod=marker
	" set row length and highlight text goes over
	set textwidth=120
	set formatoptions+=t
	set wrapmargin=1
	"if exists('+colorcolumn')
		"set colorcolumn=100
	"else
		"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
	"endif
	highlight OverLength ctermbg=16 ctermfg=7 guibg=blue
	match OverLength /\%121v.\+/
" }"}}}
"
" Key Mapping {"{{{
	" Ctrl+kjhl Navigation between splitted windows
    " Stop scrolling when switching buffer: Hmx - remember window position; xzt - restore window position
	map <C-J> Hmx`` \|<C-W>j<C-W>_`xzt``
	map <C-K> Hmx`` \|<C-W>k<C-W>_`xzt``
	map <C-H> <C-W>h<C-W>_
	map <C-L> <C-W>l<C-W>_
	" maximize the current window
	map <C-M> <C-W>_
	" move the current window up
	map <C-Z> <C-K><C-W><C-X><C-W>_
	" move the current window down
	map <C-X> <C-W><C-X><C-J>
	if bufwinnr(1)
		map + <C-W>+
		map - <C-W>-
	endif
    " open nerdtree and tagbar at the same time
	nmap <silent> <C-N> :call ToggleAll()<CR>

	" redraw the screen and clear search highlights
	nmap <leader>l :nohls<cr>
	" save when you forget sudo
	noremap <leader>W :w !sudo tee % > /dev/null
	" close all windows but the current
	map <leader>o <C-W><C-O>
    " close the current window and max the next focused one
    map <leader>q <c-w>q<c-w>_
    " open file in current directory
    "map <leader>e :e <C-R>=expand("%:p:h") . '/' <CR>
	" vimgrep
	nmap <leader>n :cn<cr>
	nmap <leader>p :cp<cr>
    " list search result
	nmap <leader>w :cw<cr>
    " Search word under current cursor within the directory of current file
    map <leader>f :execute "vimgrep /" . expand("<cword>") . "/j " . expand("%:h") . "/**" <Bar> cw<CR>
    
	" Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk
	nnoremap Y y$
    " check php sytax for the current file
	nmap <leader>pl :!php -l %:p<cr>
    " documentor
    inoremap <C-P> <ESC>:call DocDefault()<CR>i
    nnoremap <C-P> :call DocDefault()<CR>
    " PHPUnit
    " run all tests in test folder
    nmap <Leader>pa :!clear && ./vendor/bin/phpunit<cr>
    " run all tests in current file
    nmap <Leader>pf :!clear && ./vendor/bin/phpunit %<cr>
    " run test name under cursor
    nmap <Leader>pm yiw:!clear && ./vendor/bin/phpunit --filter "<cr>
" }"}}}
"
" Plugins {"{{{
	" neocomplcache configuration
	exec ":source ".s:vim_path."neocomplcache.conf"
	" disable preview scratch window
	set completeopt-=preview

    " tagbar
    let g:tagbar_width=30
    let g:tagbar_show_linenumbers=-1
    let g:tagbar_foldlevel=0
	nmap <leader>tt :TagbarToggle<cr>

	" ctags
	" load tag file when open vim
	autocmd VimEnter * exec ":call Addtags()" 
	"map <C-Y> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
	" open definition in a split window
	map <C-Y> <C-W><C-]>
	" goto definition
	map <leader>j <C-W>g]
	" load/unload tag files
	nmap <leader>a :call Addtags()<cr>
	nmap <leader>d :call Deltags()<cr>

	" NERDTree
	let NERDTreeShowBookmarks=1
	let NERDTreeBookmarksFile=s:vim_path.'.NERDTreeBookmarks'
	let NERDTreeShowFiles=1
	let NERDTreeShowHidden=1
	" Use a single click to fold/unfold directories and a double click to open files
	let NERDTreeMouseMode=2
	let NERDTreeIgnore=[ '\.pyo$', '\.py\$class$', '^\.svn$', '^\.git$' ]
	"autocmd VimEnter * NERDTree  "open nerdtree when open vim
	"autocmd VimEnter * wincmd p  "put cursor to the file opened 
	nmap <leader>tn :NERDTreeToggle<cr>

    " ctrlp
    let g:ctrlp_open_new_file = 'h'
    let g:ctrlp_custom_ignore='node_modules\DS_Store\|git'
    let g:ctrlp_match_window='top,order:ttb,min:1,max:30,results:30'
    nmap <F2> :CtrlPMixed<CR>
    nmap <F3> :CtrlPTag<CR>
    nmap <F3> :CtrlPMRUFiles<CR>

    " syntastic
    let g:syntastic_php_checkers=['php', 'phpcs']
    let g:syntastic_php_phpcs_args='--standard=PSR2 -n'
    let g:syntastic_mode_map = { 'passive_filetypes': ['html'] }
	nmap <leader>s :SyntasticReset<CR>

    " neosnippet
    imap <leader>e <Plug>(neosnippet_expand_or_jump)
    smap <expr><TAB> neosnippet#expandable_or_jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
    let g:neosnippet#enable_snipmate_compatibility = 1
    let g:neosnippet#snippets_directory = '~/.vim/snippets'
    let g:neosnippet#disable_runtime_snippets = {'_' : 1}
" }"}}}
"
" My Functions {"{{{
	" load ctags tagfiles
	" to use, type :call Addtags(). One file has to be opened currently
	if !exists("*Addtags")
		function Addtags() 
			let l:name = tolower(matchstr(getcwd(), '\zs\/.*\/\ze/\=\zs\S\+\ze/\=$'))
            let l:tag_path = s:tag_base_path.l:name
			if isdirectory(l:tag_path)
                for l:fpath in split(globpath(l:tag_path, '*'), '\n')
				    exec "set tags+=".l:fpath
                endfor
				echohl ModeMsg | echo "Succ to add tags! [path: ".l:tag_path."]" | echohl None
			else
				echohl WarningMsg | echo "Fail to add tags! Folder path does not exits.[path: ".l:tag_path."]" | echohl None
			endif
		endfunction
	endif

	" unload ctags tagfiles
	if !exists("*Deltags")
		function Deltags()
			let l:name = tolower(matchstr(getcwd(), '\zs\/.*\/\ze/\=\zs\S\+\ze/\=$'))
            let l:tag_path = s:tag_base_path.l:name
			if isdirectory(l:tag_path)
                for l:fpath in split(globpath(l:tag_path, '*'), '\n')
				    exec "set tags-=".l:fpath
                endfor
				echohl ModeMsg | echo "Succ to del tags! [path: ".l:tag_path."]" | echohl None
			else
				echohl WarningMsg | echo "Fail to del tags! Folder path does not exits.[path: ".l:tag_path."]" | echohl None
			endif
		endfunction
	endif

	" show diff between the currently edited file and its unmodified version in the filesystem
	" To get out of diff view you can use the :diffoff command.
	function! s:DiffWithSaved()
		let filetype=&ft
		diffthis
		vnew | r # | normal! 1Gdd
		diffthis
		exe "setlocal bt=nofile bh=wipe nobl noswf ro ft=" . filetype
	endfunction
	com! DiffSaved call s:DiffWithSaved()

	" Toggle Nerdtree and tagbar at the same time
	if !exists("*ToggleAll")
		function ToggleAll()
			"TagbarToggle
            NERDTreeToggle
	        autocmd VimEnter * wincmd p  "put cursor to the file opened 
		endfunction
	endif

    function! HasPaste()
        if &paste
            return 'PASTE MODE '
        en
        return ''
    endfunction

    " default documentor for php/js
    func! DocDefault()
        let l:paste = &g:paste
        let &g:paste = 1
        " Line for the comment to begin
        let commentline = line (".") - 1
        let l:indent = matchstr(getline("."), '^\ *')
        exe "norm! " . commentline . "G$"
        " Local indent
        let l:txtBOL = 'norm! o' . indent
        let l:eol = ""
        exe l:txtBOL . '/**' . l:eol
        exe l:txtBOL . ' *  ' . l:eol
        " Close the comment block.
        exe l:txtBOL . ' */' . l:eol
        let &g:paste = l:paste
    endfunc
" }"}}}
" 
" Use local vimrc if available {"{{{
	if filereadable(expand(s:vim_path."vimrc.local"))
		exec ":source ".s:vim_path."vimrc.local"
    endif
" }"}}}
"
" Macros"{{{
let @a="i<template></template><script>export default {}</script>"
""}}}
"
" Tips:"{{{
"   - Update current vimrc :so % (use when vimrc is the current file) or :source $MYVIMRC
"   - Marks
"       - Type ':marks' to show all marks
"       - Type 'm<capital_letter>' to set mark and '<capital_letter> to go to mark
"   - Search: '\' to search below and '?' to search above.
"   - Macros
"       - Type '"<register_letter>p' to spit out the recorded macro.
"       - Then use 'let @<register_letter>=' to save it for future use.
""}}}
"
