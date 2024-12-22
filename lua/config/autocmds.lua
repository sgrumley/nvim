-- Lsp attachment setup
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
	callback = function(event)
		local map = function(keys, func, desc)
			vim.keymap.set("n", keys, func, { buffer = event.buf, desc = desc })
		end

		-- code nav
		map("gd", require("telescope.builtin").lsp_definitions, "[G]oto [D]efinition")
		map("gr", require("telescope.builtin").lsp_references, "[G]oto [R]eferences")
		map("gi", require("telescope.builtin").lsp_implementations, "[G]oto [I]mplementation")
		map("gt", require("telescope.builtin").lsp_type_definitions, "Type [D]efinition")

		-- code actions
		map("<leader>cr", vim.lsp.buf.rename, "[C]ode [R]ename")
		map("<leader>ca", vim.lsp.buf.code_action, "[C]ode [A]ction")
		map("<leader>cs", require("telescope.builtin").lsp_document_symbols, "[D]ocument [S]ymbols")
		map("<leader>cS", require("telescope.builtin").lsp_dynamic_workspace_symbols, "[W]orkspace [S]ymbols")

		-- docs
		map("K", vim.lsp.buf.hover, "Hover Documentation")
		map("gK", vim.lsp.buf.signature_help, "Signature Help")

		-- diagnostics
		local diaFunc = function(next, severity)
			local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
			severity = severity and vim.diagnostic.severity[severity] or nil
			return function()
				go({ severity = severity })
			end
		end

		map("]d", vim.diagnostic.goto_next, "Next Diagnostic")
		map("[d", vim.diagnostic.goto_prev, "Prev Diagnostic")
		map("]e", diaFunc(true, "ERROR"), "Next Error")
		map("[e", diaFunc(false, "ERROR"), "Prev Error")
		map("]w", diaFunc(true, "WARNING"), "Next Warning")
		map("[w", diaFunc(false, "WARNING"), "Prev Warning")
	end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
	callback = function()
		local format_filetypes = { "lua", "go", "css", "sql", "typescript", "javascript", "rust" }
		if vim.tbl_contains(format_filetypes, vim.bo.filetype) then
			require("conform").format({ async = false, lsp_fallback = true })
		end
	end,
})

-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = { "*.txt", "*.md" },
	callback = function()
		vim.opt.spell = true
		vim.opt.spelllang = "en"
	end,
})

-- don't auto comment new line
vim.api.nvim_create_autocmd("BufEnter", { command = [[set formatoptions-=cro]] })

-- highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
	callback = function()
		vim.highlight.on_yank()
	end,
	group = highlight_group,
	pattern = "*",
})
-- open file at last location
-- api.nvim_create_autocmd("BufReadPost", {
-- 	callback = function()
-- 		local mark = vim.api.nvim_buf_get_mark(0, '"')
-- 		local lcount = vim.api.nvim_buf_line_count(0)
-- 		if mark[1] > 0 and mark[1] <= lcount then
-- 			pcall(vim.api.nvim_win_set_cursor, 0, mark)
-- 		end
-- 	end,
-- })
