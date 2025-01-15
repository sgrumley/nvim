return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			modes = {
				char = {
					jump_labels = true,
					keys = {}, -- explicitly remove the standard 'f' functionality in favor of the below keymaps
				},
			},
		},
		keys = {
			{
				"f",
				mode = { "n", "x", "o" },
				function()
					require("flash").jump()
				end,
				desc = "Jump Text",
			},
			{
				"F",
				mode = { "n", "x", "o" },
				function()
					require("flash").treesitter()
				end,
				desc = "Jump Treesitter Nodes",
			},
		},
	},
}
