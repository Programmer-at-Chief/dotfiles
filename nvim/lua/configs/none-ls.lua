return function(_, opts)
  local nls = require("null-ls")
  opts.sources = vim.list_extend(opts.sources or {}, {
    nls.builtins.formatting.prettier,
  })
end
