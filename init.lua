--[[
  File: init.lua
  Description: Entry point file for neovim
]]

-- Bootsraping plugin manager
require "lazy-bootstrap"

-- Settings
require "config.settings"
require "config.keybindings"

-- Plugin management {{{
require("lazy").setup({
    { import = "base.lsp" },
    { import = "base.lang" },
    { import = "base.search" },
    { import = "base.test" },
    { import = "plugins" },
}, {})
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
