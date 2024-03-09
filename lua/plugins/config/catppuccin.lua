local catppuccin = require("catppuccin")

catppuccin.setup({
    integrations = {
        cmp = true,
        gitsigns = true, 
        treesitter = true,
        harpoon = true,
        dap = true, 
        dap_ui = true,
        noice = true,
        telescope = {
            enabled = true,
        },
        illuminate = {
            enabled = true, 
            lsp = false,
        },
    }
})

vim.cmd.colorscheme("catppuccin")