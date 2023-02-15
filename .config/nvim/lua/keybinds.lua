out = {}

out.load_keybinds = function()
  -- Mappings.
  local opts = { noremap = true, silent = true }

  local wk = require('which-key')

  wk.register({
    g = {
      d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Go to definition" },
      D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "Go to declaration" },
      p = { '<cmd>Lspsaga peek_definition<CR>', "Peek definition" },
      m = { '<cmd>lua vim.lsp.buf.implementation()<CR>', "Go to implementation" },
      r = { '<cmd>Telescope lsp_references<CR>', "Go to references" },
      f = { '<cmd>Lspsaga lsp_finder<CR>', "Find usages" },
    },
    c = {
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code action" },
      l = { '<cmd>lua vim.lsp.codelens.run()<CR>', "Run codelens" },
      i = { '<cmd>Lspsaga incoming_calls<CR>', "Go to incoming calls" },
      o = { '<cmd>Lspsaga outgoing_calls<CR>', "Go to outgoing calls" }
    },
    d = {
      c = { '<cmd>lua require("dap").continue()<CR>', "Continue" },
      K = { '<cmd>lua require("dap.ui.widgets").hover()<CR>', "Debug hover" },
      B = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', "Toggle breakpoint" },
      o = { '<cmd>lua require("dap").step_over()<CR>', "Step over" },
      i = { '<cmd>lua require("dap").step_into()<CR>', "Step into" },
      r = { '<cmd>lua require("dap").run_last()<CR>', "Run previous" },
      ui = { '<cmd>lua require("dapui").toggle()<CR>', "Toggle" },
      p = { '<cmd>lua require("dap").repl.toggle()<CR>', "Toggle REPL" },
    },
    t = {
      f = { '<cmd>Lspsaga term_toggle<CR>', "Open floating terminal"},
      h = { '<cmd>lua require("nvterm.terminal").toggle "horizontal"<CR>', "Open horizontal terminal" },
      v = { '<cmd>lua require("nvterm.terminal").toggle "vertical"<CR>', "Open vertical terminal" }
    },
    r = {
      n = { '<cmd>Lspsaga rename<CR>', "Rename" },
      g = { '<cmd>Telescope live_grep<CR>', "Live (rip)grep" }
    },
    ['<space>'] = {
      e = {
        l = { '<cmd>Lspsaga show_line_diagnostics<CR>', "Line diagnostic" },
        b = { '<cmd>Lspsaga show_buf_diagnostics<CR>', "Buffer diagnostic" },
        c = { '<cmd>Lspsaga show_cursor_diagnostics<CR>', "Cursor diagnostic" },
        [']'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', "Next diagnostic" },
        ['['] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', "Previous diagnostic" },
      },
      f = { '<cmd>lua vim.lsp.buf.format()<CR>', "Format" },
      k = { '<cmd>Lspsaga hover_doc ++keep<CR>', "Open and keep hover doc" },
    }
  })


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<M-n>', '<cmd>Telescope find_files<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
end

return out
