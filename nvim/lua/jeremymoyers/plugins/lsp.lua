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

            lsp.setup_nvim_cmp({
                mapping = {
                    ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
                    ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
                    ['<C-y>'] = cmp.mapping.confirm({select = true}),
                    ['<C-Space>'] = cmp.mapping.complete(),
                }
            })

            -- Use recommended LSP settings
            lsp.on_attach(function(client, bufnr)
                -- Your keymaps for LSP can go here
                local opts = {buffer = bufnr}
                -- Add any specific keybindings you want here
                vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
            end)

            lsp.setup()
        end
    }
}
