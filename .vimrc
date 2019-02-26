""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable filetype plugins
filetype plugin on

" Set to auto read when a file is changed from the outside
set autoread

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let mapleader = ","

" Fast saving
nmap <leader>w :w!<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


" Turn on the Wild menu
set wildmenu

" Ignore compiled files
set wildignore=*.0,*~
if has("win16") || has("win32")
    set wildignore+=.git\*,.hg\*,.svn\*
else
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Highlight search results
set hlsearch

" Show matching brackets when text indicator is over them
set showmatch
" How many tenths of a second to blink when matching brackets
set mat=2

" auto indent
set autoindent

" display left line numbers
set number

" command-line completion
set showcmd

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Enable syntax highlighting
syntax on


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" indent setings for using 4 spaces instead of tabs
set shiftwidth=4
set softtabstop=4
set tabstop=6
set expandtab
set smarttab

set ai "Auto indent
set si "Smart indent

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


function! BuildYCM(info)
  " info is a dictionary with 3 fields
  " - name:   name of the plugin
  " - status: 'installed', 'updated', or 'unchanged'
  " - force:  set on PlugInstall! or PlugUpdate!
  if a:info.status == 'installed' || a:info.force
    !./install.py
  endif
endfunction

" vim-plug: vim plugins. https://github.com/junegunn/vim-plug/wiki/tutorial
call plug#begin('~/.vim/plugged')

" omnisharp
" Plug 'OmniSharp/omnisharp-vim'
" you complete me
"Plug 'Valloric/YouCompleteMe', { 'do': function('BuildYCM') }
" syntastic
Plug 'vim-syntastic/syntastic'
" vim-snipmate
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
" nerd-tree menu
Plug 'scrooloose/nerdtree'
" auto-pairs
Plug 'jiangmiao/auto-pairs'

call plug#end()

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugin Settings
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" NERDTree
map <leader>n :NERDTreeToggle<CR>

" ctrlp.vim
set runtimepath^=~/.vim/bundle/ctrlp.vim

" OmniSharp plugin options
let g:OmniSharp_server_use_mono = 1

" vim-syntastic options
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

" You Complete Me options

" use Enter and Down select the first completion string
let g:ycm_key_list_select_completion = ['<Enter>', '<Down>']

" use Up to select previous completion string
let g:ycm_key_list_previous_completion = ['<Up>']
