require("presence"):setup({
  auto_update         = true,
    neovim_image_text   = "Just Another Text Editor",
    main_image          = "file",
    debounce_timeout    = 1,
    enable_line_number  = true,
    buttons             = true,

    editing_text        = "Editing %s",
    file_explorer_text  = "Browsing %s",
    git_commit_text     = "Committing changes",
    plugin_manager_text = "Managing plugins",
    reading_text        = "Reading %s",
    workspace_text      = "Workspace: %s",
    line_number_text    = "%s/%s",
})
