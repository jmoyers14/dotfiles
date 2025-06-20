return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Autocompletion
            {'hrsh7th/nvim-cmp'},
            {'hrsh7th/cmp-nvim-lsp'},
            {'hrsh7th/cmp-buffer'},
            {'hrsh7th/cmp-path'},
            {'saadparwaiz1/cmp_luasnip'},
            {'hrsh7th/cmp-nvim-lua'},
            -- Snippets
            {'L3MON4D3/LuaSnip'},
            {'rafamadriz/friendly-snippets'},
        },
        config = function()
            -- Reserve space in the gutter to avoid layout shifts
            vim.opt.signcolumn = 'yes'

            -- Configure diagnostics
            vim.diagnostic.config({
                virtual_text = false,
                signs = true,
                underline = true,
                update_in_insert = false,
                severity_sort = true,
                float = {
                    border = 'rounded',
                    source = 'always',
                },
            })
            
            -- Configure sign icons
            local signs = {
                Error = "E",
                Warn = "W",
                Hint = "H",
                Info = "I",
            }
            
            for type, icon in pairs(signs) do
                local hl = "DiagnosticSign" .. type
                vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
            end
            
            -- Add floating window borders to hover and signature help
            vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
                vim.lsp.handlers.hover, {
                    border = "rounded",
                }
            )
            
            vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
                vim.lsp.handlers.signature_help, {
                    border = "rounded",
                }
            )
            
            -- Configure LSP capabilities for nvim-cmp
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
            
            -- Define common LSP configurations
            local common_config = {
                capabilities = capabilities,
            }
            
            vim.lsp.config('ts_ls', common_config)
            vim.lsp.config('eslint', common_config)
            vim.lsp.config('denols', common_config)
            vim.lsp.config('lua_ls', vim.tbl_deep_extend('force', common_config, {
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
            }))

            vim.lsp.config('sourcekit', vim.tbl_deep_extend('force', common_config, {
                cmd = {'sourcekit-lsp'},
                filetypes = {'swift'},
                capabilities = vim.tbl_deep_extend('force', capabilities, {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                }),
            }))
            
            -- Define LSP keymaps on server attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then return end
                    
                    local opts = {buffer = bufnr}
                    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
                    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
                    vim.keymap.set('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
                    vim.keymap.set('n', '<leader>vd', vim.diagnostic.open_float, opts)
                    vim.keymap.set('n', '[d', vim.diagnostic.goto_next, opts)
                    vim.keymap.set('n', ']d', vim.diagnostic.goto_prev, opts)
                    vim.keymap.set('n', '<leader>vca', vim.lsp.buf.code_action, opts)
                    vim.keymap.set('n', '<leader>vrr', vim.lsp.buf.references, opts)
                    vim.keymap.set('n', '<leader>vrn', vim.lsp.buf.rename, opts)
                    vim.keymap.set('i', '<C-h>', vim.lsp.buf.signature_help, opts)
                    vim.keymap.set('n', 'gl', vim.diagnostic.open_float, opts)
                end
            })
            
            -- Enable configured LSP servers
            -- vim.lsp.enable('ts_ls')
            -- vim.lsp.enable('eslint')
            -- vim.lsp.enable('lua_ls')
            vim.lsp.enable('sourcekit')
            
            -- Set up nvim-cmp
            local cmp = require('cmp')
            local luasnip = require('luasnip')
            
            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    {name = 'nvim_lsp'},
                    {name = 'buffer'},
                    {name = 'path'},
                    {name = 'luasnip'},
                },
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(),
                    ['<C-n>'] = cmp.mapping.select_next_item(),
                    ['<CR>'] = cmp.mapping.confirm({ select = true }),
                    ['<C-Space>'] = cmp.mapping.complete(),
                },
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                }
            })
        end
    }
}
