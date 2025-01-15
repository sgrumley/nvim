return {
	{ "tpope/vim-fugitive" },
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviwFocusFiles" },
		keys = {
			{ "<leader>gdm", "<cmd>DiffviewOpen origin/master<cr>", desc = "[G]it [D]iff [m]aster" },
			{ "<leader>gdM", "<cmd>DiffviewOpen origin/main<cr>", desc = "[G]it [D]iff [M]ain" },
			{ "<leader>gdo", "<cmd>DiffviewOpen<cr>", desc = "[G]it [D]iff [o]pen" }, -- this will open to HEAD~1
			{ "<leader>gdc", "<cmd>DiffviewClose<cr>", desc = "[G]it [D]iff [c]lose" },
		},
	},
	{
		"kdheepak/lazygit.nvim",
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		dependencies = {
			"nvim-lua/plenary.nvim",
		},
		keys = {
			{ "<leader>gl", "<cmd>LazyGit<cr>", desc = "LazyGit" },
		},
	},
	{
		-- Adds git related signs to the gutter, as well as utilities for managing changes
		"lewis6991/gitsigns.nvim",
		config = function()
			local gitsigns = require("gitsigns")
			gitsigns.setup({
				signs = {
					add = { text = "+" },
					change = { text = "~" },
					delete = { text = "_" },
					topdelete = { text = "‾" },
					changedelete = { text = "~" },
				},
				on_attach = function(bufnr)
					-- don't override the built-in and fugitive keymaps
					local gs = package.loaded.gitsigns
					vim.keymap.set({ "n", "v" }, "]c", function()
						if vim.wo.diff then
							return "]c"
						end
						vim.schedule(function()
							gs.next_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Jump to next hunk" })
					vim.keymap.set({ "n", "v" }, "[c", function()
						if vim.wo.diff then
							return "[c"
						end
						vim.schedule(function()
							gs.prev_hunk()
						end)
						return "<Ignore>"
					end, { expr = true, buffer = bufnr, desc = "Jump to previous hunk" })
				end,
				current_line_blame = true,
				current_line_blame_opts = {
					virt_text = true,
					virt_text_pos = "right_align",
					delay = 1000,
					ignore_whitespace = false,
				},
			})

			-- keymaps
			Nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "[G]it Preview Chunk")

			Nmap("<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "[G]it [S]tage Chunk")
			Nmap("<leader>gu", "<cmd>Gitsigns reset_hunk<CR>", "[G]it [U]ndo Chunk")
			Nmap("<leader>gs", "<cmd>Telescope git_status<CR>", "[G]it [S]tatus")

			-- merge keymaps
			-- nmap("<leader>gms", "<cmd>Gvdiffsplit!<cr>", "Git Merge Split")
			-- nmap("<leader>gmc", "<cmd>G<cr>", "Git Merge Conflicts List")
			-- nmap("<leader>gml", "<cmd>diffget //2<cr>", "Git Merge Left")
			-- nmap("<leader>gmr", "<cmd>diffget //3<cr>", "Git Merge Right")
			--
			-- nmap("<leader>gb", "<cmd>Telescope git_branches<CR>", "[G]it [B]ranches")
			Nmap("<leader>gb", function()
				require("gitsigns").blame_line({ full = true })
			end, "[G]it [B]lame [C]ommit")
		end,
	},
}
-- NOTE: not sure about permissions for this sort of thing
-- {
-- 	"dlvhdr/gh-blame.nvim",
-- 	dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
-- 	keys = {
-- 		{ "<leader>gbb", "<cmd>GhBlameCurrentLine<cr>", desc = "[G]itHub [B]lame [B]ranch" },
-- 	},
-- },
-- {
-- 	"ruifm/gitlinker.nvim",
--	dependencies = {
-- "nvim-lua/plenary.nvim",
-- },
-- },
