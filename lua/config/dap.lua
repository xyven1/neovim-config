function Split(s, delimiter)
  local result = {};
  for match in (s .. delimiter):gmatch("(.-)" .. delimiter) do
    table.insert(result, match);
  end
  return result;
end

local dap = require("dap")

vim.api.nvim_set_hl(0, 'DapBreakpoint', { fg = '#bf321d' })
vim.fn.sign_define("DapBreakpoint", { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define("DapBreakpointCondition", { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define("DapBreakpointRejected", { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
vim.fn.sign_define("DapStopped", { text = '', texthl = 'Dap', linehl = 'DapStoppedLine', numhl = 'DapStoppedLine' })

require 'mason-nvim-dap'.setup {
  handlers = {
    function(config)
      require('mason-nvim-dap').default_setup(config)
    end,
    --[[ codelldb = function(config)
      config.adapters = {
        type = 'server',
        port = '${port}',
        executable = {
          command = 'codelldb',
          args = { '--port', '${port}' },
        },
      }
      dap.configurations.cpp = {
        {
          name = "Launch",
          type = "lldb",
          request = "launch",
          program = function()
            local path = vim.fn.getcwd() .. "/config.txt"
            if vim.fn.filereadable(path) ~= 0 then
              print("found config.txt")
              local conf = vim.fn.readfile(path)
              for _, line in ipairs(conf) do
                if line:match("^program") then
                  return line:match("^program%s*=%s*(.+)")
                end
              end
            end
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
          end,
          cwd = function()
            local path = vim.fn.getcwd() .. "/config.txt"
            if vim.fn.filereadable(path) ~= 0 then
              print("found config.txt")
              local conf = vim.fn.readfile(path)
              for _, line in ipairs(conf) do
                if line:match("^program") then
                  return line:match("^program%s*=%s*(.+)"):match("(.+)/")
                end
              end
            end
            return vim.fn.getcwd()
          end,
          stopOnEntry = false,
          args = function()
            local path = vim.fn.getcwd() .. "/config.txt"
            if vim.fn.filereadable(path) ~= 0 then
              local conf = vim.fn.readfile(path)
              for i, line in ipairs(conf) do
                -- check for line with args and opening curly brace
                if line:match("^args") and line:match("{") then
                  -- read lines until we find closing curly brace
                  local args = {}
                  for j = i + 1, #conf do
                    if conf[j]:match("^%s*%}") then
                      break
                    end
                    table.insert(args, conf[j]:match("^%s*(.+)"))
                  end
                  return args
                end
              end
            end
            local args = vim.fn.input('Arguments: ', '')
            return Split(args, ' ')
          end,
          runInTerminal = false,
          postRunCommands = { 'process handle -p true -s false -n false SIGWINCH' }
        },
      }

      dap.configurations.c = dap.configurations.cpp
      dap.configurations.rust = dap.configurations.cpp

      require('mason-nvim-dap').default_setup(config)
    end ]]
  },
}
