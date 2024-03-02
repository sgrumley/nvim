--[[
  File: telescope.lua
  Description: Telescope plugin configuration
  See: https://github.com/nvim-telescope/telescope.nvim
]]
local actions = require("telescope.actions")
local telescope = require("telescope")
telescope.setup({
	defaults = {
		file_ignore_patterns = {
			"vendor",
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
})

-- Enable telescope fzf native, if installed
pcall(require("telescope").load_extension, "fzf")
-- if i get octo plugin enable plugin here
-- telescope docker
