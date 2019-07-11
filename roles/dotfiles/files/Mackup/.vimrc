set shell=bash                " as we're using fish shell, let's set bash explicitally or some plugins may not work
set nocompatible              " be iMproved, required
filetype off                  " required
set backspace=2               " Backspace deletes like most programs in insert mode
set hidden                    " hide buffers instead of closing them
set smartcase                 " ignore case if search pattern is all lowercase, case-sensitive otherwise

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" fast saving
nmap <leader>w :w!<cr>
nmap <leader>q :q!<cr>
"
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>b :CtrlPBuffer<cr>
nmap <leader><Tab> :bnext<cr>
nmap <leader><S-Tab> :bprevious<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile
 
" Set utf8 as standard encoding and en_US as the standard language
set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')
" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" My Custom plugins
Plugin 'dracula/vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'fatih/vim-go'
Plugin 'scrooloose/nerdtree'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'slashmili/alchemist.vim'
Plugin 'elixir-editors/vim-elixir'
Plugin 'flazz/vim-colorschemes'


" All of your Plugins eust be added before the following line
call vundle#end()            " required

filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch fod - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line
"
colorscheme dracula

syntax enable           " enable syntax processing
set number              " show line numbers
set showcmd             " show command in bottom bar
set cursorline 		" highlight current line
set wildmenu            " visual autocomplete for command menu
set tabstop=2 		" number of visual spaces per TAB 
set softtabstop=2	" number of spaces in tab when editing
set expandtab       	" tabs are spaces
filetype indent on      " load filetype-specific indent files
set wildmenu            " visual autocomplete for command menu
set lazyredraw          " redraw only when we need to.
set showmatch           " highlight matching [{()}]
inoremap fd <esc>       " escape is something  little far away 

" Make it obvious where 80 characters is
set textwidth=80
set colorcolumn=+1

" Use The Silver Searcher https://github.com/ggreer/the_silver_searcher
" The Silver Searcher
if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" machine specific vim customizations
if !empty(glob("~/.vimrc.local"))
  source ~/.vimrc.local
endif

