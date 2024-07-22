return {
	{
		-- https://github.com/hedyhli/outline.nvim?tab=readme-ov-file#default-keymaps
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>co", "<cmd>Outline<CR>", desc = "Toggle outline tree" },
		},
		opts = {},
	},
}
