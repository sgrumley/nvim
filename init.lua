--[[
  File: init.lua
  Description: Entry point file for neovim
]]

-- Bootstrap plugin manager
require("lazy-bootstrap")

-- Settings
require("config.keymaps")
require("config.options")
-- unsure about these
-- require("config.autocmds")

-- Plugin management
require("lazy").setup({
	{ import = "plugins.lsp" },
	{ import = "plugins.lang" },
	{ import = "plugins" },
}, {})

-- require("config.go-test")
