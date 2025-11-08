return {
    {
        "nvim-treesitter/nvim-treesitter",
        branch = "master",
        build = ":TSUpdate",
        config = function()
            local configs = require("nvim-treesitter.configs")
            configs.setup({
                ensure_installed = {
                    "c", "lua", "vim", "vimdoc", "python",
                    "javascript", "typescript", "tsx", "json",
                    "html", "css", "yaml", "toml", "svelte",
                    "sql", "markdown", "jinja", "jinja_inline", "gitignore"
                },
                sync_install = false,
                highlight = { enable = true },
                indent = { enable = true },
            })
        end,
    },

    {
        "nvim-treesitter/nvim-treesitter-context",
        dependencies = { "nvim-treesitter/nvim-treesitter" },
        event = { "BufReadPost", "BufNewFile" },
        config = function()
            require("treesitter-context").setup({
                enable = true,
                max_lines = 0,
                trim_scope = "outer",
                mode = "cursor",
                separator = nil,
                on_attach = function(bufnr)
                    -- Validate that windows are valid before attaching
                    local win_ids = vim.api.nvim_list_wins()
                    for _, win in ipairs(win_ids) do
                        if vim.api.nvim_win_get_buf(win) == bufnr then
                            return true
                        end
                    end
                    return false
                end,
            })
        end,
    },
}
