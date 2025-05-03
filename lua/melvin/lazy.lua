-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo({
            { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
            { out,                            "WarningMsg" },
            { "\nPress any key to exit..." },
        }, true, {})
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

-- Make sure to setup `mapleader` and `maplocalleader` before
-- loading lazy.nvim so that mappings are correct.
-- This is also a good place to setup other settings (vim.opt)
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Setup lazy.nvim
require("lazy").setup({
    spec = {
        -- import your plugins
        { import = "plugins" },
    },
    -- Configure any other settings here. See the documentation for more details.
    -- colorscheme that will be used when installing plugins.
    -- install = { colorscheme = { "habamax" } },
    -- automatically check for plugin updates
    checker = { enabled = true },
})


-- return require('packer').startup(function(use)
--     -- Packer can manage itself
--     use 'wbthomason/packer.nvim'
--
--     -- Vim Training For Funsies
--     use 'ThePrimeagen/vim-be-good'
--     use 'nvim-lua/plenary.nvim'
--
--     -- Undo deep history
--     use 'mbbill/undotree'
--
--     -- Git integration
--     use 'tpope/vim-fugitive'
--     use 'tpope/vim-rhubarb'
--
--     -- File searcher
--     use {
--         'nvim-telescope/telescope.nvim', tag = '0.1.8',
--         -- or                            , branch = '0.1.x',
--         requires = { { 'nvim-lua/plenary.nvim' } }
--     }
--
--     -- LSP/Linter Management
--     use {
--         "williamboman/mason.nvim",
--         build = ":MasonUpdate",
--         config = function()
--             require("mason").setup({
--                 ensure_installed = { "lua-language-server", "basedpyright" },
--             })
--         end,
--     }
--
--     -- Theme
--     use({
--         'rose-pine/neovim',
--         as = 'rose-pine',
--         config = function()
--             vim.cmd('colorscheme rose-pine')
--         end
--     })
--
--     -- Recent Files Manager
--     use {
--         "ThePrimeagen/harpoon",
--         branch = "harpoon2",
--         requires = { { "nvim-lua/plenary.nvim" } }
--     }
--
--     -- Syntax Highlighting
--     use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
--     use('nvim-treesitter/playground')
--     use {
--         "nvim-treesitter/nvim-treesitter-context",
--         requires = { "nvim-treesitter/nvim-treesitter" },
--         config = function()
--             require 'treesitter-context'.setup {
--                 enable = true,
--                 max_lines = 0,
--                 min_window_height = 0,
--                 line_numbers = true,
--                 multiline_threshold = 20,
--                 trim_scope = "outer",
--                 mode = "cursor",
--                 zindex = 20,
--                 on_attach = nil,
--                 win_opts = {},
--             }
--         end
--     }
--
--     -- Debugger
--     use 'mfussenegger/nvim-dap'
--     use 'mfussenegger/nvim-dap-python'
--     use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }
--
--     -- If packer was just installed (i.e. this is the first time running this file), then sync packer to install plugins
--     if packer_bootstrap then
--         -- if packer was just installed, sync it
--         require('packer').sync()
--     end
-- end)
