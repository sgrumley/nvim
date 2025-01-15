--[[
  File: init.lua
  Description: Entry point file for neovim
]]

-- Bootstrap plugin manager
require("lazy-bootstrap")

-- Settings
require("config.keymaps")
require("config.options")
require("config.autocmds")

-- Plugin management
require("lazy").setup({
	spec = {
		{ import = "plugins.lsp" },
		{ import = "plugins.lang" },
		{ import = "plugins.testing" },
		{ import = "plugins" },
	},
	install = {
		colorscheme = { "catppuccin" },
	},
})
