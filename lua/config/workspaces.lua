require("workspaces").setup({
  hooks = {
    -- hooks run before change directory
    open_pre = {
      -- If recording, save current session state and stop recording
      "SessionsStop",

      -- delete all buffers (does not save changes)
      "silent %bdelete!",
    },

    -- hooks run after change directory
    open = {
      -- load any saved session from current directory
      function()
        require("sessions").load(nil, { silent = true })
      end
    }
  },
})
