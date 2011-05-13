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

" cursorline highlight
set cursorline
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:hi CursorColumn cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white
:nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>
autocmd WinEnter * setlocal cursorline
autocmd WinLeave * setlocal nocursorline



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

" tab keymap
nnoremap <C-t> :tabedit<Return>
"nnoremap <C-w> :tabclose<Return>
nnoremap <C-n> :tabnext<Return>
nnoremap <C-p> :tabprevious<Return> 

nnoremap <ESC><ESC> :nohlsearch<CR>

" ZenkakuSpace highlight
if has('syntax')
  syntax enable
  function! ZenkakuSpace()
    highlight ZenkakuSpace cterm=underline ctermfg=red gui=underline guifg=red
    silent! match ZenkakuSpace /　/
  endfunction
  augroup ZenkakuSpace
    autocmd!
    autocmd VimEnter,BufEnter * call ZenkakuSpace()
  augroup END
endif
