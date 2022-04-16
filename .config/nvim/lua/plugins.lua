return require('packer').startup(function()
  use {'ms-jpq/chadtree', run =':CHADdeps'}
  
  use 'romgrk/barbar.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'marko-cerovac/material.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  
  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {'ms-jpq/coq_nvim', run = ':COQdeps'}
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'
  use 'j-hui/fidget.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'stevearc/dressing.nvim'

  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-lua/plenary.nvim'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'aloussase/telescope-gradle.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  
  use 'mfussenegger/nvim-jdtls'
  use 'scalameta/nvim-metals'
  use 'lervag/vimtex'

  use 'lukas-reineke/indent-blankline.nvim'
  use 'karb94/neoscroll.nvim'
  use 'NMAC427/guess-indent.nvim'
  
  use 'Olical/conjure'
end)
