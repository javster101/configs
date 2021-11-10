set mouse=a
set ttyfast
set expandtab
set shiftwidth=4
set number

vmap <C-C> "+y
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>i
vnoremap <C-s> <Esc>:w<CR>

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd BufWinEnter term://* startinsert

call plug#begin('~/.local/share/nvim/plugged')

Plug 'tpope/vim-sensible'
Plug 'ryanoasis/vim-devicons'
Plug 'ms-jpq/chadtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim'
Plug 'tree-sitter/tree-sitter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'joshdick/onedark.vim'
call plug#end()

syntax on
colorscheme onedark

highlight Normal ctermbg=none
highlight NonText ctermbg=none


autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && 
			\ isdirectory(argv()[0]) && !exists('s:std_in') |
			\ execute 'cd' .argv()[0] | execute CHADopen | endif

lua << EOF

require'lspconfig'.jdtls.setup{ cmd = {'jdtls'} }

EOF

