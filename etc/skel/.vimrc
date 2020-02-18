
set nocompatible

if has("syntax")
  syntax on
endif

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
  filetype plugin indent on
endif

set backspace=indent,eol,start " make backspace more flexible
set showmatch       " show matching brackets
set cursorline      " highlight current line

set laststatus=2    " always show the status line
set ruler           " show the line and column number of the cursor position
set showcmd         " show command in bottom bar
set report=0        " show report on changes to file, 0 means all changes
set wildmenu        " visual autocomplete for command menu

set background=dark
set number          " show line numbers
set numberwidth=4   " minimal number of columns to use for the line number
set scrolloff=4     " minimal screen margin to keep above and below the cursor
set colorcolumn=80

set hlsearch        " highlight matches
set incsearch       " search as characters are entered
set ignorecase      " use case insensitive matching
set smartcase       " use smart case matching
set nowrapscan

set shiftwidth=4    " number of spaces to use for each step of indent
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in TAB when editing
set expandtab       " tabs are spaces
set autoindent

set autowrite       " automatically save before commands like :next and :make
set nobackup        " don't make backup files
set hidden          " hide buffers when they are abandoned
set updatetime=100
set tags+=tags;/

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

nmap <F3> :NERDTreeFind<CR>
nmap <F4> :NERDTreeToggleVCS<CR>
let g:NERDTreeDirArrowExpandable='▶'
let g:NERDTreeDirArrowCollapsible='▼'

nmap <F8> :TagbarToggle<CR>
let g:tagbar_sort=0
let g:tagbar_type_scala={
  \ 'ctagstype' : 'scala',
  \ 'sro'       : '.',
  \ 'kinds'     : [
    \ 'p:packages',
    \ 'T:types:1',
    \ 't:traits',
    \ 'o:objects',
    \ 'O:case objects',
    \ 'c:classes',
    \ 'C:case classes',
    \ 'm:methods',
    \ 'V:values:1',
    \ 'v:variables:1'
  \ ]
\ }

autocmd FileType scala setlocal shiftwidth=2 tabstop=2 softtabstop=2

