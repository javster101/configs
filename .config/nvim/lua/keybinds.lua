out = {}

out.load_keybinds = function()
  -- Mappings.
  local opts = { noremap = true, silent = true }

  local wk = require('which-key')

  wk.register({
    g =  {
      d = { '<cmd>lua vim.lsp.buf.definition()<CR>', "Go to definition"},
      D = { '<cmd>lua vim.lsp.buf.declaration()<CR>', "Go to declaration"},
      p = { '<cmd>Lspsaga peek_definition<CR>', "Peek definition"},
      m = { '<cmd>lua vim.lsp.buf.implementation()<CR>', "Go to implementation"},
      r = { '<cmd>Telescope lsp_references<CR>', "Go to references"},
      f = { '<cmd>Lspsaga lsp_finder<CR>', "Find usages"},
    },
    c = {
      a = { '<cmd>lua vim.lsp.buf.code_action()<CR>', "Code action"},
      l = { '<cmd>lua vim.lsp.codelens.run()<CR>', "Run codelens"},
    },
    d = {
      c = { '<cmd>lua require("dap").continue()<CR>', "Continue"},
      K = { '<cmd>lua require("dap.ui.widgets").hover()<CR>', "Debug hover"},
      B = { '<cmd>lua require("dap").toggle_breakpoint()<CR>', "Toggle breakpoint"},
      o = { '<cmd>lua require("dap").step_over()<CR>', "Step over"},
      i = { '<cmd>lua require("dap").step_into()<CR>', "Step into"},
      r = { '<cmd>lua require("dap").run_last()<CR>', "Run previous"},
      ui = { '<cmd>lua require("dapui").toggle()<CR>', "Toggle"},
      p = { '<cmd>lua require("dap").repl.toggle()<CR>', "Toggle REPL"},
    },
    t = {
      h = { '<cmd>lua require("nvterm.terminal").toggle "horizontal"<CR>', "Open horizontal terminal"},
      v = { '<cmd>lua require("nvterm.terminal").toggle "vertical"<CR>', "Open vertical terminal"}
    },
    r = {
      n = { '<cmd>Lspsaga rename<CR>', "Rename"},
      g = { '<cmd>Telescope live_grep<CR>', "Live (rip)grep"}
    }
  })


  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', '<M-n>', '<cmd>Telescope find_files<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
--   vim.keymap.set('n', '<space>e', require("lspsaga.diagnostic").show_line_diagnostics, opts)
--   vim.keymap.set('n', '<space>[e', require("lspsaga.diagnostic").goto_prev, opts)
--   vim.keymap.set('n', '<space>]e', require("lspsaga.diagnostic").goto_next, opts)
  vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting_sync()<CR>', opts)
end

return out
