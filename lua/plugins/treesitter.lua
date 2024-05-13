return {
  { 'nvim-treesitter/playground', cmd = 'TSPlaygroundToggle' },
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    event = { "LazyFile", "VeryLazy" },
    dependencies = {
      'JoosepAlviste/nvim-ts-context-commentstring',
      'nvim-treesitter/nvim-treesitter-textobjects'
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
    opts = {
      ensure_installed = {},
      sync_install = false,
      auto_install = true,
      modules = {},
      ignore_install = {}, -- List of parsers to ignore installing
      highlight = {
        enable = true,     -- false will disable the whole extension
        is_supported = function()
          return vim.api.nvim_buf_line_count(0) < 10000
        end,
        disable = {} -- list of language that will be disabled
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
      textobjects = {
        select = {
          enable = true,
          lookahead = true,
          keymaps = {
            ["af"] = { query = "@function.outer", desc = "Select around function" },
            ["if"] = { query = "@function.inner", desc = "Select inside function" },
            ["al"] = { query = "@loop.outer", desc = "Select around loop" },
            ["il"] = { query = "@loop.inner", desc = "Select inside loop" },
            ["ib"] = { query = "@block.inner", desc = "Select inside block" },
            ["ab"] = { query = "@block.outer", desc = "Select around block" },
            ["ir"] = { query = "@parameter.inner", desc = "Select inside parameter" },
            ["ar"] = { query = "@parameter.outer", desc = "Select around parameter" },
            ["ic"] = { query = "@call.inner", desc = "Select inside call" },
            ["ac"] = { query = "@call.outer", desc = "Select around call" },
            ["aC"] = { query = "@class.outer", desc = "Select around class" },
            ["iC"] = { query = "@class.inner", desc = "Select inside class" },
            ["id"] = { query = "@conditional.inner", desc = "Select inside conditional" },
            ["ad"] = { query = "@conditional.outer", desc = "Select around conditional" },
          }
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]f"] = "@function.outer",
            ["]]"] = "@class.outer",
            ["]r"] = "@parameter.inner",
          },
          goto_next_end = {
            ["]F"] = "@function.outer",
            ["]["] = "@class.outer",
            ["]R"] = "@parameter.inner",
          },
          goto_previous_start = {
            ["[f"] = "@function.outer",
            ["[["] = "@class.outer",
            ["[r"] = "@parameter.inner",
          },
          goto_previous_end = {
            ["[F"] = "@function.outer",
            ["[]"] = "@class.outer",
            ["[R"] = "@parameter.inner",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["g>r"] = { query = "@parameter.inner", desc = "Swap with next parameter" },
            ["g>f"] = { query = "@function.outer", desc = "Swap with next function" },
          },
          swap_previous = {
            ["g<r"] = { query = "@parameter.inner", desc = "Swap with previous parameter" },
            ["g<f"] = { query = "@function.outer", desc = "Swap with previous function" },
          },
        },
      },
    },
  },
  {
    'windwp/nvim-ts-autotag',
    event = "LazyFile",
    opts = {}
  }
}
