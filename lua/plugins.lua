-- returns the require for use in `config` parameter of packer's use
-- expects the name of the config file
local function get_config(name)
    return string.format("require(\"config/%s\")", name)
end

-- Automatically install and set up packer.nvim on any machine you clone your configuration to
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  Packer_bootstrap = fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

local packer = require("packer")

packer.init {
    enable = true, -- enable profiling via :PackerCompile profile=true
    threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    git = {
        clone_timeout = 1000,
    }
}

local use = packer.use
packer.reset()

use 'wbthomason/packer.nvim' -- Package manager. packer can manage itself
use {"L3MON4D3/LuaSnip"}
use { "neovim/nvim-lspconfig" }

use { "williamboman/mason.nvim" }
use { "williamboman/mason-lspconfig.nvim" }

require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    'tsserver',
    'phpactor',
    'jdtls',
    'volar',
  },
})
 
require'lspconfig'.vuels.setup{}

use {
    'hrsh7th/nvim-cmp',
    requires = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-buffer',
        'hrsh7th/cmp-path',
        'hrsh7th/cmp-cmdline',
        'saadparwaiz1/cmp_luasnip', -- snippets
        'L3MON4D3/LuaSnip' -- snippets
    },
    config = get_config('nvim-cmp')
}

use {
    'folke/tokyonight.nvim',
    config = get_config('colorscheme')
}

use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = get_config('nvim-tree')
}

use {
  'nvim-telescope/telescope.nvim',
  requires = { {'nvim-lua/plenary.nvim'} }
}

use {
	"windwp/nvim-autopairs",
    config = function() require("nvim-autopairs").setup {} end
}

use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
        local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
        ts_update()
    end,
}

require'nvim-treesitter.configs'.setup {
  ensure_installed = {
    'html', 'php', 'css', 'typescript', 'javascript'
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true
  },
  indent = {
    enable = true
  }
}

use { "aserowy/tmux.nvim", config = get_config('tmux') }
use {'b3nj5m1n/kommentary'}

use {'tpope/vim-surround'}

use {
    'lewis6991/gitsigns.nvim',
    requires = {
    'nvim-lua/plenary.nvim'
    },
    config = get_config('gitsigns')
}

use {
  'nvim-lualine/lualine.nvim',
  requires = { 'nvim-tree/nvim-web-devicons', opt = true },
  config = get_config('lualine')
}

-- Automatically set up your configuration after cloning packer.nvim
-- Put this at the end after all plugins
if Packer_bootstrap then
    require('packer').sync()
end
