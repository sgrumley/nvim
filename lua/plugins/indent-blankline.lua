return {
	{
		"lukas-reineke/indent-blankline.nvim",
		main = "ibl",
		opts = {},
		config = function()
			-- local highlight = {
			-- 	"Rosewater",
			-- 	"Mauve",
			-- 	"Peach",
			-- 	"Green",
			-- 	"Lavendar",
			-- }

			-- local hooks = require("ibl.hooks")
			-- -- create the highlight groups in the highlight setup hook, so they are reset
			-- -- every time the colorscheme changes
			-- hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
			-- 	vim.api.nvim_set_hl(0, "Rosewater", { fg = "#f5e0dc" })
			-- 	vim.api.nvim_set_hl(0, "Mauve", { fg = "#cba6f7" })
			-- 	vim.api.nvim_set_hl(0, "Peach", { fg = "#fab387" })
			-- 	vim.api.nvim_set_hl(0, "Green", { fg = "#a6e3a1" })
			-- 	vim.api.nvim_set_hl(0, "Lavendar", { fg = "#b4befe" })
			-- end)

			-- require("ibl").setup({ indent = { highlight = highlight } })
			require("ibl").setup()
		end,
	},
}
