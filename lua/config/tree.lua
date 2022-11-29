require 'nvim-tree'.setup {
  disable_netrw = true,
  hijack_cursor = true,
  hijack_unnamed_buffer_when_opening = true,
  sync_root_with_cwd = true,
  view = {
    mappings = {
      list = {
        { key = "<S-v>", action = "vsplit" },
        { key = "<S-x>", action = "split" },
      },
    },
  },
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
