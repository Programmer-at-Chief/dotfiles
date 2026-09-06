local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

-- shared defaults for all LSPs
vim.lsp.config("*", {
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
})

-- optional: tweak specific servers before enabling them
vim.lsp.config("asm_lsp", {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "s", "S" },
})

vim.lsp.config("sqls", {
  cmd = { "sqls" },
  init_options = {
    connections = {
      {
        driver = "mysql",
        dataSourceName = "aman:Aman2004@/test",
      },
    },
  },
})

vim.lsp.config("kotlin_lsp", {
  -- cmd = {
  --   vim.fn.stdpath("data") .. "/mason/bin/intellij-server"
  -- },
  cmd = { vim.fn.stdpath("data") .. "/mason/bin/intellij-server", "--stdio", },
  filetypes = { "kotlin" },

  root_markers = {
    "settings.gradle",
    "settings.gradle.kts",
    "build.gradle",
    "build.gradle.kts",
    "pom.xml",
    ".git",
  },
})

-- enable servers
local servers = {
  "html",
  "cssls",
  "pyright",
  "clangd",
  "tailwindcss",
  "ts_ls",
  "emmet_ls",
  "asm_lsp",
  "sqls",
  "kotlin_lsp",
  "bashls"
}

vim.lsp.enable(servers)

-- Java/JDTLS special handling stays separate
vim.api.nvim_create_autocmd("FileType", {
  pattern = "java",
  callback = function()
    require("configs.jdtls")()
  end,
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, {
      focusable = false,
      close_events = { "BufLeave", "CursorMoved", "InsertEnter", "FocusLost" },
      border = "rounded",
      source = "always",
      prefix = "",
      scope = "cursor",
    })
  end,
})
