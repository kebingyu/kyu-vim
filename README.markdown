## My vim setup using submodule and pathogen

Once the git is cloned, run:

    git submodule init
    git submodule update

Modify vimrc as needed.

To update the submodules, run:

    git submodule foreach git pull origin master

Plugins I used to make Vim a great PHP IDE:

* pathogen: one plugin to rule them all
* nerdtree: tree structure file organization
* taglist: jump to definition (requires Ctags)
* DBGPavim: step-by-step debugging (requires Xdebug)
* neocomplcache: super powerful autocompletion
* syntastic: language syntax checkup
* php-doc: lightweight commenter
* fugitive: git wrapper
* obsession: session controll
