out = {}

out.load_language = function()
  vim.opt_global.shortmess:remove("F")
  
  local config = require("metals").bare_config()
  
  config.settings = {
    showImplicitArguments = true,
  }
  
  config.on_attach = function(client, bufnr)
    require('lspcfg').load_keybinds(client, bufnr)
    require('metals').setup_dap()
  end
  
  require('metals').initialize_or_attach(require('coq').lsp_ensure_capabilities(config))
  require('dap').configurations.scala = {
    {
      type = "scala",
      request = "launch",
      name = "Run Target",
      metals = {
        runType = "run",
      },
    },
    {
      type = "scala",
      request = "launch",
      name = "Test Target",
      metals = {
        runType = "testTarget",
      },
    },
  }
end

return out
