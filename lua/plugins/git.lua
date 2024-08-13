return {
	{ "tpope/vim-fugitive" },
	{
		"sindrets/diffview.nvim",
		event = "VeryLazy",
		cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviwFocusFiles" },
	},
	{
		"dlvhdr/gh-blame.nvim",
		dependencies = { "nvim-lua/plenary.nvim", "MunifTanjim/nui.nvim" },
		keys = {
			{ "<leader>gbb", "<cmd>GhBlameCurrentLine<cr>", desc = "[G]itHub [B]lame [B]ranch" },
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
					-- vim.keymap.set('n', '<leader>gh', require('gitsigns').preview_hunk, { buffer = bufnr, desc = 'Preview git hunk' })

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
			nmap("<leader>gp", "<cmd>Gitsigns preview_hunk<CR>", "[G]it Preview Chunk")

			nmap("<leader>gs", "<cmd>Gitsigns stage_hunk<CR>", "[G]it [S]tage Chunk")
			nmap("<leader>gu", "<cmd>Gitsigns reset_hunk<CR>", "[G]it [U]ndo Chunk")
			nmap("<leader>gs", "<cmd>Telescope git_status<CR>", "[G]it [S]tatus")

			-- diff keymaps
			-- TODO: move these to diffview
			nmap("<leader>gdm", "<cmd>DiffviewOpen master<CR>", "[G]it [D]iff [M]aster")
			nmap("<leader>gdb", "<cmd>DiffviewOpen ", "[G]it [D]iff [B]ranch")
			-- nmap("<leader>gdt", "<cmd>Gitsigns diffthis<CR>", "[G]it [D]iff [T]his")

			-- merge keymaps
			nmap("<leader>gms", "<cmd>Gvdiffsplit!<cr>", "Git Merge Split")
			nmap("<leader>gmc", "<cmd>G<cr>", "Git Merge Conflicts List")
			nmap("<leader>gml", "<cmd>diffget //2<cr>", "Git Merge Left")
			nmap("<leader>gmr", "<cmd>diffget //3<cr>", "Git Merge Right")
			-- :DiffviewOpen
			-- :DiffviewOpen HEAD~2
			-- :DiffviewOpen HEAD~4..HEAD~2
			-- :DiffviewOpen d4a7b0d
			-- :DiffviewOpen d4a7b0d^!
			-- :DiffviewOpen d4a7b0d..519b30e
			-- :DiffviewOpen origin/main...HEAD
			--
			-- These commands are usually done via lazygit
			-- nmap("<leader>gc", "<cmd>Telescope git_bcommits<CR>", "[G]it [C]ommits (Current File)")
			-- nmap("<leader>gca", "<cmd>Telescope git_commits<CR>", "[G]it [C]ommits [A]ll")
			-- nmap("<leader>gb", "<cmd>Telescope git_branches<CR>", "[G]it [B]ranches")

			-- nmap("<leader>gdd", function()
			-- 	vim.cmd("Gitsigns diffthis HEAD")
			-- end, "[G]it [Diff] [H]ead")

			nmap("<leader>gbc", function()
				require("gitsigns").blame_line({ full = true })
			end, "[G]it [B]lame [C]ommit")
		end,
	},
}
