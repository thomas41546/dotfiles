set autoindent
set backspace=2
set smarttab
set expandtab
set nocompatible
set foldmethod=indent
set foldlevel=99
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

map <C-n> :set nu!<CR>

set mouse=r
au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

colorscheme desert
set guioptions-=m
set guioptions-=T
set guioptions-=r
set guifont=Monospace\ 9

nnoremap <c-c> :q<CR>
nnoremap <c-space> <c-w><c-w>
nnoremap <c-up> <c-w><c-s>
nnoremap <c-right> <c-w><c-v>


augroup vimrc_autocmds
    autocmd!
    autocmd FileType python highlight Excess ctermbg=DarkRed guibg=Red
    autocmd FileType python match Excess /\%81v.*/
    autocmd FileType python set nowrap
augroup END
