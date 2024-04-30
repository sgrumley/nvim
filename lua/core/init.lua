local global = require("core.global")

local leader_map = function()
	vim.g.mapleader = " "
	-- Below lines is only needed when leader is set to <Space>
	vim.api.nvim_set_keymap("n", " ", "", { noremap = true })
	vim.api.nvim_set_keymap("x", " ", "", { noremap = true })
end

local clipboard_config = function()
	if global.is_mac then
		vim.g.clipboard = {
			name = "macOS-clipboard",
			copy = { ["+"] = "pbcopy", ["*"] = "pbcopy" },
			paste = { ["+"] = "pbpaste", ["*"] = "pbpaste" },
			cache_enabled = 0,
		}
	elseif global.is_wsl then
		vim.g.clipboard = {
			name = "psyank-wsl",
			copy = {
				["+"] = "clip.exe",
				["*"] = "clip.exe",
			},
			paste = {
				["+"] = [[powershell.exe -NoProfile -NoLogo -NonInteractive -Command [console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
				["*"] = [[powershell.exe -NoProfile -NoLogo -NonInteractive -Command [console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))]],
			},
			cache_enabled = 0,
		}
	elseif os.getenv("TMUX") then
		vim.g.clipboard = {
			name = "tmux",
			copy = {
				["+"] = "tmux set-buffer -w",
				["*"] = "tmux set-buffer -w",
			},
			paste = {
				["+"] = "tmux save-buffer -",
				["*"] = "tmux save-buffer -",
			},
			cache_enabled = 0,
		}
	end
end


local load_core = function()
	leader_map()

	clipboard_config()

	-- require("core.options")
	-- require("core.mapping")
	-- require("core.event")
	require("core.pack")
	-- require("keymap")

	local colorscheme = require("core.settings").colorscheme
	local background = require("core.settings").background
	vim.api.nvim_command("set background=" .. background)
	vim.api.nvim_command("colorscheme " .. colorscheme)
end

load_core()
