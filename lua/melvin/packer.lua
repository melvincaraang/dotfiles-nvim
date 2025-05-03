local ensure_packer = function()
    local fn = vim.fn
    local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    if fn.empty(fn.glob(install_path)) > 0 then
        fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
        vim.cmd [[packadd packer.nvim]]
        return true
    end
    return false
end

local packer_bootstrap = ensure_packer()

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Vim Training For Funsies
    use 'ThePrimeagen/vim-be-good'
    use 'nvim-lua/plenary.nvim'

    -- Undo deep history
    use 'mbbill/undotree'

    -- Git integration
    use 'tpope/vim-fugitive'
    use 'tpope/vim-rhubarb'

    -- File searcher
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        -- or                            , branch = '0.1.x',
        requires = { { 'nvim-lua/plenary.nvim' } }
    }

    -- LSP/Linter Management
    use {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ensure_installed = { "lua-language-server", "basedpyright" },
            })
        end,
    }

    -- Theme
    use({
        'rose-pine/neovim',
        as = 'rose-pine',
        config = function()
            vim.cmd('colorscheme rose-pine')
        end
    })

    -- Recent Files Manager
    use {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        requires = { { "nvim-lua/plenary.nvim" } }
    }

    -- Syntax Highlighting
    use('nvim-treesitter/nvim-treesitter', { run = ':TSUpdate' })
    use('nvim-treesitter/playground')
    use {
        "nvim-treesitter/nvim-treesitter-context",
        requires = { "nvim-treesitter/nvim-treesitter" },
        config = function()
            require 'treesitter-context'.setup {
                enable = true,
                max_lines = 0,
                min_window_height = 0,
                line_numbers = true,
                multiline_threshold = 20,
                trim_scope = "outer",
                mode = "cursor",
                zindex = 20,
                on_attach = nil,
                win_opts = {},
            }
        end
    }

    -- Debugger
    use 'mfussenegger/nvim-dap'
    use 'mfussenegger/nvim-dap-python'
    use { "rcarriga/nvim-dap-ui", requires = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" } }

    -- If packer was just installed (i.e. this is the first time running this file), then sync packer to install plugins
    if packer_bootstrap then
        -- if packer was just installed, sync it
        require('packer').sync()
    end
end)
