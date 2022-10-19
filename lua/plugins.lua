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

use "nathom/filetype.nvim"

use "dstein64/vim-startuptime"

----------- Coding productivity plugins ---------------

-- for LSP and DAP
use "neovim/nvim-lspconfig"

use {
  "williamboman/mason.nvim",
  config = get_config("mason")
}

use {
  "mfussenegger/nvim-dap",
  config = get_config("dap")
}

use {
  "rcarriga/nvim-dap-ui",
  config = get_config("dapui")
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

-- shows signature of function when typing
use {
  "ray-x/lsp_signature.nvim",
  config = get_config("signature")
}

----------- UI plugins --------------------------------

-- vscode themes
use 'Mofiqul/vscode.nvim'

-- better status line
use {
  "nvim-lualine/lualine.nvim",
  config = get_config("lualine"),
  event = "VimEnter",
  requires = { "kyazdani42/nvim-web-devicons", opt = true }
}

use 'arkav/lualine-lsp-progress'

-- better buffer line
use {
  'akinsho/bufferline.nvim',
  config = get_config("bufferline")
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

----------- Navigation plugins ------------------------
-- quick jumping functionality
use {
  "ggandor/lightspeed.nvim",
  opt = false
}

-- catch all navigation tool
use {
  'ibhagwan/fzf-lua',
  requires = { 'kyazdani42/nvim-web-devicons' }
}

-- file explorer
use {
  'kyazdani42/nvim-tree.lua',
  requires = {
    'kyazdani42/nvim-web-devicons',
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
  requires = "kyazdani42/nvim-web-devicons",
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
