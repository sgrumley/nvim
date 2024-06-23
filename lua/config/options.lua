require("config.globals")
-- Tabs
opt.expandtab = true -- Use spaces by default
opt.shiftwidth = 2 -- Set amount of space characters, when we press "<" or ">"
opt.tabstop = 2 -- 1 tab equal 2 spaces
opt.smartindent = true -- Turn on smart indentation. See in the docs for more info

-- Clipboard
opt.clipboard = "unnamedplus" -- Use system clipboard
opt.fixeol = false -- Turn off appending new line in the end of a file
if vim.fn.has("wsl") == 1 then
	vim.api.nvim_create_autocmd("TextYankPost", {

		group = vim.api.nvim_create_augroup("Yank", { clear = true }),

		callback = function()
			vim.fn.system("clip.exe", vim.fn.getreg('"'))
		end,
	})
end

-- Folding
opt.foldmethod = "syntax"

-- Line Number
opt.number = true
opt.relativenumber = true

-- Search
opt.ignorecase = true -- Ignore case if all characters in lower case
opt.joinspaces = false -- Join multiple spaces in search
opt.smartcase = true -- When there is a one capital letter search for exact match
opt.showmatch = true -- Highlight search instances
opt.incsearch = true -- incremental searching as you type

-- Window
opt.splitbelow = true -- Put new windows below current
opt.splitright = true -- Put new vertical splits to right

-- Wild Menu
opt.wildmenu = true
opt.wildmode = "longest:full,full"

-- Quality Of Life
vim.o.termguicolors = true
vim.o.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
vim.o.undofile = true -- Save undo history
vim.o.breakindent = true -- Enable break indent
opt.signcolumn = "yes" -- reserves room on the left side of the buffer for things such as error markers or break points

-- [[ Highlight on yank ]]
-- See `:help vim.highlight.on_yank()`
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})

-- Default Plugins {{{
local disabled_built_ins = {
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"gzip",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"2html_plugin",
	"logipat",
	"rrhelper",
	"spellfile_plugin",
	"matchit",
}

for _, plugin in pairs(disabled_built_ins) do
	g["loaded_" .. plugin] = 1
end
-- }}}

-- vim: tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=1
