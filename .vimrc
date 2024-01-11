scriptencoding utf-8
set encoding=utf-8

set nocompatible
filetype off

" curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
"    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

" call plug#begin()
" Plug 'bling/vim-airline'
" Plug 'preservim/tagbar'
" Plug 'lervag/vimtex'
" Plug 'fatih/vim-go'
" call plug#end()

filetype plugin indent on

nnoremap <C-]> g<C-]>
set list listchars=tab:→\ ,trail:·
augroup yaml_settings
  autocmd!
  autocmd FileType yaml setlocal list listchars=tab:→\ ,trail:·,space:·
augroup END

" set colorcolumn=80
"
syntax enable
set background=dark

syntax on
set number              " activate line numbers
set noerrorbells visualbell t_vb=

augroup jssettings
    autocmd!
    autocmd FileType javascript setlocal tabstop=4
    autocmd FileType javascript setlocal expandtab
    autocmd FileType javascript setlocal softtabstop=4
    autocmd FileType javascript setlocal shiftwidth=4
augroup END

set encoding=utf-8
set wildmenu
set clipboard=unnamed
set smartindent
set showmatch
function! SetTagsPath()
    " Start with the directory of the current file
    let l:current_dir = expand('%:p:h')
    let l:tags_list = []

    " Loop until we reach root (/) or an empty directory (for Windows)
    while l:current_dir != '/' && l:current_dir != ''
        " Add the potential tags path to our list
        let l:tags_list += [l:current_dir . '/tags']

        " Move to the parent directory
        let l:current_dir = fnamemodify(l:current_dir, ':h')
    endwhile

    " Set the tags option to our comma-separated list of potential paths
    set tags&   " Reset to default first
    let &tags = join(l:tags_list, ',')
endfunction

" Call our function every time you enter a buffer
autocmd BufEnter * call SetTagsPath()
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
tnoremap <Esc> <C-\><C-n>
au BufRead,BufNewFile *.mipsasm set syntax=mips

" Vimtex config
let g:vimtex_view_method = 'skim'

" Most VimTeX mappings rely on localleader and this can be changed with the
" following line. The default is usually fine and is the symbol "\".
let maplocalleader = ","

let g:vimtex_view_general_viewer
        \ = '/Applications/Skim.app/Contents/SharedSupport/displayline'
let g:vimtex_view_general_options = '-r @line @pdf @tex'

" This adds a callback hook that updates Skim after compilation
"augroup vimtex_compilation
"    au!
"    au User VimtexEventCompileSuccess call UpdateSkim()
"augroup END
"
"function! UpdateSkim()
"    let l:out = b:vimtex.out()
"    let l:tex = expand('%:p')
"    let l:cmd = [g:vimtex_view_general_viewer, '-r']
"    if !empty(system('pgrep Skim'))
"    call extend(l:cmd, ['-g'])
"    endif
"    if has('nvim')
"    call jobstart(l:cmd + [line('.'), l:out, l:tex])
"    elseif has('job')
"    call job_start(l:cmd + [line('.'), l:out, l:tex])
"    else
"    call system(join(l:cmd + [line('.'), shellescape(l:out), shellescape(l:tex)], ' '))
"    endif
"endfunction
set dictionary=/usr/share/dict/words
let g:tex_IgnoredWarnings =
    \'Underfull'."\n".
    \'Overfull'."\n".
    \'specifier changed to'."\n".
    \'You have requested'."\n".
    \'Missing number, treated as zero.'."\n".
    \'There were undefined references'."\n".
    \'Citation %.%# undefined'."\n".
    \'Double space found.'."\n"
let g:Tex_IgnoreLevel = 8
