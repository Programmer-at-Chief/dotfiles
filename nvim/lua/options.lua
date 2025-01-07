require "nvchad.options"

local o = vim.o
-- o.cursorlineopt ='both' -- to enable cursorline!
-- o.relativenumber = 'true'
vim.wo.relativenumber = true
vim.opt.mouse = "" 
vim.opt.foldmethod = "expr"
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

