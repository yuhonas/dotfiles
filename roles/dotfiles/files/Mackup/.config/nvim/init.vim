
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" change the leader key from "\" to ";" ("," is also popular)
let mapleader="\<Space>"

" :W sudo saves the file
" (useful for handling the permission-denied error)
command! W w !sudo tee % > /dev/null

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:vim_plugged_path=stdpath('data') . '/plugged'

if empty(glob(g:vim_plugged_path))
   silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
     \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
   autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
 endif

call plug#begin(g:vim_plugged_path)
" general plugins
Plug 'editorconfig/editorconfig-vim'
Plug 'jiangmiao/auto-pairs'
Plug 'junegunn/fzf', { 'dir': '~/.vim/fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rsi'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible' " https://www.rogin.xyz/blog/sensible-neovim
Plug 'tpope/vim-surround'
Plug 'dylanaraps/wal'
Plug 'godlygeek/tabular'
Plug 'freitass/todo.txt-vim'
Plug 'jceb/vim-orgmode'
Plug 'ervandew/supertab'
Plug 'inkarkat/vim-ReplaceWithRegister'

" Plug 'wincent/terminus'
" Plug 'jamessan/vim-gnupg', { 'branch': 'main' }
" Plug 'justinmk/vim-sneak'

" git
" Plug 'airblade/vim-gitgutter'
" Plug 'jreybert/vimagit'
" Plug 'ruanyl/vim-gh-line'

" " All of your Plugins must be added before the following line
call plug#end()


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""A

" Height of the command bar
set cmdheight=2

"set shell=bash                " as we're using fish shell, let's set bash explicitally or some plugins may not work

" Configure backspace so it acts as it should act
"set backspace=2               " Backspace deletes like most programs in insert mode
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase


" Don't redraw while executing macros (good performance config)
set lazyredraw

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set mat=2


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" https://alex.dzyoba.com/blog/vim-revamp/

" https://github.com/tmux/tmux/issues/1246
" if exists('+termguicolors')
"   let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

"syntax enable           " enable syntax processing

try
   colorscheme wal
   " set background=dark
catch
endtry

" Set utf8 as standard encoding and en_US as the standard language
" set encoding=utf8

" Use Unix as the standard file type
set ffs=unix,dos,mac


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git etc anyway...
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" tabs are spaces
set expandtab

"" Be smart when using tabs ;)
""set smarttab

"" number of visual spaces per TAB
set tabstop=2

"" number of spaces in tab when editing
"set softtabstop=2

"" Make it obvious where 80 characters is
set textwidth=120

set shiftwidth=2

" set colorcolumn=+1

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
nmap <leader>b :Buffers<cr>
nmap <leader>fl :GFiles<cr>
nmap <leader>Fl :Files<cr>
nmap <leader>fs :w!<cr>
nmap <leader>fr :History<cr>
nmap <leader>t :Tags<cr>
nmap <leader>/ :Ag<cr>
nmap <leader>? :Lines<cr>
" nmap <leader>ft :NERDTreeToggle<cr>
nmap <leader>ft :Vexplore<cr>
nmap <leader><Tab> :bnext<cr>
nmap <leader><S-Tab> :bprevious<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Close the current buffer
map <leader>bd :bd<cr>:tabclose<cr>gT

" Close all the buffers
map <leader>ba :bufdo bd<cr>

" Buffer navigation
map <leader>l :bnext<cr>
map <leader>h :bprevious<cr>

" Useful mappings for managing tabs
map <leader>tn :tabnew<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tm :tabmove
map <leader>t<leader> :tabnext

" Let 'tl' toggle between this and the last accessed tab
let g:lasttab = 1
nmap <Leader>tl :exe "tabn ".g:lasttab<CR>
au TabLeave * let g:lasttab = tabpagenr()


" Opens a new tab with the current buffer's path
" Super useful when editing files in the same directory
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>


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

set number              " show line numbers
" set showcmd             " show command in bottom bar
" set cursorline 		" highlight current line
" inoremap fd <esc>       " escape is something  little far away

