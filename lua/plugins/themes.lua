return {
  {
    'Mofiqul/vscode.nvim',
    opts = {
      italic_comments = true,
      transparent = not vim.g.neovide,
      group_overrides = {
        DapBreakpoint = { ctermbg = 0, fg = '#bf321d' },
        DapStopped = { ctermbg = 0, fg = '#ffcc00' },
        DapStoppedLine = { ctermbg = 0, bg = '#4b4b26' },
        SnacksIndentScope = { link = "IblScope" }
      },
    },
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
