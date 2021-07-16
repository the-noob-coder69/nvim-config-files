syntax on
set nocompatible
"starts mouse support
set mouse=a


"shows number line on left side 
set number "relativenumber "now i think i will use gg instead of relative numbers movement or i will use :set rnu whenever i will need to delete lines relatively
"sets a ruler on left 
set ruler


"shows command keys used
set showcmd


"shows current cursor position
set cursorline


"some tab settings
set autoindent
set expandtab
set tabstop=4
set smarttab "tabstop number of spaces with <tab> key
set shiftwidth=4
set softtabstop=4
"round off indentation when using tab i thonk
set shiftround


"highlight while searching
set hlsearch
"ignores capitalisation while searching
set ignorecase
"Incremental search that shows partial matches
set incsearch
"Automatically switch search to case-sensitive when search query contains an uppercase letter
set smartcase


"don't update screen while running macro or script
"set lazyredraw


"Always try to show a paragraph’s last line.
set display+=lastline
"Use an encoding that supports unicode.
set encoding=utf-8
"Avoid wrapping a line in the middle of a word.
set linebreak
"The number of screen lines to keep above and below the cursor.
set scrolloff=2
"The number of screen columns to keep to the left and right of the cursor.
set sidescrolloff=5
"Enable syntax highlighting.
syntax enable
"Enable line wrapping.
set wrap "use :set wrap! to disable wrap

"use treesitter foldmethod
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
set foldnestmax=1
