
---@type ChadrcConfig
local M = {}

M.ui = {
	theme = "chadracula-evondev",

	-- hl_override = {
	-- 	Comment = { italic = true },
	-- 	["@comment"] = { italic = true },
	-- },
}

require("luasnip.loaders.from_lua").load({
  paths = "~/.config/nvim/lua/snippets",
})

return M
