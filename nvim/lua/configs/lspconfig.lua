-- EXAMPLE 
local on_attach = require("nvchad.configs.lspconfig").on_attach
local on_init = require("nvchad.configs.lspconfig").on_init
local capabilities = require("nvchad.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"
local servers = { "html", "cssls","pyright","clangd", "tailwindcss","ts_ls","emmet_ls"}

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    on_init = on_init,
    capabilities = capabilities,
  }
end

lspconfig.asm_lsp.setup {
  cmd = { "asm-lsp" },
  filetypes = { "asm", "s", "S" },
  on_attach = on_attach,
  on_init = on_init,
  capabilities = capabilities,
}


vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = "java",
  callback = function()
    require("configs.jdtls")()
  end,
})
