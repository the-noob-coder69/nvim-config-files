set rtp+=~/.config/nvim/bundle/Vundle.vim
set rtp+=~/
call vundle#begin('~/.config/nvim/bundle')
Plugin 'gmarik/Vundle.vim'

Plugin 'vim-airline/vim-airline'    "a poggers status line

Plugin 'jiangmiao/auto-pairs'       "brackets auto-completion

"some color themes
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'jnurmine/Zenburn'

"fuzzyfinder
Plugin 'junegunn/fzf', { 'do': { -> fzf#install()  }  }
Plugin 'junegunn/fzf.vim'

"for github workflow
Plugin 'tpope/vim-fugitive'     "it's pretty poggers plugin it doesn't need a description
Plugin 'airblade/vim-rooter'    "sets git repo root as current working directory

"debugger
Plugin 'puremourning/vimspector'

"ipython terminal for running cells
Plugin 'hanschen/vim-ipython-cell', { 'for': 'python' }
Plugin 'jpalardy/vim-slime', { 'for': 'python' }

"lsp config
Plugin 'neovim/nvim-lspconfig'
Plugin 'hrsh7th/nvim-compe'
Plugin 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}  " We recommend updating the parsers on update

"test
Plugin 'equalsraf/neovim-gui-shim'

call vundle#end()
