return require('packer').startup(function() 
  use 'romgrk/barbar.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'marko-cerovac/material.nvim'
  use 'norcalli/nvim-colorizer.lua'
  use 'kyazdani42/nvim-web-devicons'
  use 'kyazdani42/nvim-tree.lua'
  use 'rcarriga/nvim-notify'
  use 'NvChad/nvterm' 
  use 'folke/which-key.nvim'

--  use 'ahmedkhalf/project.nvim'
--  use 'Shatur/neovim-session-manager'
  use 'pwntester/octo.nvim'

  use 'neovim/nvim-lspconfig'
  use 'williamboman/nvim-lsp-installer'
  use {'ms-jpq/coq_nvim', run = ':COQdeps'}
  use 'ms-jpq/coq.artifacts'
  use 'ms-jpq/coq.thirdparty'
  use 'j-hui/fidget.nvim'
  use 'simrat39/symbols-outline.nvim'
  use 'stevearc/dressing.nvim'
  use 'SmiteshP/nvim-navic'
  
  use 'mfussenegger/nvim-dap'
  use 'rcarriga/nvim-dap-ui'
  use 'theHamsta/nvim-dap-virtual-text'

  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
  use 'nvim-lua/plenary.nvim'

  use 'nvim-telescope/telescope.nvim'
  use 'nvim-telescope/telescope-dap.nvim'
  use 'aloussase/telescope-gradle.nvim'
  use {'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' }
  
  use 'mfussenegger/nvim-jdtls'
  use 'scalameta/nvim-metals'
  use 'lervag/vimtex'

  use 'lukas-reineke/indent-blankline.nvim'
  use 'karb94/neoscroll.nvim'
  use 'NMAC427/guess-indent.nvim'
  use 'windwp/nvim-autopairs'

  use 'Olical/conjure'
end)
