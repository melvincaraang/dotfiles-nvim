return {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = function()
        require("mason").setup({
            ensure_installed = { "lua-language-server", "basedpyright" },
        })
    end,
}
