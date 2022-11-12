out = {}

out.load_keybinds = function(client, bufnr)
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Enable completion triggered by <c-x><c-o>
  buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  local opts = { noremap = true, silent = true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.keymap.set('n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.keymap.set('n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.keymap.set('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.keymap.set('n', 'df', '<cmd>Lspsaga peek_definition<CR>', opts)
  vim.keymap.set('n', 'gr', '<cmd>Telescope lsp_references<CR>', opts)
  vim.keymap.set('n', 'gh', '<cmd>Lspsaga lsp_finder<CR>', opts)
  vim.keymap.set('n', 'K', '<cmd>Lspsaga hover_doc<CR>', opts)
  vim.keymap.set('n', 'rn', '<cmd>Lspsaga rename<CR>', opts)
  vim.keymap.set('n', '<space>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.keymap.set('n', '<space>cl', '<cmd>lua vim.lsp.codelens.run()<CR>', opts)
  vim.keymap.set('n', '<space>e', require("lspsaga.diagnostic").show_line_diagnostics, opts)
  vim.keymap.set('n', '<space>[e', require("lspsaga.diagnostic").goto_prev, opts)
  vim.keymap.set('n', '<space>]e', require("lspsaga.diagnostic").goto_next, opts)
  vim.keymap.set('n', '<space>f', '<cmd>lua vim.lsp.buf.format { async = true }<CR>', opts)

  vim.keymap.set('n', '<space>dc', '<cmd>lua require("dap").continue()<CR>', opts)
  vim.keymap.set('n', '<space>dr', '<cmd>lua require("dap").repl.toggle()<CR>', opts)
  vim.keymap.set('n', '<space>dK', '<cmd>lua require("dap.ui.widgets").hover()<CR>', opts)
  vim.keymap.set('n', '<space>db', '<cmd>lua require("dap").toggle_breakpoint()<CR>', opts)
  vim.keymap.set('n', '<space>ds', '<cmd>lua require("dap").step_over()<CR>', opts)
  vim.keymap.set('n', '<space>di', '<cmd>lua require("dap").step_into()<CR>', opts)
  vim.keymap.set('n', '<space>dl', '<cmd>lua require("dap").run_last()<CR>', opts)
  vim.keymap.set('n', '<space>dui', '<cmd>lua require("dapui").toggle()<CR>', opts)
end

return out
