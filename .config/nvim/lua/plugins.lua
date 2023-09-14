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
  -- Core 
  'nvim-lua/plenary.nvim',
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    config = function()
      require('nvim-treesitter.configs').setup {
        ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
          enable = true,          -- false will disable the whole extension
          additional_vim_regex_highlighting = {
            'markdown'
          }
        },
        indent = {
          enable = true,
        },
      }
    end
  },

  -- Looks
  {
    'akinsho/bufferline.nvim',
    opts   = {
      options = {
        hover = {
          enabled = true
        },
        separator_style = 'slope',
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          local icon = level:match("error") and " " or " "
          return " " .. icon .. count
        end,
        groups = {
            items = {
               -- require('bufferline.groups').builtin.pinned:with({ icon = "" })
            }
        },
        indicator = {
          style = 'underline'
        },
        diagnostics = 'nvim_lsp',

      }
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    opts = {
      options = {
        globalstatus = true
      },
      sections = {
          lualine_c = {
             function ()
                return require('auto-session.lib').current_session_name()
            end
        }
      }
    },
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  'nvim-tree/nvim-web-devicons',
  'rcarriga/nvim-notify',

  -- Tools
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify'
    },
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true
      }
    }
  },
  {
    'stevearc/oil.nvim',
    config = true
  },
  {
    'NvChad/nvterm',
    config = true
  },
  {
    'folke/which-key.nvim',
    config = true
  },
  {
    "rmagatti/auto-session",
    opts = {
      auto_session_suppress_dirs = {'/home/kiwi'},
      auto_session_use_git_branch = true
    }
  },

  -- Themes
  {
    'EdenEast/nightfox.nvim',
    config = function ()
      vim.cmd('colorscheme carbonfox')
    end
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
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons'
    },
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


  -- Telescope plugins
  'nvim-telescope/telescope-dap.nvim',
  'nvim-telescope/telescope-ui-select.nvim',
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    build =
    'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build'
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
      require('telescope').load_extension('ui-select')
    end
  },
  {
    "rmagatti/session-lens",
    requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = true
  },

  -- Language LSPs
  'mfussenegger/nvim-jdtls',
  'jbyuki/nabla.nvim',
  'scalameta/nvim-metals',
  {
    'folke/neoconf.nvim',
    config = true
  },
  'simrat39/rust-tools.nvim',
  'mfussenegger/nvim-dap-python',
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = { 'BufReadPre /var/home/javst/Documents/Sync/DND/**.md'},
    dependencies = {
      'nvim-lua/plenary.nvim',
      'hrsh7th/nvim-cmp',
      'nvim-telescope/telescope.nvim',
      'preservim/vim-markdown',
    },
    opts = {
      dir = '~/Documents/Sync/DND/',
      completion = {
        nvim_cmp = true,
      },
      disable_frontmatter = true,
      templates = {
        subdir = "Templates",
        date_format = "%Y-%m-%d-%a",
        time_format = "%H:%M"
      }
    }
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
    "folke/flash.nvim",
    event = "VeryLazy",
    opts = {
      modes = {
        search = {
          enabled = true,
          highlight = {
            backdrop = true
          }
        }
      }
    },
    keys = {
      { "s", mode = { "n", "x", "o" }, function() require("flash").jump({
        search = { max_length = 2 },
        jump = { autojump = true }
      }) end, desc = "Flash" },
      { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
      { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
    },
  },
  {
    'chentoast/marks.nvim',
    config = true
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.ai').setup()
      require('mini.surround').setup({
        mappings = {
          add = ' sa',      -- Add surrounding in Normal and Visual modes
          delete = ' sd',   -- Delete surrounding
          find = ' sf',     -- Find surrounding (to the right)
          find_left = ' sF', -- Find surrounding (to the left)
          highlight = ' sh', -- Highlight surrounding
          replace = ' sr',  -- Replace surrounding
          update_n_lines = ' sn', -- Update `n_lines`

          suffix_last = 'l', -- Suffix to search with "prev" method
          suffix_next = 'n', -- Suffix to search with "next" method
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  },

  -- Git
  'sindrets/diffview.nvim',
  {
    'NeogitOrg/neogit',
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      disable_signs = false
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    opts = {
      attach_to_untracked = false,
    },
  },
})
