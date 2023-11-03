local lspconfig = require('lspconfig')
local coq = require('coq')

vim.diagnostic.config({
  virtual_text = {
    source = 'ifmany',
  },
  severity_sort = true,
})

local signs = { Error = " ", Warn = " ", Hint = " ", Info = " " }
for type, icon in pairs(signs) do
  local hl = "DiagnosticSign" .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

require('neodev').setup {}
local function setup_with_settings(server_name, settings)
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true
  }

  lspconfig[server_name].setup(coq.lsp_ensure_capabilities({
    on_attach = on_attach,
    settings = settings,
    capabilities = capabilities,
  }))
end

require("mason-lspconfig").setup {
  handlers = {
    function(server_name)
      setup_with_settings(server_name, nil)
    end,
    ["lua_ls"] = function()
      setup_with_settings("lua_ls", {
        Lua = {
          diagnostics = {
            globals = { "vim" }
          }
        }
      })
    end,
    ["rust_analyzer"] = function()
      setup_with_settings("rust_analyzer", {
        ["rust-analyzer"] = {
          checkOnSave = {
            command = "clippy",
          },
        },
      })
    end,
    ["nil_ls"] = function()
      setup_with_settings("nil_ls", {
        ['nil'] = {
          formatting = {
            command = { "nixpkgs-fmt" },
          },
        },
      })
    end,
  }
}

local notify = vim.notify
vim.notify = function(msg, ...)
  if msg:match("warning: multiple different client offset_encodings") then
    return
  end

  notify(msg, ...)
end
