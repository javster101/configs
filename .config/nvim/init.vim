set mouse=a
set ttyfast
set expandtab
set shiftwidth=4
set number
set nowrap
set termguicolors
set splitbelow
set signcolumn=yes
set updatetime=100
augroup highlight_yank
  autocmd!
  autocmd TextYankPost * silent! lua require('vim.highlight').on_yank()
augroup END

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

require('material').setup()

vim.g.material_style = 'deep ocean'
vim.cmd 'colorscheme material'

require('octo').setup()
require('fidget').setup()
require('colorizer').setup()
require('nvim-autopairs').setup()
-- require('project_nvim').setup()
require('which-key').setup()
require('nvterm').setup()
-- require('session_manager').setup({})
require('nvim-tree').setup {
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
}


require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    }
  }
}
require('telescope').load_extension('fzf')
require('telescope').load_extension('gradle')
require('telescope').load_extension('dap')
-- require('telescope').load_extension('projects')

navic = require('nvim-navic')
-- navic.setup()

require('lualine').setup {
  options = {
    theme = 'material'
  },
  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available },
    }
  }
}

opts = { noremap = true, silent = true}
vim.api.nvim_set_keymap('', '<M-n>', '<cmd>Telescope find_files<cr>', opts)
vim.api.nvim_set_keymap('', 'fg', '<cmd>Telescope live_grep<cr>', opts)
vim.api.nvim_set_keymap('', ' t', '<cmd>lua require("nvterm.terminal").toggle "horizontal"<CR>', opts)

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
    require('nvim-navic').attach(client, bufnr)
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

