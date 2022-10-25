return require('packer').startup(function()
  -- Looks/Tools
  use 'romgrk/barbar.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'marko-cerovac/material.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'rcarriga/nvim-notify'
  use 'NvChad/nvterm'
  use 'folke/which-key.nvim'
  use 'ggandor/leap.nvim'
  use 'tpope/vim-repeat'

  -- LSP plugins
  use 'neovim/nvim-lspconfig'
  use 'williamboman/mason.nvim'
  use 'williamboman/mason-lspconfig.nvim'
  use 'glepnir/lspsaga.nvim'

  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'ray-x/cmp-treesitter'
  use 'hrsh7th/nvim-cmp'
  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use 'folke/trouble.nvim'
  use 'j-hui/fidget.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'stevearc/dressing.nvim'
  use 'SmiteshP/nvim-navic'
  
  --DAP plugins
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-lua/plenary.nvim'

  -- Telescope plugins
  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'aloussase/telescope-gradle.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  
  -- Language LSPs/other
  use 'mfussenegger/nvim-jdtls'
  use 'scalameta/nvim-metals'
  use 'lervag/vimtex'
  use 'Shatur/neovim-cmake'
  use 'Olical/conjure'

  use 'lukas-reineke/indent-blankline.nvim'
  use 'NMAC427/guess-indent.nvim'
  use 'windwp/nvim-autopairs'

end)
