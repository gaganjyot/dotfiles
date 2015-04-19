syntax on
set paste
set cursorline
set colorcolumn=80
set expandtab
set tabstop=4
set shiftwidth=4
set hlsearch
colorscheme default 
set guioptions-=m  "menu bar
set guioptions-=T  "toolbar
set guioptions-=r  "scrollbar

" Undo even after exiting the file
set undofile                " Save undo's after file closes
set undodir=$HOME/.vim/undo " where to save undo histories
set undolevels=1000         " How many undos
set undoreload=10000        " number of lines to save for undo
