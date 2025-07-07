require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "ii", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

local wk = require("which-key")
wk.add({
  { "<leader>ca",vim.lsp.buf.code_action, desc = "LSP Code Action" },
})
