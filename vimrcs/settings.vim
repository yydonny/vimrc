"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
behave xterm
set langmenu=none

filetype plugin on
filetype indent on

set autoread
set history=70

set lazyredraw 

set magic

set hidden

set clipboard+=unnamed

let mapleader = ","
let g:mapleader = ","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => User interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has("win16") || has("win32")
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

set ruler
set number
set showcmd
set showmode

set ambiwidth=double

set title
set mouse=

set backspace=eol,start,indent
set whichwrap=b,s

set cmdheight=1
set scrolloff=7
set foldcolumn=1

set ignorecase
set smartcase

set hlsearch
set incsearch 

set showmatch 
set matchtime=1

set noerrorbells
set novisualbell
set t_vb=
set tm=500


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => File formats and encodings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set fileformats=unix,dos,mac
set fileformat=unix

set fileencodings=utf-8
set encoding=utf-8
let &termencoding = &encoding


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Backup and swap file
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nobackup
set nowb
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Indent and line-wrap
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set expandtab
set smarttab

set shiftwidth=2
set tabstop=2

set autoindent
set smartindent

set linebreak
set textwidth=120

set nowrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => tab views, status line, autocmds
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Specify the behavior when switching between buffers 
try
    set switchbuf=useopen,usetab,newtab
    set stal=2
catch
endtry

" Return to last edit position when opening files (You want this!)
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif
" Remember info about open buffers on close
set viminfo^=%

set laststatus=2

set statusline=\ %{HasPaste()}%F%m%r%h\ %w\ \ CWD:\ %r%{getcwd()}%h\ \ \ Line:\ %l

func! DeleteTrailingWS()
    exe "normal mz"
    %s/\s\+$//ge
    exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" Returns true if paste mode is enabled
function! HasPaste()
    if &paste
        return 'PASTE MODE  '
    en
    return ''
endfunction


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Syntax, fount, and GUI related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable

colorscheme desert

if has("gui_running")
		set guioptions=
		set t_Co=256
endif

" Set font according to system
if has("mac") || has("macunix")
    set gfn=Menlo:h14
    set shell=/bin/bash
elseif has("win16") || has("win32")
    set gfn=Consolas:h9
    set gfw=NSimSun:h9
elseif has("linux")
    set gfn=Monospace\ 10
    set shell=/bin/bash
endif

" Open MacVim in fullscreen mode
if has("gui_macvim")
    set fuoptions=maxvert,maxhorz
    au GUIEnter * set fullscreen
endif


