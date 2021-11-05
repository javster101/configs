set mouse=a
set ttyfast
vmap <C-C> "+y


call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim'
Plug 'tree-sitter/tree-sitter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mfussenegger/nvim-jdtls'

call plug#end()

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && 
			\ isdirectory(argv()[0]) && !exists('s:std_in') |
			\ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd' .argv()[0] | endif

lua << EOF

require'lspconfig'.jdtls.setup{ cmd = {'jdtls'} }


EOF

