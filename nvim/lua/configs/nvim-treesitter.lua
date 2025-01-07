-- local config = function()
  -- require("nvim-treesitter.configs").setup({
local setup = ({
    ensure_installed = {
      "bash",
      "c",
      "cmake",
      "cpp",
      "css",
      "diff",
      "gitcommit",
      "gitignore",
      "go",
      "haskell",
      "html",
      "java",
      "javascript",
      "json",
      "json5",
      "lua",
      "make",
      "markdown",
      "markdown_inline",
      "python",
      "regex",
      "sql",
      "toml",
      "xml",
      "vim",
      "vimdoc",
      "yaml",
    },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = false,

    -- Automatically install missing parsers when entering buffer
    -- Recommendation: set to false if you don't have `tree-sitter` CLI installed locally
    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
      -- disable for larger files
      disable = function(lang, buf)
        local max_filesize = 50 * 1024 -- 50 KB
        local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
        if ok and stats and stats.size > max_filesize then
          return true
        end
      end,
    },
    indent = { enable = true, disable = { "python", "markdown" } },
    incremental_selection = {
      enable = false,
    },

    -- autoclose and autorename html tag
    autotag = {
      enable = true,
    },

    -- see https://github.com/andymass/vim-matchup?tab=readme-ov-file#tree-sitter-integration
    matchup = {
      enable = true,
    },
  })

  -- temporary fix for school projects
  -- vim.treesitter.language.register("html", "ejs")
  -- vim.treesitter.language.register("javascript", "ejs")
  -- vim.treesitter.language.register("cpp", "conf")
  -- vim.treesitter.language.register("cpp", "fsharp")
  -- vim.filetype.add({ extension = { ypp = "ypp" } })
  -- vim.treesitter.language.register("cpp", "ypp")
  -- vim.treesitter.language.register("cpp", "lex")
-- end

return setup
