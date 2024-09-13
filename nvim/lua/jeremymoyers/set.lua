vim.opt.nu = true
vim.opt.relativenumber = true
vim.opt.splitright = true

vim.opt.tabstop = 4
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true

vim.opt.smartindent = true

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.colorcolumn = "80"

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 50

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

