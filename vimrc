filetype off
call pathogen#runtime_append_all_bundles()

syntax on
filetype plugin indent on
"colorscheme darkblue

set nocompatible
set number
set autoindent
set showcmd
set showmatch
set backspace=indent,eol,start
set ruler
set visualbell

set tabstop=2
set shiftwidth=2
set softtabstop=2
set smarttab
set expandtab

set incsearch
set hlsearch
set ignorecase

set nobackup
set nowritebackup
set swapfile

setlocal omnifunc=syntaxcomplete#Complete
set pastetoggle=<F11>

" QuickRunで横分割にする
let g:quickrun_config = { '*': { 'split': ''}}

" keymap
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>
inoremap <C-h> <LEFT>

nnoremap <ESC><ESC> :nohlsearch<CR>
