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
Plug 'ms-jpq/coq.artifacts'
Plug 'ms-jpq/coq.thirdparty'

Plug 'nvim-lualine/lualine.nvim'
Plug 'mfussenegger/nvim-jdtls'
Plug 'joshdick/onedark.vim'
Plug 'lervag/vimtex'
Plug 'kosayoda/nvim-lightbulb'

call plug#end()

syntax on
colorscheme onedark

set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()

highlight Normal ctermbg=none
highlight NonText ctermbg=none

autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && getcwd() == "/home/javst" | e notes.txt | endif
autocmd VimEnter * if argc() == 1 && 
			\ isdirectory(argv()[0]) && !exists('s:std_in') |
			\ execute 'cd' .argv()[0] | execute :CHADopen | endif

lua << EOF

require('lualine').setup()

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.showmode = false
vim.g.coq_settings = {
  auto_start = 'shut-up',
  keymap = {
    recommended = false,
    jump_to_mark = "<c-,>"
  },
  clients = {
    paths = {
      path_seps = {
        "/"
      }
    },
    buffers = {
      match_syms = true
    }
  },
  display = {
    ghost_text = {
      enabled = true
    }
  }
}


EOF

