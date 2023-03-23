local lazypath = vim.fn.stdpath('data') .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable', -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
require('lazy').setup({
  -- Plenary
  'nvim-lua/plenary.nvim',

  -- Looks/Tools
  {
    'akinsho/bufferline.nvim',
    opts   = {
      options = {
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        diagnostics = 'nvim_lsp',
        offsets = {
          {
            filetype = 'NvimTree'
          }
        }
      }
    },
    config = true
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'SmiteshP/nvim-navic'
    },
    config = function()
      local navic = require('nvim-navic')
      require('lualine').setup {
        options = {
          theme = 'material',
          globalstatus = true
        },
        sections = {
          lualine_c = {
            { navic.get_location, cond = navic.is_available },
          }
        }
      }
    end
  },
  {
    'marko-cerovac/material.nvim',
    config = function()
      require('material').setup({
        plugins = {
          'dap', 'lspsaga', 'nvim-cmp', 'nvim-navic', 'nvim-tree', 'neogit', 'gitsigns',
          'trouble', 'which-key', 'indent-blankline', 'nvim-web-devicons'
        }
      })
      vim.g.material_style = 'deep ocean'
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  'kyazdani42/nvim-web-devicons',
  { 'nvim-tree/nvim-tree.lua',
    opts = {
      respect_buf_cwd = true,
      update_cwd = true,
      update_focused_file = {
        enable = true,
        update_cwd = true
      },
    },
    config = true
  },
  'rcarriga/nvim-notify',
  {
    'NvChad/nvterm',
    config = true
  },
  {
    'folke/which-key.nvim',
    config = true
  },

  -- LSP plugins
  'neovim/nvim-lspconfig',
  {
    'williamboman/mason.nvim',
    config = true
  },
  {
    'williamboman/mason-lspconfig.nvim',
    config = true
  },
  {
    'glepnir/lspsaga.nvim',
    config = true
  },

  'hrsh7th/cmp-nvim-lsp',
  'hrsh7th/cmp-buffer',
  'hrsh7th/cmp-path',
  'ray-x/cmp-treesitter',
  'hrsh7th/nvim-cmp',
  'L3MON4D3/LuaSnip',
  'saadparwaiz1/cmp_luasnip',
  {
    'folke/trouble.nvim',
    opts = {
      position = 'left'
    },
    config = true
  },
  {
    'jose-elias-alvarez/null-ls.nvim',
    opts = function()
      return {
        sources = {
          require('null-ls').builtins.code_actions.gitsigns,
          require('null-ls').builtins.hover.printenv,
        }
      }
    end,
    config = true
  },
  {
    'j-hui/fidget.nvim',
    config = true
  },
  'stevearc/dressing.nvim',
  {
    'SmiteshP/nvim-navic',
    config = true
  },

  --DAP plugins
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
    end
  },
  {
    'theHamsta/nvim-dap-virtual-text',
    config = true
  },

  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
          enable = true, -- false will disable the whole extension
          additional_vim_regex_highlighting = false
        },
        indent = {
          enable = true,
        },
      }
    end
  },

  -- Telescope plugins
  'nvim-telescope/telescope-dap.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
  },
  {
    'nvim-telescope/telescope.nvim',
    dependencies = {
      "nvim-telescope/telescope-dap.nvim",
      'nvim-telescope/telescope-fzf-native.nvim'
    },
    config = function()
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
      require('telescope').load_extension('dap')
    end
  },

  -- Language LSPs/other
  'mfussenegger/nvim-jdtls',
  'scalameta/nvim-metals',
  {
    'Shatur/neovim-cmake',
    config = true
  },
  {
    'folke/neoconf.nvim',
    config = true
  },
  'simrat39/rust-tools.nvim',
  {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup('/usr/bin/python')
    end
  },

  -- Editing
  'lukas-reineke/indent-blankline.nvim',
  {
    'NMAC427/guess-indent.nvim',
    opts = {
      auto_cmd = true,
      buftype_exclude = {
        "help",
        "nofile",
        "terminal",
        "prompt",
      },
    },
    config = true
  },
  {
    'windwp/nvim-autopairs',
    config = true
  },
  {
    'kevinhwang91/nvim-ufo',
    dependencies = {
      'kevinhwang91/promise-async'
    },
    config = function()
      require('ufo').setup()
    end
  },
  {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  },
  {
    'chentoast/marks.nvim',
    config = true
  },
  {
    'kylechui/nvim-surround',
    config = true
  },
  'tpope/vim-repeat',

  -- Git
  'sindrets/diffview.nvim',
  {
    'TimUntersberger/neogit',
    opts = {
      disable_signs = false
    },
    config = true
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      attach_to_untracked = false,
    },
    config = true
  },
})
