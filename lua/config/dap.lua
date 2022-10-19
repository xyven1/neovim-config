local dap = require('dap')
function Split(s, delimiter)
  local result = {};
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match);
  end
  return result;
end

-- adapters
dap.adapters.lldb = {
  type = 'executable',
  command = '/usr/bin/lldb-vscode-13', -- adjust as needed
  name = "lldb"
}
dap.adapters.delve = {
  type = 'server',
  port = '${port}',
  executable = {
    command = 'dlv',
    args = { 'dap', '-l', '127.0.0.1:${port}' },
  }
}
-- configurations
dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      local path = vim.fn.getcwd() .. "/config.txt"
      if vim.fn.filereadable(path) ~= 0 then
        print("Found config.txt")
        local config = vim.fn.readfile(path)
        for _, line in ipairs(config) do
          if line:match("^program") then
            return line:match("^program%s*=%s*(.+)")
          end
        end
      end
      return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
    end,
    cwd = '${workspaceFolder}',
    stopOnEntry = false,
    args = function()
      local path = vim.fn.getcwd() .. "/config.txt"
      if vim.fn.filereadable(path) ~= 0 then
        local config = vim.fn.readfile(path)
        for i, line in ipairs(config) do
          -- check for line with args and opening curly brace
          if line:match("^args") and line:match("{") then
            -- read lines until we find closing curly brace
            local args = {}
            for j = i + 1, #config do
              if config[j]:match("^%s*%}") then
                break
              end
              table.insert(args, config[j]:match("^%s*(.+)"))
            end
            return args
          end
        end
      end
      local args = vim.fn.input('Arguments: ', '')
      return Split(args, ' ')
    end,

    -- 💀
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html

    runInTerminal = false,

    -- 💀
    -- If you use `runInTerminal = true` and resize the terminal window,
    -- lldb-vscode will receive a `SIGWINCH` signal which can cause problems
    -- To avoid that uncomment the following option
    -- See https://github.com/mfussenegger/nvim-dap/issues/236#issuecomment-1066306073
    postRunCommands = { 'process handle -p true -s false -n false SIGWINCH' }
  },
}
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}
dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

dap.setup()
require("mason-nvim-dap").setup({
  ensure_installed = {}
})
