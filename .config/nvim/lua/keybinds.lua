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
      u = { '<cmd>Lspsaga finder<CR>', "Find usages" },
      p = { '<cmd>Lspsaga peek_definition<CR>', "Peek definition" },
      i = { '<cmd>Lspsaga incoming_calls<CR>', "Go to incoming calls" },
      o = { '<cmd>Lspsaga outgoing_calls<CR>', "Go to outgoing calls" },
      "Go to"
    },
    s = {
      function()
        require('flash').jump({
          search = { max_length = 2 },
          jump = { autojump = true }
        })
      end,
      "Flash"
    },
    r = {
      function()
        require('flash').remote()
      end,
      "Remote Flash",
      mode = "o"
    },
    ['<space>'] = {
      g = {
        b = { '<cmd>GitBlameToggle<CR>', "Toggle git blame" },
        d = { '<cmd>DiffviewOpen<CR>', "Open git diff" },
        o = { function() require('neogit').open() end, "Open Neogit" },
        "Git"
      },
      c = {
        a = { '<cmd>Lspsaga code_action<CR>', "Code action" },
        l = { vim.lsp.codelens.run, "Run codelens" },
      },
      d = {
        c = { require("dap").continue, "Continue" },
        K = { function() require("dap.ui.widgets").hover() end, "Debug hover" },
        B = { require("dap").toggle_breakpoint, "Toggle breakpoint" },
        o = { require("dap").step_over, "Step over" },
        i = { require("dap").step_into, "Step into" },
        u = { require("dap").step_out, "Step out" },
        gu = { require("dap").up, "Go up in stacktrace" },
        gd = { require("dap").down, "Go down in stacktrace" },
        r = { '<cmd>Telescope dap configurations<CR>', "Run previous" },
        ui = { function() require("dapui").toggle() end, "Toggle" },
        p = { require("dap").repl.toggle, "Toggle REPL" },
        R = { function() vim.cmd.RustLsp('debug') end, "Debug Rust"},
        "Debug"
      },
      l = { function() require("nabla").popup() end, 'Render LaTEX' },
      t = {
        f = { '<cmd>Lspsaga term_toggle<CR>', "Open floating terminal", noremap = true, silent = true },
        h = { function() require("nvterm.terminal").toggle("horizontal") end, "Open horizontal terminal" },
        v = { function() require("nvterm.terminal").toggle("vertical") end, "Open vertical terminal" },
        "Terminal"
      },
      f = {
        w = { '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>', "Find workspace symbols" },
        d = { '<cmd>Telescope lsp_document_symbols<CR>', "Find document symbols" },
        c = { '<cmd>Telescope git_status<CR>', "Find changes" },
        g = { '<cmd>Telescope live_grep<CR>', "Grep" },
        f = { vim.lsp.buf.format, "Format" },
        "Find/Format"
      },
      e = {
        l = { '<cmd>Lspsaga show_line_diagnostics<CR>', "Line diagnostic" },
        b = { '<cmd>Lspsaga show_buf_diagnostics<CR>', "Buffer diagnostic" },
        c = { '<cmd>Lspsaga show_cursor_diagnostics<CR>', "Cursor diagnostic" },
        [']'] = { '<cmd>Lspsaga diagnostic_jump_next<CR>', "Next diagnostic" },
        ['['] = { '<cmd>Lspsaga diagnostic_jump_prev<CR>', "Previous diagnostic" },
        "Diagnostics"
      },
      k = { '<cmd>Lspsaga hover_doc<CR>', "Hover doc" },
      K = { '<cmd>Lspsaga hover_doc ++keep<CR>', "Open and keep hover doc" },
      p = {
        i = { '<cmd>PasteImage<cr>', "Paste image"}
      },
      r = {
        n = { '<cmd>Lspsaga rename<CR>', "Rename" },
        r = { function() require('refactoring').select_refactor() end, "Refactor" },
        e = { function() require('refactoring').refactor('Extract Function') end, "Extract Function" },
        v = { function() require('refactoring').refactor('Extract Variable') end, "Extract Variable" },
        "Refactor"
      },
      b = {
        p = { '<cmd>BufferLineTogglePin<CR>', "Pin Buffer" },
        d = { '<cmd>BufferLinePickClose<CR>', "Close Buffer" },
        "Buffers"
      },
      s = {
        s = { '<cmd>SessionSave<CR>', 'Save session' },
        o = { '<cmd>Telescope session-lens search_session<CR>', "Open session" },
        d = { '<cmd>Autosession delete<CR>', 'Delete session' },
        "Session/Surround"
      },
    },
    ['-'] = { require("oil").open, "Open parent directory" },

    -- smart-splits
    ['<M-n>'] = { '<cmd>Telescope find_files<CR>', "Find files" },
    ['<M-b>'] = { '<cmd>Telescope buffers<CR>', "Find files" },
  })

  vim.keymap.set('n', '<A-h>', require('smart-splits').resize_left)
  vim.keymap.set('n', '<A-j>', require('smart-splits').resize_down)
  vim.keymap.set('n', '<A-k>', require('smart-splits').resize_up)
  vim.keymap.set('n', '<A-l>', require('smart-splits').resize_right)
  -- moving between splits
  vim.keymap.set('n', '<C-h>', require('smart-splits').move_cursor_left)
  vim.keymap.set('n', '<C-j>', require('smart-splits').move_cursor_down)
  vim.keymap.set('n', '<C-k>', require('smart-splits').move_cursor_up)
  vim.keymap.set('n', '<C-l>', require('smart-splits').move_cursor_right)
  vim.keymap.set('n', '<C-\\>', require('smart-splits').move_cursor_previous)
  -- swapping buffers between windows
  vim.keymap.set('n', '<space><space>h', require('smart-splits').swap_buf_left)
  vim.keymap.set('n', '<space><space>j', require('smart-splits').swap_buf_down)
  vim.keymap.set('n', '<space><space>k', require('smart-splits').swap_buf_up)
  vim.keymap.set('n', '<space><space>l', require('smart-splits').swap_buf_right)
end

return out