" NERDTree Configuration
" let g:NERDTreeChDirMode=1
" nmap <leader>ftf :NERDTreeFind<CR> “ pressing this inside any open file in vim will jump to the nerdtree and highlight where that file is -> very useful when you have multiple files open at once

" FZF Configuration
" Customize fzf colors to match your color scheme
let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

" custom status line
" https://shapeshed.com/vim-statuslines/
set laststatus=2
function! GitBranch()
  return system("git rev-parse --abbrev-ref HEAD 2>/dev/null | tr -d '\n'")
endfunction

function! StatuslineGit()
  let l:branchname = GitBranch()
  return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

set statusline=%#PmenuSel#
set statusline+=%{StatuslineGit()}
" set statusline+=%#LineNr#
set statusline+=%#Title#
set statusline+=\ %f
" set statusline+=%m\
set statusline+=%=
set statusline+=%#CursorColumn#
set statusline+=\ %y
set statusline+=\ %{&fileencoding?&fileencoding:&encoding}
set statusline+=\[%{&fileformat}\]
set statusline+=\ %p%%
set statusline+=\ %l:%c

" Config for vim-surround
" These conflict with vim-rsi
let g:AutoPairsShortcutFastWrap = '' " default: '<M-b>'
let g:AutoPairsShortcutBackInsert = '' " default '<M-b>'

"" editorconfig configuration
"" ensure that this plugin works well with Tim Pope's fugitive, use the following patterns array:
"let g:EditorConfig_exclude_patterns = ['fugitive://.\*']

"" coc configuration
"" https://github.com/neoclide/coc.nvim
"" Use tab for trigger completion with characters ahead and navigate.
"" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"      \ pumvisible() ? "\<C-n>" :
"      \ <SID>check_back_space() ? "\<TAB>" :
"      \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! s:check_back_space() abort
"  let col = col('.') - 1
"  return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
"" Coc only does snippet and additional edit on confirm.
"inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
"" Or use `complete_info` if your vim support it, like:
"inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

"" Remap keys for gotos
"nmap <silent> gd <Plug>(coc-definition)
"nmap <silent> gy <Plug>(coc-type-definition)
"nmap <silent> gi <Plug>(coc-implementation)
"nmap <silent> gr <Plug>(coc-references)
""nmap <silent> gs <Plug>(coc-references)
"map <leader>gs :CocList outline<cr>

"" Use K to show documentation in preview window
"nnoremap <silent> K :call <SID>show_documentation()<CR>

"function! s:show_documentation()
"  if (index(['vim','help'], &filetype) >= 0)
"    execute 'h '.expand('<cword>')
"  else
"    call CocAction('doHover')
"  endif
"endfunction

"" Highlight symbol under cursor on CursorHold
"autocmd CursorHold * silent call CocActionAsync('highlight')

"" Remap for rename current word
"nmap <leader>rn <Plug>(coc-rename)

"" Remap for format selected region
"xmap <leader>f  <Plug>(coc-format-selected)

"" Easymotion config
"" https://github.com/easymotion/vim-easymotion
"" <Leader>f{char} to move to {char}
"map  <Leader>f <Plug>(easymotion-bd-f)
"nmap <Leader>f <Plug>(easymotion-overwin-f)

"" s{char}{char} to move to {char}{char}
""nmap s <Plug>(easymotion-overwin-f2)

"" Move to line
"map <Leader>L <Plug>(easymotion-bd-jk)
"nmap <Leader>L <Plug>(easymotion-overwin-line)

"" Move to word
"map  <Leader>w <Plug>(easymotion-bd-w)

" machine specific vim customizations
if filereadable(expand('~/.vimrc.local'))
  source ~/.vimrc.local
endif

" https://sw.kovidgoyal.net/kitty/faq.html#using-a-color-theme-with-a-background-color-does-not-work-well-in-vim
" let &t_ut=''

" disable ex-mode, I accidently hit it *way* too often
map Q <Nop>
