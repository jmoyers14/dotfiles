return {
    {
        "williamboman/mason.nvim",
        build = ":MasonUpdate",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
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
                    "eslint",
                    "lua_ls",
                    "denols",
                },
                automatic_enable = {
                    exclude = {
                        "denols",
                        "eslint",
                    }
                }
            })
        end
    }
}
