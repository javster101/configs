set mouse=a
set ttyfast
set expandtab
set shiftwidth=4
set number
set nowrap
set termguicolors
set splitbelow

vmap <C-C> "+y
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>i
vnoremap <C-s> <Esc>:w<CR>

call plug#begin('~/.local/share/nvim/plugged')

Plug 'ms-jpq/chadtree'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'norcalli/nvim-colorizer.lua'

Plug 'neovim/nvim-lspconfig'
Plug 'ms-jpq/coq_nvim'
Plug 'ms-jpq/coq.artifacts'
Plug 'ms-jpq/coq.thirdparty'

Plug 'nvim-lualine/lualine.nvim'
Plug 'mfussenegger/nvim-jdtls'

Plug 'marko-cerovac/material.nvim'
Plug 'lervag/vimtex'
Plug 'kosayoda/nvim-lightbulb'

Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

Plug 'aloussase/gradle.vim'
Plug 'Olical/aniseed'

Plug 'lukas-reineke/indent-blankline.nvim'
Plug 'karb94/neoscroll.nvim'

call plug#end()

syntax on

highlight Normal guibg=none
highlight NonText guibg=none

autocmd VimEnter * if argc() == 0 && getcwd() == "/home/javst" | e notes.txt | endif

lua << EOF
vim.g.bufferline = {
  auto_hide = true,
}

require('material').setup({

	contrast = true, -- Enable contrast for sidebars, floating windows and popup menus like Nvim-Tree
	borders = false, -- Enable borders between verticaly split windows

	popup_menu = "dark", -- Popup menu style ( can be: 'dark', 'light', 'colorful' or 'stealth' )

	italics = {
		comments = true, -- Enable italic comments
		keywords = false, -- Enable italic keywords
		functions = false, -- Enable italic functions
		strings = false, -- Enable italic strings
		variables = false -- Enable italic variables
	},

	disable = {
		background = true, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
		term_colors = false, -- Prevent the theme from setting terminal colors
		eob_lines = false -- Hide the end-of-buffer lines
	},
})

vim.g.material_style = "deep ocean"
vim.cmd 'colorscheme material'

require('colorizer').setup()
require('lualine').setup {
  options = {
    theme = 'material-nvim'
  }
}

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}

require('telescope').load_extension('fzf')

opts = { noremap = true, silent = true}

require('neoscroll').setup()

vim.api.nvim_set_keymap('', '<M-n>', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', 'fg', '<cmd>Telescope live_grep<cr>', opts)

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

vim.cmd [[
set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]]

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

lspconfig.pylsp.setup{}
lspconfig.pylsp.setup(coq.lsp_ensure_capabilities())

lspconfig.ccls.setup(cpp_config)
lspconfig.ccls.setup(coq.lsp_ensure_capabilities(cpp_config))



EOF

