local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
function get_config(name)
    return string.format("require(\"config/%s\")", name)
end

-- bootstrap packer if not installed
if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({
        "git", "clone", "https://github.com/wbthomason/packer.nvim",
        install_path
    })
    execute "packadd packer.nvim"
end

-- initialize and configure packer
local packer = require("packer")
packer.init {
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0 -- the amount in ms that a plugins load time must be over for it to be included in the profile
}
local use = packer.use
packer.reset()

-- plugins list
use "wbthomason/packer.nvim"

use {"neovim/nvim-lspconfig", config = get_config("lsp")}

use {"ggandor/lightspeed.nvim", opt = false}

use "github/copilot.vim"

-- use {"projekt0n/github-nvim-theme", config = get_config("github-theme")}
use "tomasiser/vim-code-dark"

use {
    "nvim-lualine/lualine.nvim",
    config = get_config("lualine"),
    event = "VimEnter",
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
}

use {
    "lewis6991/gitsigns.nvim",
    requires = {"nvim-lua/plenary.nvim"},
    event = "BufReadPre",
    config = get_config("gitsigns")
}

use { 'ibhagwan/fzf-lua',
  -- optional for icon support
  requires = { 'kyazdani42/nvim-web-devicons' }
}

use {
    "nvim-treesitter/nvim-treesitter",
    config = get_config("treesitter"),
    run = ":TSUpdate"
}

use "nvim-treesitter/nvim-treesitter-textobjects"

use {
  "folke/todo-comments.nvim",
  requires = {"nvim-lua/plenary.nvim"},
  config = get_config("todo")
}

use {
  "ms-jpq/coq_nvim",
  config = get_config("coq")
}

use {
 "ms-jpq/coq.artifacts"
}

use {
  "ms-jpq/coq.thirdparty",
  config = get_config("coqthirdparty")
}

use {
  "mfussenegger/nvim-dap",
  config = get_config("dap")
}

use {
  "rcarriga/nvim-dap-ui",
  config = get_config("dapui")
}

-- use {
--   "natecraddock/workspaces.nvim",
--   config = get_config("workspaces")
-- }

use {
  "https://github.com/natecraddock/sessions.nvim",
  config = get_config("sessions")
}

use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = get_config("tree")
}

use {
  'sindrets/diffview.nvim',
  requires = 'nvim-lua/plenary.nvim'
}
-- use "andweeb/presence.nvim"
