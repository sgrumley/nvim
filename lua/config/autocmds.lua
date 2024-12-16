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

-- wrap words "softly" (no carriage return) in mail buffer
-- api.nvim_create_autocmd("Filetype", {
-- 	pattern = "mail",
-- 	callback = function()
-- 		vim.opt.textwidth = 0
-- 		vim.opt.wrapmargin = 0
-- 		vim.opt.wrap = true
-- 		vim.opt.linebreak = true
-- 		vim.opt.columns = 80
-- 		vim.opt.colorcolumn = "80"
-- 	end,
-- })
