return {
	{
		"rmagatti/goto-preview",
		config = function()
			local gt = require("goto-preview")
			gt.setup({
				height = 25,
				width = 150,
			})

			-- keymaps
			Nmap("gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[P]eek Definition")
			Nmap("gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "[P]eek Type Definition")
			Nmap("gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "[P]eek Implementation")
			Nmap("gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "[P]eek References")
		end,
	},
}
