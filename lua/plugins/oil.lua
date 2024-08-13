return {
	{
		"stevearc/oil.nvim",
		opts = {},
		config = function()
			local oil = require("oil")
			oil.setup({
				float = {
					max_width = 110,
					max_height = 25,
				},
				keymaps = {
					["q"] = "actions.close",
				},
				-- this is for the oil-vcs-status plugin
				win_options = {
					signcolumn = "number",
				},
			})
			vim.keymap.set("n", "-", oil.toggle_float, { desc = "Oil" })
		end,
		dependencies = { "nvim-tree/nvim-web-devicons" },
		-- - up a dir
		-- _ current working dir
		-- g. toggle hidden
		-- g\\ toggle trash
		-- gs change sort
		-- <C-p> preview
		-- <C-c> close
		-- <C-l> refresh
	},
	{
		"SirZenith/oil-vcs-status",
		dependencies = {
			"stevearc/oil.nvim",
		},
		config = function()
			local status_const = require("oil-vcs-status.constant.status")
			local StatusType = status_const.StatusType

			vim.api.nvim_set_hl(0, "OilVcsStatusAdded", { fg = "#a6e3a1" })
			vim.api.nvim_set_hl(0, "OilVcsStatusModified", { fg = "#fab387" })
			vim.api.nvim_set_hl(0, "OilVcsStatusDeleted", { fg = "#f38ba8" })

			require("oil-vcs-status").setup({
				status_symbol = {
					[StatusType.Added] = "",
					[StatusType.Copied] = "󰆏",
					[StatusType.Deleted] = "",
					[StatusType.Ignored] = "",
					[StatusType.Modified] = "",
					[StatusType.Renamed] = "",
					[StatusType.TypeChanged] = "󰉺",
					[StatusType.Unmodified] = " ",
					[StatusType.Unmerged] = "",
					[StatusType.Untracked] = "",
					[StatusType.External] = "",

					[StatusType.UpstreamAdded] = "󰈞",
					[StatusType.UpstreamCopied] = "󰈢",
					[StatusType.UpstreamDeleted] = "",
					[StatusType.UpstreamIgnored] = " ",
					[StatusType.UpstreamModified] = "󰏫",
					[StatusType.UpstreamRenamed] = "",
					[StatusType.UpstreamTypeChanged] = "󱧶",
					[StatusType.UpstreamUnmodified] = " ",
					[StatusType.UpstreamUnmerged] = "",
					[StatusType.UpstreamUntracked] = " ",
					[StatusType.UpstreamExternal] = "",
				},
				status_hl_group = {
					[StatusType.Added] = "OilVcsStatusAdded",
					[StatusType.Copied] = "OilVcsStatusCopied",
					[StatusType.Deleted] = "OilVcsStatusDeleted",
					[StatusType.Ignored] = "OilVcsStatusIgnored",
					[StatusType.Modified] = "OilVcsStatusModified",
					[StatusType.Renamed] = "OilVcsStatusRenamed",
					[StatusType.TypeChanged] = "OilVcsStatusTypeChanged",
					[StatusType.Unmodified] = "OilVcsStatusUnmodified",
					[StatusType.Unmerged] = "OilVcsStatusUnmerged",
					[StatusType.Untracked] = "OilVcsStatusUntracked",
					[StatusType.External] = "OilVcsStatusExternal",

					[StatusType.UpstreamAdded] = "OilVcsStatusUpstreamAdded",
					[StatusType.UpstreamCopied] = "OilVcsStatusUpstreamCopied",
					[StatusType.UpstreamDeleted] = "OilVcsStatusUpstreamDeleted",
					[StatusType.UpstreamIgnored] = "OilVcsStatusUpstreamIgnored",
					[StatusType.UpstreamModified] = "OilVcsStatusUpstreamModified",
					[StatusType.UpstreamRenamed] = "OilVcsStatusUpstreamRenamed",
					[StatusType.UpstreamTypeChanged] = "OilVcsStatusUpstreamTypeChanged",
					[StatusType.UpstreamUnmodified] = "OilVcsStatusUpstreamUnmodified",
					[StatusType.UpstreamUnmerged] = "OilVcsStatusUpstreamUnmerged",
					[StatusType.UpstreamUntracked] = "OilVcsStatusUpstreamUntracked",
					[StatusType.UpstreamExternal] = "OilVcsStatusUpstreamExternal",
				},
			})
		end,
	},
}
