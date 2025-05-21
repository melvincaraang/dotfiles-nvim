return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
        require("mason").setup({
            ensure_installed = {
                "basedpyright",
                "cfn-lint",
                "css-lsp",
                "docker-compose-language-service",
                "eslint-lsp",
                "gh-actions-language-server",
                "html-lsp",
                "lua-language-server",
                "ruff",
                "sqlfmt",
                "sqlls",
                "svelte-language-server",
                "tailwindcss-language-server",
                "typescript-language-server",
                "vtsls",
                "yaml-language-server",
                "yamlfmt",
                "yamllint",
            },
        })
    end,
}
