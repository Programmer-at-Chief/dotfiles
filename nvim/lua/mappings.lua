require "nvchad.mappings"

-- add yours here

local map = vim.keymap.set

-- map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "LSP Code Action" })
map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "ii", "<ESC>")

--Flutter Telescope Commands Mapping
map("n", "<leader>fc", function()
  require("telescope").extensions.flutter.commands()
end, { desc = "Flutter Commands" })

map("n", "<leader>fp", function()
  vim.lsp.buf.format({ async = true })
end, { desc = "Format with Prettier" })
-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "<leader>cp", "<cmd>CccPick<CR>", { desc = "Pick ARGB Color" })

local wk = require("which-key")
wk.add({
  { "<leader>ca", vim.lsp.buf.code_action, desc = "LSP Code Action" },
  { "<leader>fc", group = "Flutter Commands" },
  { "<leader>fp", group = "Format with Prettier" },
  { "<leader>cp", group = "Pick ARGB Color" },
})
