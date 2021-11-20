local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/workspaces/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {}
config.flags = { 
    server_side_fuzzy_completion = true,
    allow_incremental_sync = true
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
          name = "JavaSE-17",
          path = "/usr/lib/jvm/java-17-openjdk/"
        }
      }
    };
  };
};


config.on_attach = function(client, bufnr)
    -- require('jdtls').setup_dap({ hotcodereplace = 'auto' })
     require('jdtls.setup').add_commands()
     require('lspcfg').load_keybinds(client, bufnr)
   end

config.cmd = {
 'jdtls',
 '-data', workspace_folder
}

config.root_dir = require('jdtls.setup').find_root({'.git', 'pom.xml', 'build.gradle'})

require('jdtls').start_or_attach(config)
require('coq').lsp_ensure_capabilities();
