vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.o.guifont = "Fira Code:h7"
vim.o.mouse = 'a'
vim.o.ttyfast = true
vim.o.expandtab = true
vim.o.shiftwidth = 4
vim.o.number = true
vim.o.wrap = false
vim.o.termguicolors = true
vim.o.splitbelow = true
vim.o.signcolumn = 'yes'
vim.o.updatetime = 100
vim.o.syntax = true
vim.o.scrolloff = 5

vim.o.foldcolumn = '1'
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

require('plugins')

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
local kind_icons = {
  Text = "",
  Method = "",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "ﴯ",
  Interface = "",
  Module = "",
  Property = "ﰠ",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = ""
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

local luasnip = require("luasnip")
local cmp = require('cmp')

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

cmp.setup({
  formatting = {
    format = function(entry, vim_item)
      vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
      vim_item.menu = ({
        buffer = "[Buffer]",
        nvim_lsp = "[LSP]",
        luasnip = "[LuaSnip]",
        nvim_lua = "[Lua]",
        latex_symbols = "[LaTeX]",
      })[entry.source.name]
      return vim_item
    end
  },
  view = {
    entries = "custom"
  },
  snippet = {
    expand = function(args)
      require('luasnip').lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif has_words_before() then
        cmp.complete()
      else
        fallback()
      end
    end, { "i", "s" }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { "i", "s" }),
  }),
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'luasnip' },
    { name = 'buffer' }
  })
})

local mason_path = vim.env.HOME .. '/.local/share/nvim/mason/'

local general_attach = function (client, buffer)
  if client.server_capabilities.documentSymbolProvider then
    require('nvim-navic').attach(client, buffer)
  end
end

local enhance_server_opts = {
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
    opts.on_attach = function (client, buffer)
      require('dap-python').setup('/usr/bin/python')
      general_attach(client, buffer)
    end
  end,
}


local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}


require('mason-lspconfig').setup_handlers({
  function(server)
    local opts = {
      on_attach = general_attach,
      capabilities = capabilities
    }

    if enhance_server_opts[server] then
      enhance_server_opts[server](opts)
    end

    require('lspconfig')[server].setup(opts)
  end,
  ['jdtls'] = function ()
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
      root_dir = vim.fs.dirname(vim.fs.find({'gradlew', 'build.gradle', '.git', 'mvnw'}, {upward = true})[1]),
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
  ['rust_analyzer'] = function ()
    local opts = {
      capabilities = capabilities,
      settings = {
        ["rust-analyzer"] = {
          lens = {
            enable = true,
          }
        }
      },
      on_attach = function(client, buffer)
        vim.keymap.set('n', 'K', require('rust-tools').hover_actions.hover_actions, { noremap = true })
        general_attach(client, buffer)
      end
    }

    require('rust-tools').setup({
      server = opts,
      tools = {
        on_initialized = function()
          vim.api.nvim_create_autocmd({ 'BufWritePost', 'BufEnter', "CursorHold", "InsertLeave" }, {
            pattern = { "*.rs" },
            callback = function()
              local _, _ = pcall(vim.lsp.codelens.refresh)
            end,
          })
        end,
        runnables = {
          use_telescope = true
        },
      },
      hover_actions = {
        auto_focus = true,
      },
      dap = {
        adapter = require('rust-tools.dap').get_codelldb_adapter(
          mason_path .. '/bin/codelldb', mason_path .. '/packages/codelldb/extension/lldb/lib/liblldb.so'
        )
      }
    })
  end
})

local dap = require("dap")
dap.adapters.codelldb = {
  type = 'server',
  host = '127.0.0.1',
  port = 13000
}


numbers = function(opts)
  return string.format('%s.%s', opts.lower(opts.id), opts.lower(opts.ordinal))
end

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'scala,sbt',
  callback = function()
    require('scala').load_language()
  end
})

vim.api.nvim_create_autocmd('VimEnter', {
  command = 'if argc() == 0 && getcwd() == $HOME | e Documents/Sync/notes.mk | endif'
})

vim.cmd 'colorscheme material'
