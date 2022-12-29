local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
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

----------- Purely preformance related ----------------
use "lewis6991/impatient.nvim"

use "dstein64/vim-startuptime"

----------- Coding productivity plugins ---------------

-- autocompletion tool
use {
  "ms-jpq/coq_nvim",
  config = get_config("coq")
}

use "ms-jpq/coq.artifacts"

use {
  "ms-jpq/coq.thirdparty",
  config = get_config("coqthirdparty")
}

-- mason lsp and dap extensions
use {
  "williamboman/mason-lspconfig.nvim",
  "jayp0521/mason-nvim-dap.nvim"
}

-- mason, general purpose language specific tool installer
use {
  "williamboman/mason.nvim",
  config = get_config("mason")
}

-- lsp configuration plugin
use {
  "neovim/nvim-lspconfig",
  config = get_config("lsp"),
  after = "coq_nvim"
}

-- dap configuration plugin
use {
  "mfussenegger/nvim-dap",
  config = get_config("dap")
}

use {
  'theHamsta/nvim-dap-virtual-text',
  config = get_config("dapvirtualtext")
}

use "github/copilot.vim"

-- for syntax highlighting and other goodies
use {
  "nvim-treesitter/nvim-treesitter",
  config = get_config("treesitter"),
  run = ":TSUpdate"
}

use "nvim-treesitter/nvim-treesitter-textobjects"

use 'nvim-treesitter/playground'

-- shows signature of function when typing
use {
  "ray-x/lsp_signature.nvim",
  config = get_config("signature")
}

----------- UI plugins --------------------------------

use {
  'nvim-tree/nvim-web-devicons',
  after = 'vscode.nvim'
}

-- vscode themes
use {
  'Mofiqul/vscode.nvim',
  config = get_config("vscode")
}

-- better status line
use {
  "nvim-lualine/lualine.nvim",
  config = get_config("lualine"),
  event = "VimEnter",
  requires = { "nvim-tree/nvim-web-devicons", opt = true },
  after = "vscode.nvim"
}

use 'arkav/lualine-lsp-progress'

-- basic ui for using DAP
use {
  "rcarriga/nvim-dap-ui",
  config = get_config("dapui")
}

-- better buffer line
use {
  'akinsho/bufferline.nvim',
  config = get_config("bufferline"),
  after = "vscode.nvim"

}

-- preview when using quick fix window
use { 'kevinhwang91/nvim-bqf', ft = 'qf' }

-- special highlights for // TODO: style comments
use {
  "folke/todo-comments.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  config = get_config("todo")
}

-- simple dashboard
use {
  'glepnir/dashboard-nvim',
  config = get_config("dashboard")
}

use {
  'edluffy/specs.nvim',
  config = get_config("specs")
}

----------- Navigation plugins ------------------------
-- quick jumping functionality
use {
  'ggandor/lightspeed.nvim',
  opt = false
}

-- catch all navigation tool
use {
  'ibhagwan/fzf-lua',
  requires = { 'nvim-tree/nvim-web-devicons' }
}

-- file explorer
use {
  'nvim-tree/nvim-tree.lua',
  requires = {
    'nvim-tree/nvim-web-devicons',
  },
  opt = true,
  cmd = { "NvimTreeOpen", "NvimTreeToggle" },
  config = get_config("tree")
}

-- issue explorer
use {
  "folke/trouble.nvim",
  opt = true,
  cmd = { "Trouble", "TroubleToggle" },
  requires = "nvim-tree/nvim-web-devicons",
  config = get_config("trouble")
}

-- outline view of files and functions
use {
  'simrat39/symbols-outline.nvim',
  opt = true,
  cmd = { "SymbolsOutline" },
  config = get_config("symbolsoutline")
}

----------- Miscellanious plugins ---------------------
-- for editing file which need sudo permissions
use 'lambdalisue/suda.vim'

-- for closing buffers in a sane way
use {
  'kazhala/close-buffers.nvim',
  config = get_config("closebuf")
}

-- for better commenting
use {
  'numToStr/Comment.nvim',
  config = get_config("comment")
}

-- discord presence
use {
  "andweeb/presence.nvim",
  config = get_config("presence")
}

-- for seeing what keys do what
use {
  "folke/which-key.nvim",
  config = get_config("whichkey")
}

-- vscode-esque workspace management
use {
  'Shatur/neovim-session-manager',
  config = get_config("session")
}

-- simple tool which makes renaming things more fun
use {
  'smjonas/inc-rename.nvim',
  config = get_config("increname")
}

-- for working with paired things easier () {} [] "" etc.
use {
  'windwp/nvim-autopairs',
  config = get_config("autopairs")
}

-- github integration
use {
  "lewis6991/gitsigns.nvim",
  requires = { "nvim-lua/plenary.nvim" },
  event = "BufReadPre",
  config = get_config("gitsigns")
}
