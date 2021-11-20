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

Plug 'ms-jpq/chadtree'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

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

require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true,
  },

}

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

local on_attach = function(client, buffer)
    require('lspcfg').load_keybinds(client, buffer)
 end


cpp_config = {
    on_attach = on_attach,
    compilationDatabaseDirectory = "build";
}

local coq = require('coq')
local lspconfig = require('lspconfig')
lspconfig.ccls.setup(cpp_config)
lspconfig.ccls.setup(coq.lsp_ensure_capabilities(cpp_config))



EOF

