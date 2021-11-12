local home = os.getenv('HOME')
local workspace_folder = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

local config = {}
config.flags.server_side_fuzzy_completion = true
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


config.cmd = {
  'java',
  '-Dosgi.bundles.defaultStartLevel=4',
  '-Declipse.application=org.ecplipse.jdt.ls.core.id1',
  '-Declipse.product=org.eclipse.jdt.ls.core.product',
  '-Dlog.level=ALL',
  '-noverify',
  '-Xmx1G',
  '-jar /usr/share/java/jdtls/plugins/org.eclipse.equinox.launcher_*.jar',
  '-configuration /usr/share/java/jdtls/config_linux',
  '--add-modules=ALL-SYSTEM',
  '--add-opens java.base/java.util=ALL-UNNNAMED',
  '--add-opens java.base/java.lang=ALL-UNNAMED',
  '-data', workspace_folder
    -- ADD REMAINING OPTIONS FROM https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line !
};

config.root_dir = require('jdtls.setup').find_root({'.git', 'mvnw', 'gradlew'})

require('jdtls').start_or_attach(config)
