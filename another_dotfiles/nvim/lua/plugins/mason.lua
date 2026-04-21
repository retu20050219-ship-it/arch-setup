return {
    "williamboman/mason.nvim",
    event = { "VeryLazy" },
    dependencies = {
        "neovim/nvim-lspconfig",
        "williamboman/mason-lspconfig.nvim",
    },
    opts = {},
    config = function (_, opts)
        require("mason").setup(opts)

        local registry = require("mason-registry")
        local success, package = pcall(registry.get_package, "lua-language-server")
        if success and not package:is_installed() then
            package:install()
        end
        local nvim_lsp = "lua_ls"
        settings = {
            lua = {
                diagnostics = {
                    globals = { "vim" }
                }
            }
        }
        vim.lsp.config(nvim_lsp,{})
        vim.lsp.enable(nvim_lsp)
        vim.diagnostic.config({
            virtual_text = true,
            update_in_insert = true,
            virtual_line = false,
        })
    end
}
