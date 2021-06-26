set rtp+=~/.config/nvim/bundle/Vundle.vim
call vundle#begin('~/.config/nvim/bundle')
Plugin 'gmarik/Vundle.vim'

"Plugin 'Shougo/deoplete.nvim'
"Plugin 'deoplete-plugins/deoplete-jedi'
"Plugin 'maralla/completor.vim'
Plugin 'tmhedberg/SimpylFold'
"Plugin 'dense-analysis/ale'
"Plugin 'indentpython.vim'
"Plugin 'numirias/semshi'
"Plugin 'python-syntax/python-syntax'
Plugin 'vim-airline/vim-airline'

Plugin 'fannheyward/coc-pyright'
Plugin 'neoclide/coc.nvim', {'branch': 'release'}

Plugin 'jiangmiao/auto-pairs'

"some color themes
Plugin 'joshdick/onedark.vim'
Plugin 'altercation/vim-colors-solarized'

"nerd tree and its extensions
Plugin 'preservim/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'PhilRunninger/nerdtree-visual-selection'

call vundle#end()

"let g:python_highlight_all = 1

