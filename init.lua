--[[
  File: init.lua
  Description: Entry point file for neovim
]]

-- Bootsraping plugin manager
require("lazy-bootstrap")

-- Settings
require("config.keymaps")
require("config.options")

-- Plugin management
require("lazy").setup({
	--   { import = "base.dashboard" },
	{ import = "base.search" },
	{ import = "base.lsp" },
	{ import = "base.test" },
	{ import = "base.lang" },
	{ import = "plugins" },
}, {})
