return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      vim.opt.showmode = false
      require('lualine').setup {
        options = {
          icons_enabled = true,
          theme = 'auto',
          component_separators = { left = '', right = '' },
          section_separators = { left = '', right = '' },
          disabled_filetypes = {},
          always_divide_middle = true,
          globalstatus = true,
        },
        sections = {
          lualine_a = { 'mode',
          },
          lualine_b = { 'branch', 'diff', 'diagnostics' },
          lualine_c = { 'filename', 'lsp_progress' },
          lualine_x = { 'overseer',
            {
              require("noice").api.statusline.mode.get,
              cond = require("noice").api.statusline.mode.has,
              color = { fg = "#ff9e64" },
            }
          },
          lualine_y = { 'encoding', 'fileformat', 'filetype' },
          lualine_z = { 'progress', 'location' }
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = {},
          lualine_c = { 'filename' },
          lualine_x = {},
          lualine_y = {},
          lualine_z = { 'location' }
        },
        tabline = {},
        extensions = {}
      }
    end,
    event = 'VimEnter',
    dependencies = { 'nvim-tree/nvim-web-devicons', 'arkav/lualine-lsp-progress' },
  },
  {
    'akinsho/bufferline.nvim',
    event = 'VimEnter',
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        -- diagnostics_indicator = function(count, level, diagnostics_dict, context)
        --   local s = ''
        --   local level_str = {
        --     error = ' ', -- warning = ' ', info = ' ', hint = ' ',
        --   }
        --   for e, n in pairs(diagnostics_dict) do
        --     if n > 0 and level_str[e] ~= nil then
        --       s = s .. n .. level_str[e]
        --     end
        --   end
        --   return s
        -- end,
        offsets = { { filetype = 'NvimTree', text = 'File Explorer', text_align = 'left' } },
        show_buffer_close_icons = false,
        show_close_icon = false,
        separator_style = 'none',
      }
    },
    keys = {
      { '<tab>',   '<cmd>BufferLineCycleNext<cr>', desc = "Next buffer" },
      { '<s-tab>', '<cmd>BufferLineCyclePrev<cr>', desc = "Previous buffer" },
      { '[b',      '<cmd>BufferLineMovePrev<cr>',  desc = "Move buffer left" },
      { ']b',      '<cmd>BufferLineMoveNext<cr>',  desc = "Move buffer right" },
    }
  },
}
