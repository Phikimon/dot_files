set nocompatible
filetype off

"------------ General -----------"
syntax enable
syntax on
set ft=vim  " default syntax

" Activate line numbers
set number
" Don't beep and don't flash
set noerrorbells visualbell t_vb=
" Something to do with vim and system clipboard relations
set clipboard=unnamed
" Autoindents new line the same as previous
set smartindent
" Show matching brace
set showmatch

"-----------Plugins----------------"

set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
  Plugin 'VundleVim/Vundle.vim'
  Bundle 'L9'
  Plugin 'tpope/vim-fugitive'
  Bundle 'FuzzyFinder'
  Plugin 'bling/vim-airline'
  Plugin 'vim-airline/vim-airline-themes'
  Plugin 'josuegaleas/jay'
  Plugin 'tagbar'
  Plugin 'morhetz/gruvbox'
  " Plugin 'whatyouhide/vim-lengthmatters'
call vundle#end()
filetype plugin indent on

"/ Ctrl-P
let g:ctrlp_custom_ignore = 'DS_Store\git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

" Toggle Tagbar on opening the file?
nmap <F8> :TagbarToggle<CR>
"autocmd VimEnter * TagbarToggle

"------ Highlight some whitespace errors shit ------"
set encoding=utf-8
set list listchars=tab:→\ ,trail:·

"------ Highlight column ------"
" set colorcolumn=80

"------ Force vim to autocomplete in bash way ------"
set wildmode=longest,list,full
set wildmenu

"------------ Autowrap after tw characters? -----------"
" set tw=120
" set wrap linebreak nolist

"------------ Tabs or spaces? -----------"
" Acronis fellas use tabs
" set tabstop=4
" set expandtab
" set softtabstop=4
" set shiftwidth=4

"------------ Tags -----------"
set tags=tags;/ " Lookup tags also in parent directories recursively
" If there are multiple options to jump on a tag, let me choose
nnoremap <C-]> g<C-]>

"------------Fold file on open?-----------"
"set foldenable
"set foldmethod=syntax

"------------Search------------"
" Highlight matches
set hlsearch
" Use incremental search
set incsearch
" If there is no capital letters in
" the search patter, perform case-insensitive
" search
set ignorecase
set smartcase

"----------Split management----------"
set splitbelow
set splitright

" Move quickly between panes
nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>

"-----------Auto-Commands----------"

fun! StripTrailingWhitespace()
    if &ft =~ 'diff'
        return
    endif
    %s/\s\+$//e
endfun
autocmd BufWritePre * call StripTrailingWhitespace()

au BufNewFile,BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix |

autocmd BufRead,BufNewFile *.strace set filetype=strace

"----------- Read mans in vim -------"

fun! ReadMan()
" Assign current word under cursor to a script variable:
let s:man_word = expand('<cword>')
" Open a new window:
:exe ":wincmd n"
" Read in the manpage for man_word (col -b is for formatting):
:exe ":r!man ". s:man_word . "| col -b"
" Goto first line...
:exe ":goto"
" and delete it:
:exe ":delete"
:exe ":set syntax=man"
endfun
"Map the K key to the ReadMan function:
map <S-F11> :call ReadMan()<CR>CR
