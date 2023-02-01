local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local packer_bootstrap = ensure_packer()

return require('packer').startup(function()
  use 'wbthomason/packer.nvim'

  -- Looks/Tools
  use {
    'akinsho/bufferline.nvim',
    config = function()
      require('bufferline').setup {
        options = {
          diagnostics = "nvim_lsp"
        }
      }
    end
  }
  use 'nvim-lualine/lualine.nvim'
  use 'marko-cerovac/material.nvim' -- setup done last in init.lua
  use {
    'norcalli/nvim-colorizer.lua',
    config = function()
      require('colorizer').setup()
    end
  }
  use 'kyazdani42/nvim-web-devicons'
  use { 'kyazdani42/nvim-tree.lua',
    config = function()
      require('nvim-tree').setup {
        respect_buf_cwd = true,
        update_cwd = true,
        update_focused_file = {
          enable = true,
          update_cwd = true
        },
      }
    end
  }
  use 'rcarriga/nvim-notify'
  use {
    'NvChad/nvterm',
    config = function()
      require('nvterm').setup()
    end
  }
  use {
    'folke/which-key.nvim',
    config = function()
      require('which-key').setup()
    end
  }
  use {
    'ggandor/leap.nvim',
    config = function()
      require('leap').add_default_mappings()
    end
  }
  use 'tpope/vim-repeat'

  -- LSP plugins
  use 'neovim/nvim-lspconfig'
  use {
    'williamboman/mason.nvim',
    config = function()
      require('mason').setup()
    end
  }
  use {
    'williamboman/mason-lspconfig.nvim',
    config = function()
      require('mason-lspconfig').setup()
    end
  }
  use {
    'glepnir/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end
  }

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'ray-x/cmp-treesitter'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {
    'folke/trouble.nvim',
    config = function()
      require('trouble').setup {
        position = "left"
      }
    end
  }
  use {
    'j-hui/fidget.nvim',
    config = function()
      require('fidget').setup()
    end
  }
  use 'stevearc/dressing.nvim'
  use 'SmiteshP/nvim-navic'

  --DAP plugins
  use 'mfussenegger/nvim-dap'
  use {
    'rcarriga/nvim-dap-ui',
    config = function()
      require('dapui').setup()
    end
  }
  use {
    'theHamsta/nvim-dap-virtual-text',
    config = function()
      require('nvim-dap-virtual-text').setup()
    end
  }

  use {
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
  }
  use 'nvim-lua/plenary.nvim'

  -- Telescope plugins
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-dap.nvim'
  use { 'nvim-telescope/telescope-fzf-native.nvim',
    run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }

  -- Language LSPs/other
  use 'mfussenegger/nvim-jdtls'
  use 'scalameta/nvim-metals'
  use {
    'Shatur/neovim-cmake',
    config = function()
      require('cmake').setup({})
    end
  }
  use 'simrat39/rust-tools.nvim'
  use {
    'mfussenegger/nvim-dap-python',
    config = function()
      require('dap-python').setup()
    end
  }

  use 'lukas-reineke/indent-blankline.nvim'
  use {
    'NMAC427/guess-indent.nvim',
    config = function()
      require('guess-indent').setup {
        auto_cmd = true,
        buftype_exclude = {
          "help",
          "nofile",
          "terminal",
          "prompt",
        },
      }
    end
  }
  use {
    'windwp/nvim-autopairs',
    config = function()
      require('nvim-autopairs').setup()
    end
  }

  if packer_boostrap then
    require('packer').sync()
  end
end)
