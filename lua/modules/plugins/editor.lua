local editor = {}
-- Navigation
editor["ThePrimeagen/harpoon"]	= {
		dependencies = { "nvim-lua/plenary.nvim" },
		-- keys = function()
		-- 	require("plugins.config.harpoon")
		-- end,
},
	
editor["folke/flash.nvim"] = {
		event = "VeryLazy",
		-- keys = function()
		-- 	require("plugins.config.flash")
		-- end,
},

-- Git

editor = ["sindrets/diffview.nvim"] = {}

editor = [ "tpope/vim-fugitive" ] = {}

editor = ["lewis6991/gitsigns.nvim" ] = {
		config = require("plugins.config.gitsigns")
}