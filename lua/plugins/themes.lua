return {
  {
    'Mofiqul/vscode.nvim',
    opts = function()
      local c = require('vscode.colors').get_colors()
      return {
        italic_comments = true,
        group_overrides = {
          DapBreakpoint = { ctermbg = 0, fg = '#bf321d' },
          DapStopped = { ctermbg = 0, fg = '#ffcc00' },
          DapStoppedLine = { ctermbg = 0, bg = '#4b4b26' },
          NeoTreeIndentMarker = { fg = c.vscContext, bg = 'NONE' }
        },
      }
    end,
  },
  'rktjmp/lush.nvim',
  {
    'folke/tokyonight.nvim',
    opts = {},
  },
  {
    'olimorris/onedarkpro.nvim',
    opts = {},
  },
  {
    'xyven1/onedark.nvim',
    opts = {},
  },
  {
    'rebelot/kanagawa.nvim',
    opts = {},
  },
  {
    'sainnhe/gruvbox-material',
    opts = {},
    init = function()
      vim.g.gruvbox_material_background = 'medium'
      vim.g.gruvbox_material_foreground = 'original'
      vim.g.gruvbox_material_enable_italic = 1
    end,
  },
}
