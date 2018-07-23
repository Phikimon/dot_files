set nocompatible              " be iMproved, required
filetype off                  " required

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
call vundle#end()            " required

filetype plugin indent on    " required
" Force ctags to deal with ambiguity tags
:nnoremap <C-]> g<C-]>
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set list listchars=tab:→\ ,trail:·

nmap <F8> :TagbarToggle<CR>
autocmd VimEnter * TagbarToggle

" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
syntax enable
set background=dark
colorscheme jay

syntax on
set ft=nasm
set number              " activate line numbers
set noerrorbells visualbell t_vb=
set tabstop=4
set expandtab
set softtabstop=4
set shiftwidth=4
set encoding=utf-8
set wildmenu
set clipboard=unnamed
set smartindent
set showmatch
set tags=tags;/,~/.vim/tags_gtk,~/.vim/tags_pthread
" set tw=120 "
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

"-----------Plugins----------------"

"/ Ctrl-P
let g:ctrlp_custom_ignore = 'DS_Store\git'
let g:ctrlp_match_window = 'top,order:ttb,min:1,max:30,results:30'

"/ NERDTree
let NERDTreeHijackNetrw = 0

"/ Syntastic
set statusline+=%#warningmsg#
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_python_python_exec = '/usr/bin/python3'

"/ ultisnips
" Trigger configuration. Do not use <tab> if you use https://github.com/Valloric/YouCompleteMe.
let g:UltiSnipsExpandTrigger="<a-j>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"

"/ YCM
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_global_ycm_extra_conf = '~/dotfiles/scripts/.ycm_extra_conf.py'
nmap <leader>j :YcmCompleter GoTo<CR>
nmap <leader>i :YcmCompleter GoToInclude<CR>
nmap <leader>k :YcmCompleter GoToDefinition<CR>
nmap <leader>h :YcmCompleter GetDoc<CR>

"/ Rust.vim
let g:rustfmt_autosave = 1
let g:ycm_rust_src_path = '~/git/rust/src'

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"-----------Auto-Commands----------"
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END

autocmd BufWritePre * :%s/\s\+$//e

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
"Map the K key to the ReadMan function:
map <S-F11> :call ReadMan()<CR>CR
