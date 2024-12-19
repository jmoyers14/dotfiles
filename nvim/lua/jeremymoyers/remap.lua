vim.g.mapleader = " "
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)
vim.keymap.set("n", "<leader>f", ":EslintFixAll<CR>")

-- Toggle between realtive and normal line numbers. 
vim.keymap.set('n', '<leader>tn', function()
    vim.wo.relativenumber = not vim.wo.relativenumber
end, { desc = "Toggle relative line numbers" })

-- Generate a github permalink for the current line.
local function generate_github_permalink()
    -- Get the full file path and relative path
    local file_path = vim.fn.expand('%:p')
    local relative_path = vim.fn.expand('%:~:.')
    local line_number = vim.fn.line('.')

    -- Get the repository's remote URL
    local handle = io.popen("git config --get remote.origin.url")
    local repo_url = handle:read("*a")
    handle:close()

    -- Trim any whitespace or newline characters
    repo_url = repo_url:gsub("%s+", "")

    -- Convert the remote URL to the GitHub URL format
    repo_url = repo_url:gsub("git@github.com:", "https://github.com/")
    repo_url = repo_url:gsub("%.git$", "")

    -- Get the current branch name
    local handle_branch = io.popen("git rev-parse --abbrev-ref HEAD")
    local branch = handle_branch:read("*a")
    handle_branch:close()

    -- Trim any whitespace or newline characters
    branch = branch:gsub("%s+", "")

    -- Generate the permalink
    local permalink = repo_url .. "/blob/" .. branch .. "/" .. relative_path .. "#L" .. line_number

    -- Copy the permalink to the clipboard
    vim.fn.setreg('+', permalink)
    print("Permalink copied to clipboard: " .. permalink)
end

vim.api.nvim_create_user_command('GithubPermalink', generate_github_permalink, {})

-- Get and yank the current diagnostic message 
function yank_diagnostic()
    local bufnr = vim.api.nvim_get_current_buf()
    local line = vim.api.nvim_win_get_cursor(0)[1] - 1
    local diagnostics = vim.diagnostic.get(bufnr, {lnum = line})
    
    if #diagnostics > 0 then
        local message = diagnostics[1].message
        vim.fn.setreg('+', message)  -- Copy to system clipboard
        vim.fn.setreg('"', message)  -- Copy to unnamed register
        print("Diagnostic message yanked to clipboard")
    else
        print("No diagnostic message at cursor")
    end
end

-- Set up the keybinding
vim.api.nvim_set_keymap('n', 'gy', '<cmd>lua yank_diagnostic()<CR>', {noremap = true, silent = true})

-- Format D2 files
vim.api.nvim_create_user_command('D2Format', function()
    local file = vim.fn.expand('%')
    local cmd = string.format('d2 fmt %s', file)
    
    vim.fn.system(cmd)
    
    -- Reload the buffer to show changes
    vim.cmd('e!')
    
    print('D2 file formatted')
end, {})


-- Create github link to commit under cursor.
vim.api.nvim_create_user_command('GithubCommitLink', function()
    -- Get the current file path relative to the git root
    local file_path = vim.fn.fnamemodify(vim.fn.expand('%'), ':.')
    
    -- Get the current line number
    local line_number = vim.api.nvim_win_get_cursor(0)[1]
    
    -- Get the GitHub remote URL
    local github_url = vim.fn.system('git config --get remote.origin.url'):gsub('%.git\n$', ''):gsub('^git@github.com:', 'https://github.com/')
    
    -- Get the commit hash and author date for the current line
    local blame_info = vim.fn.system(string.format('git blame -L %d,%d --porcelain %s | head -n 1', line_number, line_number, file_path))
    local commit_hash = blame_info:match('^(%x+)')
    
    if commit_hash and github_url then
        -- Construct the GitHub URL
        local url = string.format('%s/commit/%s', github_url, commit_hash)
        
        -- Copy to clipboard (works on macOS, adjust for other OSes if needed)
        vim.fn.system(string.format('echo "%s" | pbcopy', url))
        
        print('GitHub link copied to clipboard: ' .. url)
    else
        print('Unable to generate GitHub link. Make sure you\'re in a Git repository.')
    end
end, {})

-- Move lines up and down in normal mode
vim.keymap.set('n', '<C-j>', ':m .+1<CR>==', { silent = true })
vim.keymap.set('n', '<C-k>', ':m .-2<CR>==', { silent = true })

-- Move lines up and down in insert mode
vim.keymap.set('i', '<C-j>', '<Esc>:m .+1<CR>==gi', { silent = true })
vim.keymap.set('i', '<C-k>', '<Esc>:m .-2<CR>==gi', { silent = true })

-- Move lines up and down in visual mode
vim.keymap.set('v', '<C-j>', ":m '>+1<CR>gv=gv", { silent = true })
vim.keymap.set('v', '<C-k>', ":m '<-2<CR>gv=gv", { silent = true })

-- Close quickfix menu
vim.keymap.set('n', '<leader>q', ':cclose<CR>', { silent = true })
