out = {}

out.load_keybinds = function()
  -- Mappings.
  local opts = { noremap = true, silent = true }

  local wk = require('which-key')

  wk.register({
    g = {
      b = { '<cmd>BufferLinePick<CR>', "Go to buffer" },
      d = { vim.lsp.buf.definition, "Go to definition" },
      D = { vim.lsp.buf.declaration, "Go to declaration" },
      m = { vim.lsp.buf.implementation, "Go to implementation" },
      u = { '<cmd>Lspsaga lsp_finder<CR>', "Find usages" },
      p = { '<cmd>Lspsaga peek_definition<CR>', "Peek definition" },
      -- r = { '<cmd>Telescope lsp_references<CR>', "Go to references" },
      i = { '<cmd>Lspsaga incoming_calls<CR>', "Go to incoming calls" },
      o = { '<cmd>Lspsaga outgoing_calls<CR>', "Go to outgoing calls" }
    },
    ['<space>'] = {
      o = {
        t = { '<cmd>ObsidianTemplate<CR>', "Insert template"},
        ln = { '<cmd>ObsidianLinkNew<CR>', "Create from text"}
      },
      c = {
        a = { vim.lsp.buf.code_action, "Code action" },
        l = { vim.lsp.codelens.run, "Run codelens" },
      },
      d = {
        c = { require("dap").continue, "Continue" },
        K = { require("dap.ui.widgets").hover, "Debug hover" },
        B = { require("dap").toggle_breakpoint, "Toggle breakpoint" },
        o = { require("dap").step_over, "Step over" },
        i = { require("dap").step_into, "Step into" },
        r = { '<cmd>Telescope dap configurations<CR>', "Run previous" },
        ui = { require("dapui").toggle, "Toggle" },
        p = { require("dap").repl.toggle, "Toggle REPL" },
      },
      l = { require("nabla").popup, 'Render LaTEX' },
      t = {
        h = { '<cmd>lua require("nvterm.terminal").toggle "horizontal"<CR>', "Open horizontal terminal" },
        v = { '<cmd>lua require("nvterm.terminal").toggle "vertical"<CR>', "Open vertical terminal" },
        g = { '<cmd>Telescope live_grep<CR>', "Grep" },
        s = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', "Find workspace symbols" },
        b = { '<cmd>Telescope lsp_document_symbols<CR>', "Find buffer symbols" }
      },
      f = {
        b = { vim.lsp.buf.format, "Format" },
        t = { '<cmd>NvimTreeToggle<CR>', 'Open file browser' },
        f = { '<cmd>NvimTreeFindFile<CR>', 'Open file browser to current file' },
      },
      e = {
        l = { '<cmd>Lspsaga show_line_diagnostics<CR>', "Line diagnostic" },
        b = { '<cmd>Lspsaga show_buf_diagnostics<CR>', "Buffer diagnostic" },
        c = { '<cmd>Lspsaga show_cursor_diagnostics<CR>', "Cursor diagnostic" },
        [']'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', "Next diagnostic" },
        ['['] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', "Previous diagnostic" },
      },
      K = { '<cmd>Lspsaga hover_doc ++keep<CR>', "Open and keep hover doc" },
      r = {
        n = { '<cmd>Lspsaga rename<CR>', "Rename" },
      },
    },
    K = { '<cmd>Lspsaga hover_doc<CR>', "Hover doc" },
    ['-'] = { require("oil").open, "Open parent directory" },
    ['<A-t>'] = { '<cmd>Lspsaga term_toggle<CR>', "Open floating terminal", noremap = true, silent = true }
  })


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<M-n>', '<cmd>Telescope find_files<CR>', opts)
end

return out
