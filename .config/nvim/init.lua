vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.mapleader = " "

vim.o.guifont = "Fira Code:h9"
vim.o.mouse = 'a'
vim.o.ttyfast = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.wrap = false
vim.o.linebreak = true
vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 100
--vim.o.syntax = true
vim.o.scrolloff = 5

vim.o.fillchars = [[eob: ,fold: ,foldopen:,foldsep: ,foldclose:]]
vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions,globals"

require('plugins')

vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = '',
      [vim.diagnostic.severity.WARN] = '',
      [vim.diagnostic.severity.INFO] = '',
      [vim.diagnostic.severity.HINT] = '󰌶',
    },
    linehl = {
      [vim.diagnostic.severity.ERROR] = 'ErrorMsg',
    },
    numhl = {
      [vim.diagnostic.severity.WARN] = 'WarningMsg',
    },
  },
})

require('keybinds').load_keybinds()

vim.g.symbols_outline = {
  width = 20,
}

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.showmode = false

vim.g.gitblame_display_virtual_text = 0
vim.g.gitblame_date_format = '%a %d %b %Y (%r)'

vim.wo.stl = require('lspsaga.symbol.winbar'):get_bar()

local enhance_server_opts = {
  ["clangd"] = function(opts)
    opts.capabilities.offsetEncoding = 'utf-8'
  end,
  ["lua_ls"] = function(opts)
    opts.settings = {
      Lua = {
        diagnostics = {
          globals = {
            'vim'
          }
        }
      }
    }
  end,
  ["pyright"] = function(opts)
    opts.root_dir = function()
      return vim.fs.dirname(vim.fs.find({ 'pyrightconfig.json', '.git' }, { upward = true })[1])
    end
    opts.on_attach = function(client, buffer)
      require('dap-python').setup('/usr/bin/python')
    end
  end,
}

local capabilities = {
  textDocument = {
    foldingRange = {
      dynamicRegistration = false,
      lineFoldingOnly = true
    }
  }
}

capabilities = require('blink.cmp').get_lsp_capabilities(capabilities)

vim.lsp.inlay_hint.enable(true)
vim.lsp.config('*', capabilities)

numbers = function(opts)
  return string.format('%s.%s', opts.lower(opts.id), opts.lower(opts.ordinal))
end

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'startinsert'
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = 'setlocal nonumber foldcolumn=0 norelativenumber signcolumn=no'
})

vim.api.nvim_create_autocmd('TermOpen', {
  pattern = '*',
  command = [[tnoremap <buffer> <Esc> <c-\><c-n>]]
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'scala,sbt',
  callback = function()
    require('scala').load_language()
  end
})

vim.api.nvim_create_autocmd('VimEnter', {
  command = 'if argc() == 0 && getcwd() == $HOME | e Documents/Sync/notes.mk | endif'
})
