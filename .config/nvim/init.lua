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


require('guess-indent').setup {
  auto_cmd = true,
  buftype_exclude = {
    "help",
    "nofile",
    "terminal",
    "prompt",
  },
}

require('material').setup()

vim.g.material_style = 'deep ocean'
vim.cmd 'colorscheme material'

require('fidget').setup()
require('colorizer').setup()
require('nvim-autopairs').setup()
require('which-key').setup()
require('nvterm').setup()
require('nvim-tree').setup {
  respect_buf_cwd = true,
  update_cwd = true,
  update_focused_file = {
    enable = true,
    update_cwd = true
  },
}

require('bufferline').setup {
  diagnostics = "nvim_lsp"
}

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
require('telescope').load_extension('gradle')
require('telescope').load_extension('dap')

navic = require('nvim-navic')
navic.setup()

require('lualine').setup {
  options = {
    theme = 'material',
    globalstatus = true
  },
  sections = {
    lualine_c = {
      { navic.get_location, cond = navic.is_available },
    }
  }
}

opts = { noremap = true, silent = true }
vim.keymap.set('', '<M-n>', '<cmd>Telescope find_files<cr>', opts)
vim.keymap.set('', 'fg', '<cmd>Telescope live_grep<cr>', opts)
vim.keymap.set('', ' t', '<cmd>lua require("nvterm.terminal").toggle "horizontal"<CR>', opts)

vim.g.symbols_outline = {
  width = 20,
}

require 'nvim-treesitter.configs'.setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true, -- false will disable the whole extension
    additional_vim_regex_highlighting = false
  },
  indent = {
    enable = true,
  },

}

vim.cmd [[
set foldlevel=99
set foldmethod=expr
set foldexpr=nvim_treesitter#foldexpr()
]]

vim.o.completeopt = 'menuone,noselect,noinsert'
vim.o.showmode = false

require('dapui').setup()
require("nvim-dap-virtual-text").setup()
require('leap').add_default_mappings()
require('trouble').setup({
  position = "left"
})

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

local saga = require("lspsaga")
saga.init_lsp_saga({
  code_action_lightbulb = {
    enable = false
  }
})

require('cmake').setup({})
require('mason').setup()
local mason_lspconfig = require('mason-lspconfig')
mason_lspconfig.setup()

vim.diagnostic.config({
 -- virtual_text = false,
})

local enhance_server_opts = {
  ["clangd"] = function(opts)
    opts.cmd = {
      "clangd",
      "--background-index",
      "--suggest-missing-includes",
      "--clang-tidy",
      "--completion-style=detailed"
    }
  end,
}

local on_attach = function(client, buffer)
  require('lspcfg').load_keybinds(client, buffer)
end


mason_lspconfig.setup_handlers({
  function(server)
    local opts = {
      capabilities = require('cmp_nvim_lsp').default_capabilities(),
      on_attach = on_attach,
    }

    if enhance_server_opts[server] then
      enhance_server_opts[server](opts)
    end
    if server == 'jdtls' then
      return
    end
    require('lspconfig')[server].setup(opts)
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'scala,sbt',
  callback = function()
    require('scala').load_language()
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'java',
  callback = function()
    require('java').load_language()
  end
})

vim.api.nvim_create_autocmd('VimEnter', {
  command = 'if argc() == 0 && getcwd() == $HOME | e notes.txt | endif'
})
