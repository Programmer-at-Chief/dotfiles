function _G.statusLine()
  return vim.g.flutter_tools_decorations and vim.g.flutter_tools_decorations.app_version or ""
end

vim.opt.statusline = "%{%v:lua.statusLine()%}"
