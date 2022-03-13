scriptencoding utf-8
set encoding=utf-8

set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin()
Plug 'bling/vim-airline'
Plug 'preservim/tagbar'
" Plug 'rust-lang/rust.vim'
call plug#end()            " required

filetype plugin indent on    " required

nnoremap <C-]> g<C-]>
set list listchars=tab:→\ ,trail:·
" set colorcolumn=80
"
syntax enable
set background=dark

syntax on
set number              " activate line numbers
set noerrorbells visualbell t_vb=
" set tabstop=4
" set expandtab
" set softtabstop=4
" set shiftwidth=4
set encoding=utf-8
set wildmenu
set clipboard=unnamed
set smartindent
set showmatch
set tags=tags;/,~/.vim/tags_gtk,~/.vim/tags_pthread
" set tw=120
" set wrap linebreak nolist "
"------------General-----------"
"set foldenable
"set foldmethod=syntax

"------------Search------------"
set hlsearch
set incsearch

"----------Split management----------"
set splitbelow
set splitright

nmap <C-J> <C-W><C-J>
nmap <C-K> <C-W><C-K>
nmap <C-L> <C-W><C-L>
nmap <C-H> <C-W><C-H>



"----------Visuals-------------"
if has('gui_running')
    set background=dark
    set guifont=Inconsolata\ 13
    set guioptions-=l
    set guioptions-=L
    set guioptions-=r
    set guioptions-=R
    set guioptions-=e
    set guioptions-=m
    set guioptions-=T
endif

hi LineNr guibg=bg
hi foldcolumn guibg=bg
hi vertsplit guifg=bg guibg=bg


"-----------Mappings-----------"
nmap <Leader>ev :e $MYVIMRC<cr>
nmap <M-1> :NERDTreeToggle<cr>
nmap <M-R> :CtrlPBufTag<cr>
nmap <M-e> :CtrlPMRUFiles<cr>
nmap <Leader>f :tag<space>
nmap <M-2> :TagbarToggle<cr>
nmap <Leader>cd :cd %:p:h<cr>:pwd<CR>

" Search highlight removal
nmap <Leader><space> :nohlsearch<cr>

"-----------Auto-Commands----------"

augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

fun! StripTrailingWhitespace()
    " Don't strip on these filetypes
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
" Map the K key to the ReadMan function:
map <S-F11> :call ReadMan()<CR>CR
