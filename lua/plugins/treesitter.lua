return {
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    opts = {
      ensure_installed = {},
      sync_install = false,
      auto_install = true,
      modules = {},
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true,     -- false will disable the whole extension
        disable = {}       -- list of language that will be disabled
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<CR>",
          scope_incremental = "<CR>",
          node_incremental = "<TAB>",
          node_decremental = "<S-TAB>"
        }
      },
      indent = { enable = true },
      autopairs = { { enable = true } },
      textobjects = {
        select = {
          enable = true,
          -- Automatically jump forward to textobj, similar to targets.vim
          lookahead = true,
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["af"] = { query = "@function.outer", desc = "Select around function" },
            ["if"] = { query = "@function.inner", desc = "Select inside function" },
            ["ac"] = { query = "@class.outer", desc = "Select around class" },
            ["ic"] = { query = "@class.inner", desc = "Select inside class" },
            ["al"] = { query = "@loop.outer", desc = "Select around loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inside loop" },
            ["ib"] = { query = "@block.inner", desc = "Select inside block" },
            ["ab"] = { query = "@block.outer", desc = "Select around block" },
            ["ir"] = { query = "@parameter.inner", desc = "Select inside parameter" },
            ["ar"] = { query = "@parameter.outer", desc = "Select around parameter" },
          }
        },
        lsp_interop = {
          enable = true,
          border = 'none',
          peek_definition_code = {
            -- ["<leader>df"] = "@function.outer",
            -- ["<leader>dF"] = "@class.outer",
          },
        },
      },
    },
  },
}
