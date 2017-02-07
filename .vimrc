set nocompatible              " be iMproved, required
set relativenumber
set number
syntax on
filetype off
set splitright
"...
colorscheme distinguished 

set tabstop=2 softtabstop=0 expandtab shiftwidth=2 smarttab
set backspace=2
set backspace=indent,eol,start

set winwidth=110
set winminwidth=40
set winheight=30
set winminheight=5
	
set nobackup
set nowritebackup
set noswapfile


execute pathogen#infect()
"" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
Plugin 'tpope/vim-surround'
Plugin 'scrooloose/nerdtree'
Plugin 'jiangmiao/auto-pairs'
Plugin 'tpope/vim-endwise'
Plugin 'pangloss/vim-javascript'
Plugin 'mxw/vim-jsx'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'powerline/powerline'
Plugin 'mattn/emmet-vim'
Plugin 'othree/yajs.vim'
Plugin 'fatih/vim-go'
Plugin 'maksimr/vim-jsbeautify'
Plugin 'othree/javascript-libraries-syntax.vim'
Plugin 'tpope/vim-commentary'
Plugin 'Valloric/YouCompleteMe'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
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

" Powerline
set rtp+=/Users/edgargonzalez/Library/Python/2.7/lib/python/site-packages/powerline/bindings/vim

" Always show statusline
set laststatus=2

" Use 256 colours (Use this setting only if your terminal supports 256 colours)
set t_Co=256

" let g:syntastic_ruby_checkers = ['rubocop'] 
" let g:syntastic_javascript_checkers = ['eslint']

" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_loc_list_height=3

" let g:syntastic_error_symbol = '❌ '
" let g:syntastic_style_error_symbol = '⁉️ '
" let g:syntastic_warning_symbol = '⚠️ '
" let g:syntastic_style_warning_symbol = '💩 '

" ignores certain files defined in ~/.ctrpignore from showing up in fuzzy search
let g:ctrlp_user_command = 'find %s -type f | grep -v "`cat ~/.ctrlpignore`"'

" Allow JSX in JS file
" let g:jsx_ext_required = 0 
" let g:syntastic_javascript_eslint_exe = 'npm run eslint --'
" let local_eslint = finddir('node_modules', '.;') . '/.bin/eslint'
" if matchstr(local_eslint, "^\/\\w") == ''
"   let local_eslint = getcwd() . "/" . local_eslint
" endif
" if executable(local_eslint)
"   let g:syntastic_javascript_eslint_exec = local_eslint
" endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
