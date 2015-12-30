## My vim setup using submodule and pathogen

Once the git is cloned, run:

    git submodule init
    git submodule update

Modify vimrc as needed.

To update the submodules, run:

    git submodule foreach git pull origin master

Plugins I used to make Vim a great PHP IDE:

* [pathogen](https://github.com/tpope/vim-pathogen): one plugin to rule them all
* [nerdtree](https://github.com/scrooloose/nerdtree): tree structure file organization
* [tagbar](https://github.com/majutsushi/tagbar): jump to definition (requires ctags or Exuberant ctags)
* [DBGPavim](https://github.com/brookhong/DBGPavim): make vim a DBGP debugger (requires Xdebug)
* [neocomplcache](https://github.com/Shougo/neocomplcache.vim): super powerful autocompletion
* [syntastic](https://github.com/scrooloose/syntastic): language syntax checkup
* [php-doc](https://github.com/kebingyu/php-doc): lightweight PHP commenter
* [fugitive](https://github.com/tpope/vim-fugitive): git wrapper
* [obsession](https://github.com/tpope/vim-obsession): easy session controll
