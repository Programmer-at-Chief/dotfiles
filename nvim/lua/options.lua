require "nvchad.options"

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- o.relativenumber = 'true'
vim.wo.relativenumber = true
vim.opt.mouse = "" 
vim.opt.foldmethod = "manual"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- Add custom filetype mappings for ejs
vim.filetype.add({
  extension = {
    ejs = "html",  -- Treat ejs files as HTML for completions
    -- ejs = 'javascript',
    conf = 'cpp',
    fsharp = 'cpp',
    ypp = 'cpp',
    lex = 'cpp'
  },
})

-- Remember and load code folds
vim.api.nvim_create_autocmd({"BufWinLeave"}, {
  pattern = {"*.*"},
  desc = "save view (folds), when closing file",
  command = "mkview",
})
vim.api.nvim_create_autocmd({"BufWinEnter"}, {
  pattern = {"*.*"},
  desc = "load view (folds), when opening file",
  command = "silent! loadview"
})
