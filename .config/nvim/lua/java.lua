out = {}

out.load_language = function()
  local workspace_folder = os.getenv('HOME') .. "/.cache/jdtls/workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  local extendedClientCapabilities = require 'jdtls'.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local config = {
    flags = {
      server_side_fuzzy_completion = true,
      allow_incremental_sync = true
    },
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
    init_options = {
      extendedClientCapabilities = extendedClientCapabilities
    },
    on_attach = function(client, bufnr)
      require('jdtls').setup_dap() --{ hotcodereplace = 'auto' })
      require('jdtls.setup').add_commands()
    end,
    cmd = {
      'jdtls',
      '-Dorg.eclipse.jdt.core.compiler.problem.enablePreviewFeatures=true',
      '-Dorg.eclipse.jdt.core.compiler.problem.reportPreviewFeatures=ignore',
      '--enable-preview',
      '-data', workspace_folder
    },
    config = {
      root_dir = require('jdtls.setup').find_root({ '.git', 'pom.xml', 'build.gradle' })
    }
  }

  require('jdtls').start_or_attach(config)
end

return out
