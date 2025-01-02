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

local signs = { Error = "", Warn = "", Hint = "󰌶", Info = "" }
local kind_icons = {
  Text = "",
  Method = "",
  Function = "󰊕",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
  Copilot = ""
}


for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

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

vim.lsp.inlay_hint.enable(true)
require 'lspconfig'.gdscript.setup {}
require('mason-lspconfig').setup_handlers({
  function(server)
    local opts = {
      capabilities = {
        textDocument = {
          foldingRange = {
            dynamicRegistration = false,
            lineFoldingOnly = true
          }
        }
      }
    }

    if enhance_server_opts[server] then
      enhance_server_opts[server](opts)
    end

    opts.capabilities = require('blink.cmp').get_lsp_capabilities(opts.capabilities)
    require('lspconfig')[server].setup(opts)
  end,
  ['jdtls'] = function()
    local opts = {
      capabilities = capabilities,
      init_options = {
        extendedClientCapabilities = require('jdtls').extendedClientCapabilities
      },
      settings = {
        java = {
          signatureHelp = { enabled = true }
        }
      },
      cmd = {
        'jdtls',
        '--jvm-arg=-Xmx8G',
        '-configuration', '/var/home/javst/.cache/jdtls/config',
        '-data', '/var/home/javst/.cache/jdtls/workspace'
      },
      root_dir = vim.fs.dirname(vim.fs.find({ 'gradlew', 'build.gradle', '.git', 'mvnw' }, { upward = true })[1]),
      flags = {
        allow_incremental_sync = true
      },
      on_attach = function(client, buffer)
        -- require('jdtls').setup_dap() --{ hotcodereplace = 'auto' })
        require('jdtls.setup').add_commands()
        general_attach(client, buffer)
      end
    }

    vim.api.nvim_create_autocmd('FileType', {
      pattern = 'java',
      callback = function()
        require('jdtls').start_or_attach(opts)
      end
    })
  end,
  ['rust_analyzer'] = function()
    -- Autoruns with rustaceanvim
  end
})

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
