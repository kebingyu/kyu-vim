"
" Environment {"{{{
	set nocompatible
	execute pathogen#infect()
	execute pathogen#helptags()
	let s:vim_path        = $HOME."/.vim/"
	let s:working_path    = "/var/www/sites/"
	let s:tag_file_path   = s:vim_path."tags/"
	let s:vim_bundle_path = s:vim_path."bundle/"
" }"}}}
"
" General {"{{{
	set history=100
    set undolevels=1000
	set background=dark					" assume a dark background
	filetype plugin indent on			" indent automatically depending on filetype
	syntax on							" syntax highlighting
	"set mouse=a						" automatically enable mouse usage
	scriptencoding utf-8
    set fileencodings=utf-8,gb2312,gbk,gb18030
    set termencoding=utf-8
	set viewoptions=folds,options,cursor,unix,slash " better unix / windows compatibility
	set virtualedit=onemore				" allow for cursor beyond last character
	"set spell							" spell checking on
	"au BufWinLeave * silent! mkview	" make vim save view (state) (folds, cursor, etc)
	"au BufWinEnter * silent! loadview	" make vim load view (state) (folds, cursor, etc)
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
            set guifont=DejaVu\ Sans\ Mono\ 11
        endif
    else 
	    set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
    endif
	set t_Co=256
	colorscheme wombat256mod
	set cursorline			" hightlight current line
	" only highlight current line under cursor
	autocmd WinEnter * setlocal cursorline
	autocmd WinLeave * setlocal nocursorline
	"set cursorcolumn
	set laststatus=2		" always show status line even when only one file open
	if has("statusline")
		set statusline=%<%f								" Filename
		set statusline+=\ %w%h%m%r						" Options
		"set statusline+=\ [%{HasPaste()}]				" check paste
		"set statusline+=\ [%{getcwd()}]				" current dir
		"set statusline+=\ [A=\%03.3b/H=\%02.2B]		" ASCII / Hexadecimal value of char
		set statusline+=%=
		set statusline+=%#warningmsg#
		set statusline+=%{SyntasticStatuslineFlag()}	" display syntax error by Syntastic plugin
		set statusline+=%*
		set statusline+=\ [%{&ff}/%Y]					" filetype
		set statusline+=\ \ %-14.(%l,%c%V%)\ %p%%		" Right aligned file nav info
		hi StatusLine   ctermbg=245 ctermfg=black		" active status line
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
	set scrolloff=1					" 1 line margin when moving cursor
	set wrapscan
	"set paste						" prevent vim from adding incremented tabs when pasting
	set ai							" auto increment: not compatible with paste
	set pastetoggle=<F12>          	" pastetoggle (sane indentation on pastes)
	set expandtab
	set ts=4
	set sw=4
	set softtabstop=4 				" let backspace delete indent
	autocmd FileType c,cpp,cc  set cindent
	autocmd FileType css setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
	autocmd FileType js setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4
	autocmd FileType html,xhtml setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
	"set comments=sl:/*,mb:*,elx:*/  " auto format comment blocks
	autocmd FileType php set omnifunc=phpcomplete#CompletePHP
	"autocmd FileType c,cpp,java,php,js,perl,python,twig,xml,yml
	au BufRead,BufNewFile *.tpl set filetype=html
	au BufRead,BufNewFile *.mtml set filetype=xhtml
	au BufRead,BufNewFile *.js set syntax=jquery
	set foldmethod=marker
	" set row length and highlight text goes over
	set textwidth=100
	set formatoptions+=t
	set wrapmargin=1
	"if exists('+colorcolumn')
		"set colorcolumn=100
	"else
		"au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>100v.\+', -1)
	"endif
	highlight OverLength ctermbg=16 ctermfg=7 guibg=blue
	match OverLength /\%101v.\+/
" }"}}}
"
" Key Mapping {"{{{
	" redraw the screen and clear search highlights
	":noremap <silent> <c-l> :nohls<cr><c-l>
	nmap <leader>l :nohls<cr>
	" Ctrl+kjhl Navigation between splitted windows
	map <C-J> <C-W>j<C-W>_
	map <C-K> <C-W>k<C-W>_
	map <C-H> <C-W>h<C-W>_
	map <C-L> <C-W>l<C-W>_
	" maximize the current window
	map <C-M> <C-W>_
	" rotate the current windown downward
	map <C-X> <C-W><C-X><C-J>
	if bufwinnr(1)
		map + <C-W>+
		map - <C-W>-
	endif
	" Wrapped lines goes down/up to next row, rather than next line in file.
    nnoremap j gj
    nnoremap k gk
	nnoremap Y y$
	" load/unload tag files
	nmap <leader>a :call Addtags()<cr>
	nmap <leader>d :call Deltags()<cr>
	" load tag file when open vim
	autocmd VimEnter * exec ":call Addtags()" 
	" save when you forget sudo
	noremap <leader>W :w !sudo tee % > /dev/null
	" close all windows but the current
	map <leader>o <C-W><C-O>
	" vim grep
	nmap <leader>n :cn<cr>
	nmap <leader>w :cw<cr>
	nmap <leader>p :cp<cr>
" }"}}}
"
" Plugins {"{{{
	" include php-doc.vim (auto documentation for php)
	exec ":source ".s:vim_bundle_path."php-doc/php-doc.vim"
	inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
	nnoremap <C-P> :call PhpDocSingle()<CR>
	vnoremap <C-P> :call PhpDocRange()<CR>

	" neocomplcache configuration
	exec ":source ".s:vim_path."neocomplcache.conf"
	" disable preview scratch window
	set completeopt-=preview

	" taglist
	"let tlist_php_settings = 'php;c:class;f:function;v:variable'
	let tlist_php_settings = 'php;c:class;f:function'
	"let Tlist_Auto_Open = 1          " auto open taglist when open vim
	let Tlist_Sort_Type = "name"     " sort tags by name
	let Tlist_Use_SingleClick = 1    " single click tag name to go to tag def (default is double click)
	let Tlist_Enable_Fold_Column = 0 " disable left fold column
	let Tlist_WinWidth = 30          " set taglist width
	let Tlist_Show_One_File = 1      " only show taglist for current opened file 
	let g:Tb_ForceSyntaxEnable = 1
	let Tlist_Use_Right_Window = 1   " put taglist window to the right-hand side
	let Tlist_Max_Submenu_Items = 20 " max number of items in submenu
	"nmap <silent> <F4>  :TlistToggle<CR>        

	" ctag
	"map <C-Y> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>
	"open definition in a split window
	map <C-Y> <C-W><C-]>
	map <leader>j <C-W>g]

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
	"nmap <silent> <C-N> :NERDTreeToggle<CR>
    
    " Syntastic
	nmap <leader>s :SyntasticReset<CR>

    " Perforce vim integration
	if filereadable(expand(s:vim_path."perforce.conf"))
		exec ":source ".s:vim_path."perforce.conf"
    endif
" }"}}}
"
" My Functions {"{{{
	" load ctags tagfiles
	" to use, type :call Addtags(). One file has to be opened currently
	if !exists("*Addtags")
		function Addtags() 
            if (getcwd() =~ '/dms')
                exec "set tags+=~/.vim/tags/gcommon"
                exec "set tags+=~/.vim/tags/vcommon"
                exec "set tags+=~/.vim/tags/multivertical"
            endif 
			let l:name = tolower(matchstr(getcwd(), '\zs\/.*\/\ze/\=\zs\S\+\ze/\=$'))
			if filereadable(s:tag_file_path.l:name)
				exec "set tags+=".s:tag_file_path.l:name
				echohl WarningMsg | echo "Succ to add tags! [name: ".l:name."]" | echohl None
			else
				echohl WarningMsg | echo "Fail to add tags! No tags in this file's path.[name: ".l:name."]" | echohl None
			endif
		endfunction
	endif

	" unload ctags tagfiles
	if !exists("*Deltags")
		function Deltags()
			let l:name = tolower(matchstr(getcwd(), '\zs\/.*\/\ze/\=\zs\S\+\ze/\=$'))
			exec "set tags-=".s:tag_file_path.l:name
			if filereadable(s:tag_file_path.l:name)
				echohl WarningMsg | echo "Succ to del tags! [name: ".l:name."]" | echohl None
			else
				echohl WarningMsg | echo "Succ to del tags! But no tags in this file's path.[name: ".l:name."]" | echohl None
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

	" Toggle Nerdtree and taglist at the same time
	let s:tag_list_switch  = 0
	let s:nerd_tree_switch = 0
	if !exists("*ToggleAll")
		function ToggleAll()
		if s:tag_list_switch == 1
			TlistClose
			let s:tag_list_switch = 0
		else
			Tlist
			let s:tag_list_switch = 1
		endif
		if s:nerd_tree_switch == 1
			NERDTreeClose
			let s:nerd_tree_switch = 0
		else
			NERDTree
			let s:nerd_tree_switch = 1
		endif
		endfunction
	endif
	nmap <silent> <C-N> :call ToggleAll()<CR>

	function! HasPaste()
		if &paste
			return 'PASTE MODE '
		en
		return ''
	endfunction
" }"}}}
" 
" Use local vimrc if available {"{{{
	if filereadable(expand(s:vim_path.".vimrc.local"))
		exec ":source ".s:vim_path.".vimrc.local"
    endif
" }"}}}
