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

local spec = {
	{ import = "plugins.lsp" },
	{ import = "plugins.lang" },
	{ import = "plugins.testing" },
	{ import = "plugins.ai" },
	{ import = "plugins" },
}

-- Workspace specific
local is_mac = vim.loop.os_uname().sysname == "Darwin"

if is_mac then
	table.insert(spec, { import = "plugins.work" })
end

-- Plugin management
require("lazy").setup({
	spec = spec,
	install = {
		colorscheme = { "catppuccin" },
	},
})
