" ===== Line numbers =====
set number              " Show absolute line numbers
set relativenumber      " Show relative line numbers (0 for the current line, distance for others)

" ===== Indentation and tabs =====
set tabstop=4           " Display width of a tab character is 4 spaces
set shiftwidth=4        " Indentation width for auto-indent and << >>
set expandtab           " Convert tabs to spaces
set smartindent         " Auto-indent new lines based on syntax

" ===== Search settings =====
set ignorecase          " Ignore case when searching
set smartcase           " Override 'ignorecase' if search pattern contains uppercase letters
set incsearch           " Show matches while typing the search pattern
set hlsearch            " Highlight all search matches

" ===== UI and experience =====
set mouse=a             " Enable mouse support
set clipboard=unnamedplus " Use the system clipboard
set termguicolors       " Enable true colors in the terminal
" set cursorline          " Highlight the current line
set scrolloff=5         " Keep at least 5 lines above/below the cursor
set signcolumn=yes      " Always show the sign column to avoid text shifting

" ===== File handling and performance =====
set encoding=utf-8      " Default internal encoding
set fileencodings=utf-8,gbk,latin1 " File encodings to try when reading files
set undofile            " Save undo history to a file
set noswapfile          " Disable swap files
set updatetime=300      " Time in ms for triggering events like CursorHold

" ===== Status line and command line =====
set laststatus=2        " Always show the status line
set cmdheight=1         " Command line height

" ===== Key mappings =====
" <leader> is a custom prefix key (default is '\')
nnoremap <leader>w :write<CR>   " Save the current file
nnoremap <leader>q :quit<CR>    " Quit
nnoremap <leader>x :xit<CR>     " Save and quit
nnoremap <leader>h :nohlsearch<CR> " Clear search highlight
inoremap jk <Esc>               " Press 'jk' in insert mode to return to normal mode
