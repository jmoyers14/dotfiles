return {
    'nvim-telescope/telescope.nvim',
    branch = '0.1.x',
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
    config = function()
        local builtin = require('telescope.builtin')
        
        -- File pickers
        vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
        vim.keymap.set('n', '<C-p>', builtin.git_files, {})
        
        -- Search pickers
        vim.keymap.set('n', '<leader>pg', builtin.grep_string, {})
        vim.keymap.set('n', '<leader>ps', function() 
            builtin.grep_string({ search = vim.fn.input("Grep > ") })
        end)
        
        -- Git pickers
        vim.keymap.set('n', '<leader>gc', builtin.git_bcommits, {})
        
        -- Help
        vim.keymap.set('n', '<leader>h', builtin.help_tags, {})
    end,
}
