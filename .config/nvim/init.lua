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

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

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
  sorting = {
    priority_weight = 2,
    comparators = {
      require("copilot_cmp.comparators").prioritize,

      -- Below is the default comparitor list and order for nvim-cmp
      cmp.config.compare.offset,
      -- cmp.config.compare.scopes, --this is commented in nvim-cmp too
      cmp.config.compare.exact,
      cmp.config.compare.score,
      cmp.config.compare.recently_used,
      cmp.config.compare.locality,
      cmp.config.compare.kind,
      cmp.config.compare.sort_text,
      cmp.config.compare.length,
      cmp.config.compare.order,
    },
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = false }),
    ['<C-e>'] = cmp.mapping.abort(),
    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() and has_words_before() then
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
    { name = 'copilot' },
    { name = 'nvim_lsp' },
    { name = 'path' },
    { name = 'treesitter' },
    { name = 'luasnip' },
    { name = 'buffer' }
  })
})

local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
  'confirm_done',
  cmp_autopairs.on_confirm_done()
)

local mason_path = vim.env.HOME .. '/.local/share/nvim/mason/'

local general_attach = function(client, buffer)
end

local enhance_server_opts = {
  ["clangd"] = function(opts)
    opts.capabilities.offsetEncoding = 'utf-8'
    -- opts.cmd = {
    --   "clangd",
    --   "--background-index",
    --   "--suggest-missing-includes",
    --   --  "--clang-tidy",
    --   "--completion-style=detailed"
    -- }
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
      general_attach(client, buffer)
    end
  end,
}


local capabilities = require('cmp_nvim_lsp').default_capabilities()
capabilities.textDocument.foldingRange = {
  dynamicRegistration = false,
  lineFoldingOnly = true
}
vim.lsp.inlay_hint.enable(true)
require'lspconfig'.gdscript.setup{}
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
