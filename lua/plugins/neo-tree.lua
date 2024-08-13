return {
	-- NOTE: removing in favor of oil
	-- {
	-- 	"nvim-neo-tree/neo-tree.nvim",
	-- 	branch = "v2.x",
	-- 	dependencies = {
	-- 		"nvim-lua/plenary.nvim",
	-- 		"MunifTanjim/nui.nvim",
	-- 	},
	-- 	config = function()
	-- 		local neotree = require("neo-tree")

	-- 		neotree.setup({
	-- 			close_if_last_window = true,
	-- 			name = {
	-- 				trailing_slash = true,
	-- 				use_git_status_colors = true,
	-- 				highlight = "NeoTreeFileName",
	-- 			},
	-- 			window = {
	-- 				width = 50,
	-- 				mappings = {
	-- 					["l"] = "open",
	-- 					["h"] = "close_node",
	-- 				},
	-- 			},
	-- 			filesystem = {
	-- 				follow_current_file = true,
	-- 			},
	-- 		})

	-- 		-- keymaps
	-- 		require("config.helpers")
	-- 		nmap("<leader>e", "<cmd>Neotree filesystem reveal float<CR>", "Open Floating Filetree")
	-- 	end,
	-- },
}
