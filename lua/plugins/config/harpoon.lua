require("config.helpers")

-- keymaps
nmap("<leader>am", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Harpoon quick menu")
nmap("<leader>al", "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Harpoon Next")
nmap("<leader>ah", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Harpoon Prev")
nmap("<leader>aa", "<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon Add file")