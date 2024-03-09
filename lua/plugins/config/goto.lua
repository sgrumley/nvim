local gt = require("goto-preview")
gt.setup({
    height = 25,
    width = 150,
})

-- keymaps
nmap("gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[P]eek Definition")
nmap("gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "[P]eek Type Definition")
nmap("gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "[P]eek Implementation")
nmap("gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", "[P]eek Type Declaration")
nmap("gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "[P]eek Type Declaration")
nmap("gP", "<cmd>lua require('goto-preview').goto_preview_close_all_win()<CR>", "[P]eek Type Declaration")

