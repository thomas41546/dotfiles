set autoindent
set backspace=2
set smarttab
set expandtab
set nocompatible
set foldmethod=indent
set foldlevel=99
set colorcolumn=80
set undolevels=1000
set makeprg=python\ %
filetype plugin indent on
set pastetoggle=<F2>
set incsearch
set title
set mouse=a
set tabstop=4
set paste
set shiftwidth=4
set number
set hlsearch
set clipboard=unnamedplus
highlight Search ctermbg=blue ctermfg=white guibg=blue
filetype on
highlight OverLength ctermbg=red ctermfg=white guibg=darkred
highlight ExtraWhitespace ctermbg=darkgreen guibg=darkgreen

au BufRead,BufNewFile *.py syntax match OverLength /\%80v.\+/
au BufRead,BufNewFile *.py syntax match ExtraWhiteSpace /\s\+$\|\t/

syntax on

command C let @/=""
vmap <C-c> "+y
map <C-n> :set nu!<CR>

set mouse=r
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
colorscheme desert
