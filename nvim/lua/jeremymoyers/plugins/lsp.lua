return {
    {
        'neovim/nvim-lspconfig',
        dependencies = {
            -- Autocompletion
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lua' },
            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
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

            -- Configure LSP capabilities for nvim-cmp (apply to all servers)
            local capabilities = vim.lsp.protocol.make_client_capabilities()
            capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

            vim.lsp.config('*', {
                capabilities = capabilities,
            })

            -- Configure sourcekit for Swift
            vim.lsp.config('sourcekit', {
                cmd = { 'sourcekit-lsp' },
                filetypes = { 'swift', 'objc', 'objcpp' },
                capabilities = vim.tbl_deep_extend('force', capabilities, {
                    workspace = {
                        didChangeWatchedFiles = {
                            dynamicRegistration = true,
                        },
                    },
                }),
            })
            vim.lsp.enable('sourcekit')

            -- Define LSP keymaps on server attach
            vim.api.nvim_create_autocmd("LspAttach", {
                callback = function(args)
                    local bufnr = args.buf
                    local client = vim.lsp.get_client_by_id(args.data.client_id)
                    if client == nil then return end

                    local opts = { buffer = bufnr }
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

            -- Toggle eslint on demand with :EslintToggle
            vim.api.nvim_create_user_command('EslintToggle', function()
                local clients = vim.lsp.get_clients({ name = 'eslint' })
                if #clients > 0 then
                    vim.lsp.stop_client(clients)
                    print('Eslint disabled')
                else
                    vim.lsp.enable('eslint')
                    print('Eslint enabled')
                end
            end, {})

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
                    { name = 'nvim_lsp' },
                    { name = 'buffer' },
                    { name = 'path' },
                    { name = 'luasnip' },
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
