require'nvim-tree'.setup {
  disable_netrw = true,
  hijack_cursor = true,
  sync_root_with_cwd = true,
  view = {
    mappings = {
      custom_only = false,
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
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  filesystem_watchers = {
    enable = true,
  },
}
