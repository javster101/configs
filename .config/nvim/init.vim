set mouse=a
set ttyfast
set expandtab
set shiftwidth=4
set number
set nowrap
set termguicolors
set splitbelow

syntax on

autocmd VimEnter * if argc() == 0 && getcwd() == "/home/javst" | e notes.txt | endif

lua << EOF
require('plugins')

vim.g.bufferline = {
  auto_hide = true,
}


require('guess-indent').setup {
  auto_cmd = true, 
  buftype_exclude = {
    "help",
    "nofile",
    "terminal",
    "prompt",
  },
}

require('material').setup({
    contrast = {
        popup_menu = false,
    },
    italics = {
        comments = true, -- Enable italic comments
        keywords = false, -- Enable italic keywords
        functions = false, -- Enable italic functions
        strings = false, -- Enable italic strings
        variables = false -- Enable italic variables
    },
    disable = {
        background = false, -- Prevent the theme from setting the background (NeoVim then uses your teminal background)
        term_colors = false, -- Prevent the theme from setting terminal colors
        eob_lines = false -- Hide the end-of-buffer lines
    },
})

vim.g.material_style = "deep ocean"
vim.cmd 'colorscheme material'

require('fidget').setup()
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
require('telescope').load_extension('gradle')
require('telescope').load_extension('dap')

opts = { noremap = true, silent = true}
vim.api.nvim_set_keymap('', '<M-n>', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('n', 'fg', '<cmd>Telescope live_grep<cr>', opts)

require('neoscroll').setup()

vim.g.symbols_outline = {
  width = 20,
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
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

require('dapui').setup()
require("nvim-dap-virtual-text").setup()

local on_attach = function(client, buffer)
    require('lspcfg').load_keybinds(client, buffer)
end

local coq = require('coq')
local lsp_installer = require("nvim-lsp-installer")

local servers = {
  "clangd",
  "ltex"
}

for _, name in pairs(servers) do
  local server_is_found, server = lsp_installer.get_server(name)
  if server_is_found and not server:is_installed() then
    print("Installing " .. name)
    server:install()
  end
end

local enhance_server_opts = {
  ["gaming"] = function(opts)
    opts.settings = {
      format = {
        enable = true
      },
    }
  end,
}

lsp_installer.on_server_ready(function(server)
  local opts = {
    on_attach = on_attach,
  }

  if enhance_server_opts[server.name] then
    enhance_server_opts[server.name](opts)
  end

  server:setup(coq.lsp_ensure_capabilities(opts))
end)

vim.api.nvim_create_autocmd('FileType', { 
    pattern = 'scala,sbt',
    callback = function()
        require('scala').load_language()
    end
})

vim.api.nvim_create_autocmd('FileType', { 
    pattern = 'java',
    callback = function()
        require('java').load_language()
    end
})

EOF

