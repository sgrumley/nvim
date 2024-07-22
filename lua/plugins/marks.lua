return {
	{
		"chentoast/marks.nvim",
		config = function()
			require("marks").setup({
				mappings = {
					toggle = "<leader>kt",
					set = "<leader>ks",
					set_next = "<leader>kn",
					preview = "<leader>kp",
					next = "<leader>k]",
					prev = "<leader>k[",
					delete = "<leader>kd",
					delete_buf = "<leader>kb",
				},
			})
		end,
	},
}
