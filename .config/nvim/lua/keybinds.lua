out = {}

out.load_keybinds = function()
  -- Mappings.
  local wk = require('which-key')

  wk.add({
    {
      '<space>',
      expand = function()
        return {
          {
            'g',
            group = "Git",
            expand = function()
              return {
                { "b", function() vim.cmd.GitBlameToggle() end, desc = "Toggle git blame" },
                { "d", function() vim.cmd.DiffviewOpen() end,   desc = "Open git diff" },
                { "o", function() require('neogit').open() end, desc = "Open Neogit" },
                "Git"
              }
            end
          },
          { "ca", function() vim.cmd.Lspsaga('code_action') end, desc = "Code action" },
          { "cl", vim.lsp.codelens.run,                          desc = "Run codelens" },
          {
            'd',
            group = "Debug",
            expand = function()
              return {
                { "c",  require("dap").continue,                                desc = "Continue" },
                { "K",  function() require("dap.ui.widgets").hover() end,       desc = "Debug hover" },
                { "B",  require("dap").toggle_breakpoint,                       desc = "Toggle breakpoint" },
                { "o",  require("dap").step_over,                               desc = "Step over" },
                { "i",  require("dap").step_into,                               desc = "Step into" },
                { "u",  require("dap").step_out,                                desc = "Step out" },
                { "gu", require("dap").up,                                      desc = "Go up in stacktrace" },
                { "gd", require("dap").down,                                    desc = "Go down in stacktrace" },
                { "r",  function() vim.cmd.Telescope('dap configurations') end, desc = "Run previous" },
                { "ui", function() require("dapui").toggle() end,               desc = "Toggle" },
                { "p",  require("dap").repl.toggle,                             desc = "Toggle REPL" },
                { "R",  function() vim.cmd.RustLsp('debug') end,                desc = "Debug Rust" },
              }
            end
          },
          { "l",  function() require("nabla").popup() end,            desc = 'Render LaTEX' },
          {
            'f',
            group = "Telescope",
            expand = function()
              return {
                { "w", function() vim.cmd.Telescope('lsp_dynamic_workspace_symbols') end, desc = "Find workspace symbols" },
                { "d", function() vim.cmd.Telescope('lsp_document_symbols') end,          desc = "Find document symbols" },
                { "c", function() vim.cmd.Telescope('git_status') end,                    desc = "Find changes" },
                { "g", function() vim.cmd.Telescope('live_grep') end,                     desc = "Grep" },
                { "f", vim.lsp.buf.format,                                                desc = "Format" },
              }
            end
          },
          {
            'e',
            group = "Diagnostics",
            expand = function()
              return {
                { "l", function() vim.cmd.Lspsaga('show_line_diagnostics') end,   desc = "Line diagnostic" },
                { "b", function() vim.cmd.Lspsaga('show_buf_diagnostics') end,    desc = "Buffer diagnostic" },
                { "c", function() vim.cmd.Lspsaga('show_cursor_diagnostics') end, desc = "Cursor diagnostic" },
                { ']', function() vim.cmd.Lspsaga('diagnostic_jump_next') end,    desc = "Next diagnostic" },
                { '[', function() vim.cmd.Lspsaga('diagnostic_jump_prev') end,    desc = "Previous diagnostic" },
              }
            end
          },
          { "k",  function() vim.cmd.Lspsaga('hover_doc') end,        desc = "Hover doc" },
          { "K",  function() vim.cmd.Lspsaga('hover_doc ++keep') end, desc = "Open and keep hover doc" },
          { "pi", '<cmd>PasteImage<cr>',                              desc = "Paste image" },
          { "od", function() vim.cmd.RustLsp('openDocs') end,         desc = "Open docs.rs" },
          {
            'r',
            group = "Refactor",
            expand = function()
              return {
                { "n", function() vim.cmd.Lspsaga('rename') end,                           desc = "Rename" },
                { "r", function() require('refactoring').select_refactor() end,            desc = "Refactor" },
                { "e", function() require('refactoring').refactor('Extract Function') end, desc = "Extract Function" },
                { "v", function() require('refactoring').refactor('Extract Variable') end, desc = "Extract Variable" },
                "Refactor"
              }
            end
          },
          {
            'b',
            group = "Buffer",
            expand = function()
              return {
                { "p", function() vim.cmd.BufferLineTogglePin() end, desc = "Pin Buffer" },
                { "d", function() vim.cmd.BufferLinePickClose() end, desc = "Close Buffer" },
                "Buffers"
              }
            end
          },
          {
            's',
            group = "Session",
            expand = function()
              return {
                { "s",  function() vim.cmd.SessionSave() end,                            desc = 'Save session' },
                { "o",  function() vim.cmd.Telescope('session-lens search_session') end, desc = "Open session" },
                { "de", function() vim.cmd.Autosession('delete') end,                    desc = 'Remove session' },
              }
            end
          },
        }
      end
    },
    {
      'g',
      group = "Goto",
      expand = function()
        return {
          { "b", function() vim.cmd.BufferLinePick() end,           desc = "Go to buffer" },
          { "d", vim.lsp.buf.definition,                            desc = "Go to definition" },
          { "D", vim.lsp.buf.declaration,                           desc = "Go to declaration" },
          { "m", vim.lsp.buf.implementation,                        desc = "Go to implementation" },
          { "u", function() vim.cmd.Lspsaga('finder') end,          desc = "Find usages" },
          { "p", function() vim.cmd.Lspsaga('peek_definition') end, desc = "Peek definition" },
          { "i", function() vim.cmd.Lspsaga('incoming_calls') end,  desc = "Go to incoming calls" },
          { "o", function() vim.cmd.Lspsaga('outgoing_calls') end,  desc = "Go to outgoing calls" },
        }
      end
    },
    { 's', function()
      require('flash').jump({
        { "search", max_length = 2 },
        { "jump",   autojump = true }
      })
    end,
    },
    { 'r',               function() require('flash').remote() end,       desc = "Remote Flash",         mode = "o" },
    { "-",               require("oil").open,                            desc = "Open parent directory" },

    { '<M-n>',           function() vim.cmd.Telescope('find_files') end, desc = "Find files" },
    { '<M-b>',           function() vim.cmd.Telescope('buffers') end,    desc = "Find files" },
    -- smart-splits
    { '<A-h>',           require('smart-splits').resize_left },
    { '<A-j>',           require('smart-splits').resize_down },
    { '<A-k>',           require('smart-splits').resize_up },
    { '<A-l>',           require('smart-splits').resize_right },
    { '<C-h>',           require('smart-splits').move_cursor_left },
    { '<C-j>',           require('smart-splits').move_cursor_down },
    { '<C-k>',           require('smart-splits').move_cursor_up },
    { '<C-l>',           require('smart-splits').move_cursor_right },
    { '<C-\\>',          require('smart-splits').move_cursor_previous },
    { '<space><space>h', require('smart-splits').swap_buf_left },
    { '<space><space>j', require('smart-splits').swap_buf_down },
    { '<space><space>k', require('smart-splits').swap_buf_up },
    { '<space><space>l', require('smart-splits').swap_buf_right },
  })
end

return out
