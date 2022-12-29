local c = require('vscode.colors').get_colors()
require('vscode').setup({
  -- Enable italic comment
  italic_comments = true,
  -- Override highlight groups (see ./lua/vscode/theme.lua)
  group_overrides = {
    ['@keyword'] = {
      italic = true,
      fg = c.vscPink,
      bg = 'NONE'
    }
  }
})
