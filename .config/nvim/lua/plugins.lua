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
        ignore_install = { "comment" },
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "comment" },
          additional_vim_regex_highlighting = {
            'markdown'
          }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "<C-space>",
            node_incremental = "<C-space>",
            scope_incremental = false,
            node_decremental = "<bs>",
          },
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
    opts = {
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
    opts = function()
      local gitblame = require('gitblame')
      local auto_session = require('auto-session.lib')
      return {
        options = {
          globalstatus = true
        },
        sections = {
          lualine_c = {
            auto_session.current_session_name,
            { gitblame.get_current_blame_text, cond = gitblame.is_blame_text_available }
          }
        }
      }
    end
  },
  {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  },
  'nvim-tree/nvim-web-devicons',

  -- Tools
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    config = function()
      require('nvim-treesitter.configs').setup({
        textobjects = {
          select = {
            enable = true,
            lookahead = true,
            keymaps = {
              -- You can use the capture groups defined in textobjects.scm
              ["a="] = { query = "@assignment.outer", desc = "Select outer part of an assignment" },
              ["i="] = { query = "@assignment.inner", desc = "Select inner part of an assignment" },
              ["l="] = { query = "@assignment.lhs", desc = "Select left hand side of an assignment" },
              ["r="] = { query = "@assignment.rhs", desc = "Select right hand side of an assignment" },

              ["aa"] = { query = "@parameter.outer", desc = "Select outer part of a parameter/argument" },
              ["ia"] = { query = "@parameter.inner", desc = "Select inner part of a parameter/argument" },

              ["ai"] = { query = "@conditional.outer", desc = "Select outer part of a conditional" },
              ["ii"] = { query = "@conditional.inner", desc = "Select inner part of a conditional" },

              ["al"] = { query = "@loop.outer", desc = "Select outer part of a loop" },
              ["il"] = { query = "@loop.inner", desc = "Select inner part of a loop" },

              ["af"] = { query = "@call.outer", desc = "Select outer part of a function call" },
              ["if"] = { query = "@call.inner", desc = "Select inner part of a function call" },

              ["am"] = { query = "@function.outer", desc = "Select outer part of a method/function definition" },
              ["im"] = { query = "@function.inner", desc = "Select inner part of a method/function definition" },

              ["ac"] = { query = "@class.outer", desc = "Select outer part of a class" },
              ["ic"] = { query = "@class.inner", desc = "Select inner part of a class" },
            },
          },
          swap = {
            enable = true,
            swap_next = {
              ["<leader>na"] = "@parameter.inner", -- swap parameters/argument with next
              ["<leader>nm"] = "@function.outer", -- swap function with next
            },
            swap_previous = {
              ["<leader>pa"] = "@parameter.inner", -- swap parameters/argument with prev
              ["<leader>pm"] = "@function.outer", -- swap function with previous
            },
          },
          move = {
            enable = true,
            set_jumps = true, -- whether to set jumps in the jumplist
            goto_next_start = {
              ["]f"] = { query = "@call.outer", desc = "Next function call start" },
              ["]m"] = { query = "@function.outer", desc = "Next method/function def start" },
              ["]c"] = { query = "@class.outer", desc = "Next class start" },
              ["]i"] = { query = "@conditional.outer", desc = "Next conditional start" },
              ["]l"] = { query = "@loop.outer", desc = "Next loop start" },

              -- You can pass a query group to use query from `queries/<lang>/<query_group>.scm file in your runtime path.
              -- Below example nvim-treesitter's `locals.scm` and `folds.scm`. They also provide highlights.scm and indent.scm.
              ["]s"] = { query = "@scope", query_group = "locals", desc = "Next scope" },
              ["]z"] = { query = "@fold", query_group = "folds", desc = "Next fold" },
            },
            goto_next_end = {
              ["]F"] = { query = "@call.outer", desc = "Next function call end" },
              ["]M"] = { query = "@function.outer", desc = "Next method/function def end" },
              ["]C"] = { query = "@class.outer", desc = "Next class end" },
              ["]I"] = { query = "@conditional.outer", desc = "Next conditional end" },
              ["]L"] = { query = "@loop.outer", desc = "Next loop end" },
            },
            goto_previous_start = {
              ["[f"] = { query = "@call.outer", desc = "Prev function call start" },
              ["[m"] = { query = "@function.outer", desc = "Prev method/function def start" },
              ["[c"] = { query = "@class.outer", desc = "Prev class start" },
              ["[i"] = { query = "@conditional.outer", desc = "Prev conditional start" },
              ["[l"] = { query = "@loop.outer", desc = "Prev loop start" },
            },
            goto_previous_end = {
              ["[F"] = { query = "@call.outer", desc = "Prev function call end" },
              ["[M"] = { query = "@function.outer", desc = "Prev method/function def end" },
              ["[C"] = { query = "@class.outer", desc = "Prev class end" },
              ["[I"] = { query = "@conditional.outer", desc = "Prev conditional end" },
              ["[L"] = { query = "@loop.outer", desc = "Prev loop end" },
            },
          },
        }
      })
    end
  },
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
      auto_session_suppress_dirs = { vim.env.HOME },
      auto_session_use_git_branch = true
    }
  },

  -- Themes
  {
    'EdenEast/nightfox.nvim',
    config = function()
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

  {
    'hrsh7th/nvim-cmp',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'ray-x/cmp-treesitter',
      'L3MON4D3/LuaSnip',
      'saadparwaiz1/cmp_luasnip',
    }
  },
  {
    'folke/trouble.nvim',
    opts = {
      position = 'left'
    },
    config = true
  },

  --DAP plugins
  'mfussenegger/nvim-dap',
  {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
    end,
    lazy = true
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

  -- Language Support
  {
    'mfussenegger/nvim-jdtls',
    lazy = true
  },
  {
    'jbyuki/nabla.nvim',
    lazy = true,
  },
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm install",
    init = function()
      vim.g.mkdp_filetypes = { "markdown" }
    end,
    ft = { "markdown" },
  },
  {
    'scalameta/nvim-metals',
    lazy = true
  },
  {
    'folke/neoconf.nvim',
    config = true
  },
  {
    'simrat39/rust-tools.nvim',
    lazy = true
  },
  {
    'mfussenegger/nvim-dap-python',
    lazy = true
  },
  {
    'epwalsh/obsidian.nvim',
    lazy = true,
    event = { 'BufReadPre /var/home/javst/Documents/Sync/DND/**.md' },
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
      'kevinhwang91/promise-async',
      {
        "luukvbaal/statuscol.nvim",
        config = function()
          local builtin = require("statuscol.builtin")
          require("statuscol").setup({
            relculright = true,
            segments = {
              { text = { builtin.foldfunc },      click = "v:lua.ScFa" },
              { text = { "%s" },                  click = "v:lua.ScSa" },
              { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
            },
          })
        end,
      },
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
    }
  },
  {
    'chentoast/marks.nvim',
    config = true
  },
  {
    'echasnovski/mini.nvim',
    config = function()
      require('mini.surround').setup({
        mappings = {
          add = ' sa',            -- Add surrounding in Normal and Visual modes
          delete = ' sd',         -- Delete surrounding
          find = ' sf',           -- Find surrounding (to the right)
          find_left = ' sF',      -- Find surrounding (to the left)
          highlight = ' sh',      -- Highlight surrounding
          replace = ' sr',        -- Replace surrounding
          update_n_lines = ' sn', -- Update `n_lines`

          suffix_last = 'l',      -- Suffix to search with "prev" method
          suffix_next = 'n',      -- Suffix to search with "next" method
        },
      })
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects'
    }
  },
  {
    "ThePrimeagen/refactoring.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    lazy = true,
    config = function()
      require("refactoring").setup()
    end,
  },

  -- Git
  {
    'sindrets/diffview.nvim',
    lazy = true
  },
  {
    'pwntester/octo.nvim',
    dependences = 'nvim-lua/plenary.nvim',
    config = true
  },
  {
    'f-person/git-blame.nvim',
  },
  {
    'ruifm/gitlinker.nvim',
    dependencies = "nvim-lua/plenary.nvim",
    opts = {
      mappings = ' gy'
    },
  },
  {
    'NeogitOrg/neogit',
    lazy = true,
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
