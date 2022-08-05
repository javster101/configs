
out = {}

out.load_language = function()
  local home = os.getenv('HOME')
  local workspace_folder = home .. "/.local/share/workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")
  
  local extendedClientCapabilities = require'jdtls'.extendedClientCapabilities
  extendedClientCapabilities.resolveAdditionalTextEditsSupport = true

  local config = {}
  config.flags = { 
      server_side_fuzzy_completion = true,
      allow_incremental_sync = true
  }
  config.capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())
  config.init_options = {
    bundles = {
      vim.fn.glob("/home/javst/Documents/Projects/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar")
    },
    extendedClientCapabilities = extendedClientCapabilities
  }
  config.settings = {
    java = {
      signatureHelp = { enabled = true };
      sources = {
        organizeImports = {
          starThreshold = 8;
          staticStarThreshold = 4;
        };      
      };
      codeGeneration = {
        toString = {
          template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
        }
      };
      configuration = {
        runtimes = {
          {
            name = "JavaSE-18",
            path = "/usr/lib/jvm/java-18-openjdk/"
          }
        }
      };
    };
  };
  
  config.on_attach = function(client, bufnr)
       require('jdtls').setup_dap() --{ hotcodereplace = 'auto' })
       require('jdtls.setup').add_commands()
       require('lspcfg').load_keybinds(client, bufnr)
     end
  
  config.cmd = {
   'jdtls',
   '-Dorg.eclipse.jdt.core.compiler.problem.enablePreviewFeatures=true',
   '-Dorg.eclipse.jdt.core.compiler.problem.reportPreviewFeatures=ignore',
   '--enable-preview',
   '-data', workspace_folder
  }
  
  config.root_dir = require('jdtls.setup').find_root({'.git', 'pom.xml', 'build.gradle'})
  
  require('jdtls').start_or_attach(config)
end

return out
