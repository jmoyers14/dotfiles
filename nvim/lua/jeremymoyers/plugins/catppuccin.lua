return {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,  -- Ensures colorscheme loads before other plugins
    config = function()
        require("catppuccin").setup({
            -- You can add any catppuccin configuration options here
            -- For example:
            -- flavour = "mocha", -- latte, frappe, macchiato, mocha
            -- background = { light = "latte", dark = "mocha" },
            -- transparent_background = false,
             custom_highlights = {
                LineNr = { fg = "#958da5" }, -- Normal line numbers
                CursorLineNr = { fg = "#cba6f7" }, -- Current line number
            },
        })
        
        -- Set the colorscheme
        vim.cmd.colorscheme("catppuccin-mocha")
    end,
}
