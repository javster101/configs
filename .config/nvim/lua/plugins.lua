return require('packer').startup(function()
  use {'ms-jpq/chadtree', run =':CHADdeps'}
  use 'romgrk/barbar.nvim'
  use 'nvim-lualine/lualine.nvim'
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  
  use 'neovim/nvim-lspconfig'
  use {'ms-jpq/coq_nvim', run = ':COQdeps'}
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'

  use 'marko-cerovac/material.nvim'
  use 'kosayoda/nvim-lightbulb'

  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  use 'nvim-lua/plenary.nvim'
  use 'nvim-telescope/telescope.nvim'

  use 'aloussase/gradle.vim'
  use 'mfussenegger/nvim-jdtls'
  use 'lervag/vimtex'

  use 'lukas-reineke/indent-blankline.nvim'
  use 'karb94/neoscroll.nvim'

  use 'Olical/aniseed'
  use 'Olical/conjure'

end)
