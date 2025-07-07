local jdtls = require("jdtls")

local home = os.getenv("HOME")

local function setup_jdtls()
  local root_dir = require("jdtls.setup").find_root({ "pom.xml", "build.gradle", ".git", "mvnw" })
  if not root_dir then
    root_dir = vim.fn.expand("%:p:h")
  end

  local workspace_dir = home .. "/.local/share/eclipse/" .. vim.fn.fnamemodify(root_dir, ":p:h:t")

  local config = {
    cmd = {
      "java",
      "-Declipse.application=org.eclipse.jdt.ls.core.id1",
      "-Dosgi.bundles.defaultStartLevel=4",
      "-Declipse.product=org.eclipse.jdt.ls.core.product",
      "-Dlog.protocol=true",
      "-Dlog.level=ALL",
      "-Xms1g",
      "--add-modules=ALL-SYSTEM",
      "--add-opens", "java.base/java.util=ALL-UNNAMED",
      "--add-opens", "java.base/java.lang=ALL-UNNAMED",
      "-jar",
      home .. "/.local/share/nvim/mason/packages/jdtls/plugins/org.eclipse.equinox.launcher_1.7.0.v20250331-1702.jar",
      "-configuration",
      home .. "/.local/share/nvim/mason/packages/jdtls/config_linux",
      "-data",
      workspace_dir,
    },
    root_dir = root_dir,
    settings = {
      java = {},
    },
    init_options = {
      bundles = {},
    },
    on_attach = require("nvchad.configs.lspconfig").on_attach,
    on_init = require("nvchad.configs.lspconfig").on_init,
    capabilities = require("nvchad.configs.lspconfig").capabilities,
  }

  jdtls.start_or_attach(config)
end

return setup_jdtls
