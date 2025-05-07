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
                    "eslint",
                    "lua_ls",
                    "clangd",
                },
                automatic_installation = true,
                -- Handlers define what happens when a server is installed
                handlers = {
                    -- Default handler
                    function(server_name)
                        -- Get capabilities from cmp_nvim_lsp if available
                        local capabilities = {}
                        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
                        if has_cmp then
                            capabilities = cmp_nvim_lsp.default_capabilities()
                        end
                        
                        -- Configure the server using Neovim's new LSP API
                        vim.lsp.config(server_name, {
                            capabilities = capabilities,
                        })
                        vim.lsp.enable(server_name)
                        
                        -- Print debug info
                        print("Configured and enabled LSP server: " .. server_name)
                    end,
                    
                    -- Special handler for lua_ls
                    ["lua_ls"] = function()
                        -- Get capabilities from cmp_nvim_lsp if available 
                        local capabilities = {}
                        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
                        if has_cmp then
                            capabilities = cmp_nvim_lsp.default_capabilities()
                        end
                        
                        vim.lsp.config("lua_ls", {
                            capabilities = capabilities,
                            settings = {
                                Lua = {
                                    diagnostics = {
                                        globals = {'vim'}
                                    },
                                    workspace = {
                                        library = vim.api.nvim_get_runtime_file("", true),
                                        checkThirdParty = false,
                                    },
                                    telemetry = {
                                        enable = false,
                                    },
                                }
                            }
                        })
                        vim.lsp.enable("lua_ls")
                        print("Configured and enabled lua_ls with Neovim-specific settings")
                    end,
                }
            })
        end
    }
}
