return {
    'prettier/vim-prettier',
    build = 'yarn install --frozen-lockfile --production',
    config = function()
        -- Only enable prettier for specific filetypes
        vim.g['prettier#file_types'] = {
            'typescript',
            'javascript',
            'typescriptreact',
            'javascriptreact',
            'css',
            'html',
            'json'
        }
        -- Format on save
        vim.g['prettier#autoformat'] = 1
        vim.g['prettier#autoformat_require_pragma'] = 0

        -- Format with leader-p
        vim.keymap.set('n', '<leader>p', ':Prettier<CR>', { noremap = true })
    end
}
