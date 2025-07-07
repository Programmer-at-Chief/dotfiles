return {
  {
    "nvim-treesitter/nvim-treesitter",
    -- lazy = false,
    build = ":TSUpdate",
    event = "VeryLazy",
    config = function()
      require "configs.nvim-treesitter"
    end,
  },
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "VeryLazy",
    opts = require("configs.nvim-treesitter-context").config
  },
  {
    'derektata/lorem.nvim',
    event = 'VimEnter',
    config = function()
      require('lorem').opts {
        sentenceLength = {
          words_per_sentence = 8,
          sentences_per_paragraph = 6
        },
        comma_chance = 0.3,  -- 30% chance to insert a comma
        max_commas_per_sentence = 2  -- maximum 2 commas per sentence
      }
    end
  },
  -- {
    --   'nvimdev/dashboard-nvim',
    --   event = 'VimEnter',
    --   config = function()
      --     require('configs.dashboard').setup {
        --       -- config
        --     }
        --   end,
        --   dependencies = { {'nvim-tree/nvim-web-devicons'}}
        -- },
        {
          "stevearc/conform.nvim",
          -- event = 'BufWritePre', -- uncomment for format on save
          config = function()
            require "configs.conform"
          end,
        },

        {
          "neovim/nvim-lspconfig",
          config = function()
            require "configs.lspconfig"
          end,
        },
        {
          "williamboman/mason.nvim",
          opts = {
            ensure_installed = {
              "lua-language-server", "stylua",
              "html-lsp", "css-lsp" , "prettier","pyright","cpplint","cpptools","tailwindcss-language-server"
            },
          },
        },
        {
          "williamboman/mason-lspconfig.nvim",
          opts = {
            ensure_installed = { "lua_ls", "rust_analyzer","jdtls" },
          },
        },
        {
          "NvChad/nvim-colorizer.lua",
          opts = {
            user_default_options = {
              tailwind = true,
              rgb_fn = true,    -- (e.g., rgb(255, 0, 0))
              RRGGBB = true,    -- (e.g., #FF0000)
              css = true,
            },
          },
          config = function()
            require 'colorizer'.setup()
          end,  
        },
        {
          'numToStr/Comment.nvim',
          opts = {
            mappings = {
              -- Normal mode mappings
              basic = false,  -- Enable basic mappings (i.e., gcc, gc, etc.)
              extra = false,  -- You can disable the extra mappings if not needed

              -- Custom key bindings
              -- Normal mode (space and / to comment/uncomment)
              extended = {
                ["<Space>c"] = {":lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment (space)"},
                ["/"] = {":lua require('Comment.api').toggle.linewise.current()<CR>", "Toggle comment (slash)"}
              },
              -- Visual mode (space and / to comment/uncomment)
              extra = {
                ["<Space>c"] = {":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment (space)"},
                ["/"] = {":lua require('Comment.api').toggle.linewise(vim.fn.visualmode())<CR>", "Toggle comment (slash)"}
              },
            }
          }
        },
        {
          "mfussenegger/nvim-jdtls",
          ft = { "java" },
          config = function()
            require("configs.jdtls")
          end,
          dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig"
          }
        },
        {
          "andymass/vim-matchup",
          lazy = true,
          event = "VeryLazy", -- or "BufReadPre"
        },
        -- {
        --   "Saghen/blink.cmp",
        --   opts = { HERE }
        -- }
        {
          "hrsh7th/nvim-cmp",
          dependencies = {
            { "roobert/tailwindcss-colorizer-cmp.nvim", config = true },
            { "hrsh7th/cmp-buffer"},
            { "hrsh7th/cmp-path"},
            { "hrsh7th/cmp-nvim-lua"},
            { "hrsh7th/cmp-nvim-lsp"},
            { "saadparwaiz1/cmp_luasnip"}
          },
          opts = require("configs.nvim-cmp"), 
        },

      }
