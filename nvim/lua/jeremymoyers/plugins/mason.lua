return {
    {
        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        build = ":MasonUpdate",
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })
        end
    },
    {
        "williamboman/mason-lspconfig.nvim",
        dependencies = {
            "williamboman/mason.nvim",
            "neovim/nvim-lspconfig",
        },
        config = function()
            require("mason-lspconfig").setup({
                ensure_installed = {
                    "ts_ls",
                    "lua_ls",
                    "denols",
                },
                handlers = {
                    function(server_name)
                        local capabilities = vim.lsp.protocol.make_client_capabilities()
                        capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

                        require('lspconfig')[server_name].setup({
                            capabilities = capabilities,
                        })
                    end,
                },
                automatic_enable = {
                    exclude = {
                        "denols"
                    }
                }
            })
        end
    }
}
