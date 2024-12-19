return {
    {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v2.x',
        dependencies = {
            -- LSP Support
            {'neovim/nvim-lspconfig'},
            {'williamboman/mason.nvim'},
            {'williamboman/mason-lspconfig.nvim'},

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

            local lsp = require('lsp-zero').preset({})

            lsp.ensure_installed({
                'ts_ls',
                'eslint',
                'lua_ls',
                'clangd'
            })

            -- Configure sign icons
            lsp.set_sign_icons({
                error = 'E',
                warn = 'W',
                hint = 'H',
                info = 'I'
            })

            -- Configure completion
            local cmp = require('cmp')
            local cmp_select = {behavior = cmp.SelectBehavior.Select}
            local cmp_mappings = {
                ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                ['<CR>'] = cmp.mapping.confirm({ select = true }),
                ['<C-Space>'] = cmp.mapping.complete(),
            }

            cmp.setup({
                mapping = cmp_mappings,
                preselect = 'item',
                completion = {
                    completeopt = 'menu,menuone,noinsert'
                }
            })

            -- Use recommended LSP settings
            lsp.on_attach(function(client, bufnr)
                -- Your keymaps for LSP can go here
                local opts = {buffer = bufnr}
                -- Add any specific keybindings you want here
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
            end)

            lsp.setup()
        end
    }
}
