set mouse=a
set ttyfast
set expandtab
set shiftwidth=4
set number
set nowrap

vmap <C-C> "+y
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>i
vnoremap <C-s> <Esc>:w<CR>

autocmd TermOpen * setlocal nonumber norelativenumber
autocmd BufWinEnter term://* startinsert

call plug#begin('~/.local/share/nvim/plugged')

Plug 'nvim-lualine/lualine.nvim'
Plug 'ms-jpq/chadtree'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim'
Plug 'nvim-treesitter/nvim-treesitter'
Plug 'nvim-lualine/lualine.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'joshdick/onedark.vim'
Plug 'lervag/vimtex'
Plug 'kosayoda/nvim-lightbulb'

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


require('lualine').setup()
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  sync_install = false, -- install languages synchronously (only applied to `ensure_installed`)
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
    -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
    -- Using this option may slow down your editor, and you may see some duplicate highlights.
    -- Instead of true it can also be a list of languages
    additional_vim_regex_highlighting = false,
  },
}

EOF

