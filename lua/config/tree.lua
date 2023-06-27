local function on_attach(bufnr)
  local api = require('nvim-tree.api')

  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  api.config.mappings.default_on_attach(bufnr)

  vim.keymap.set('n', '<S-v>', api.node.open.vertical, opts('Open: Vertical Split'))
  vim.keymap.set('n', '<S-x>', api.node.open.horizontal, opts('Open: Horizontal Split'))
end

require("nvim-tree").setup {
  disable_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = true,
  on_attach = on_attach,
  sync_root_with_cwd = true,
  renderer = {
    indent_markers = {
      enable = true,
    },
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
  },
}
