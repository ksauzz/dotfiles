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
set showmode
set laststatus=2 " always show status lines.
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

" horizontally split on QuickRun
let g:quickrun_config = { '*': { 'split': ''}}
" neocomplcache enable
let g:neocomplcache_enable_at_startup = 1

" keymap
inoremap <C-j> <DOWN>
inoremap <C-k> <UP>
inoremap <C-l> <RIGHT>
inoremap <C-h> <LEFT>

nnoremap <ESC><ESC> :nohlsearch<CR>
