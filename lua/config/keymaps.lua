require("config.globals")
require("config.helpers")

g.mapleader = " "

-- Neovim
nmap("<leader>q", "<cmd>q!<CR>", "Force Quit")
nmap("<leader>cl", "<cmd>noh<CR>", "Clear Search Highlight")

-- Plugin Menus
nmap("<leader>ml", "<cmd>Lazy home<CR>", "[M]enu [L]azy")
nmap("<leader>mm", "<cmd>Mason<CR>", "[M]enu [M]ason")
nmap("<leader>mt", "<cmd>Telescope<CR>", "[M]enu [T]elescope")

-- Diagnostic
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic")
nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic")
nmap("<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", "[D]iagnostic [O]pen Float")

nmap("[e", "<cmd>lua vim.error.goto_next()<CR>", "Next Diagnostic")
nmap("]e", "<cmd>lua vim.error.goto_prev()<CR>", "Next Diagnostic")
nmap("[w]", "<cmd>lua vim.warning.goto_next()<CR>", "Next Diagnostic")
nmap("]w", "<cmd>lua vim.warning.goto_prev()<CR>", "Next Diagnostic")

-- LSP
-- nmap("<leader>ck", "<cmd>lua require('lsp_signature').toggle_float_win()<CR>", "Foating Signature Help")
-- nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "[g]oto [Declaration]")

-- code
-- nmap("<leader>cd", "<cmd>Telescope lsp_type_definitions<CR>", "List Type Definitions")
-- nmap("<leader>ci", "<cmd>Telescope lsp_implementations<CR>", "List Implementations")
-- nmap("<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", "List Document Symbols")
-- nmap("<leader>cw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "List Workspace Symbols") -- this is super slow, need to be careful with it or filter vendor
-- nmap("<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", "[C]ode [R]ename")
-- nmap("<leader>ca", "<cmd>lua  vim.lsp.buf.code_action()<cr>", "[C]ode [A]ction")

-- Go
-- TODO: this doesn't work
nmap("<leader>lgi", "<cmd>GoImport<CR>", "[L]anguage [G]o [I]mport")
nmap("<leader>lgt", "<cmd>GoAddTag<CR>", "[L]anguage [G]o Add Struct [T]ags")
nmap("<leader>lgs", "<cmd>GoFillStruct<CR>", "[L]anguage [G]o Fill [S]truct")
nmap("<leader>lge", "<cmd>GoIfErr<CR>", "[L]anguage [G]o Insert [E]rror")
nmap("<leader>lgo", "<cmd>GoPkgOutline -f<CR>", "[L]anguage [G]o Package [O]utline") -- pass -p package_name for pkgs other than current
-- GoCodeLensAct will activate code lens but requires it to be activated in gopls

-- Todo figure out if I want fugitive. Need some more research
-- :DiffviewOpen
-- :DiffviewOpen HEAD~2
-- :DiffviewOpen HEAD~4..HEAD~2
-- :DiffviewOpen d4a7b0d
-- :DiffviewOpen d4a7b0d^!
-- :DiffviewOpen d4a7b0d..519b30e
-- :DiffviewOpen origin/main...HEAD

nmap("<leader>gl", "<cmd>LazyGit<CR>", "[G]it [L]azygit") -- open lazy git

-- Tooling
nmap("<leader>phs", "<Plug>RestNvim", "HTTP Send")
nmap("<leader>php", "<Plug>RestNvimPreview", "HTTP Preview")
nmap("<leader>phr", "<Plug>RestNvimLast", "HTTP Rerun")
nmap("<leader>pdb", "<cmd>DBUI<CR>", "DB UI")
nmap("<leader>pgs", "<cmd>Grpc<CR>", "GRPC Send")

-- window management
nmap("<leader>wq", "<cmd>wincmd q<CR>", "Quit Window")
nmap("<leader>ws", "<cmd>vsplit<CR>", "Window Split")
nmap("<leader>wf", "<cmd>wincmd |<CR>", "Window Focus")
nmap("<leader>wr", "<cmd>wincmd =<CR>", "Window Reset Size")
nmap("<leader>wk", "<cmd>vertical resize +50<CR>", "Window Bigger")
nmap("<leader>wj", "<cmd>vertical resize +50<CR>", "Window Smaller")

-- general {{{
local keymap = vim.keymap.set
-- Remap for dealing with word wrap
keymap("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
keymap("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Better viewing
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
keymap("n", "g,", "g,zvzz")
keymap("n", "g;", "g;zvzz")

-- Better indent
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- When deleting text don't copy over yank
keymap("n", "DD", "dd") -- CUT
keymap("v", "D", "d") -- CUT

keymap("n", "dd", '"_dd')
keymap("v", "d", '"_d')
keymap("n", "c", '"_c')
keymap("v", "c", '"_c')
keymap("n", "x", '"_x')
-- Paste over currently selected text without yanking it
keymap("v", "p", '"_dp')

-- Insert blank line
keymap("n", "]<Space>", "o<Esc>")
keymap("n", "[<Space>", "O<Esc>")

-- Auto indent
keymap("n", "i", function()
	if #vim.fn.getline(".") == 0 then
		return [["_cc]]
	else
		return "i"
	end
end, { expr = true })
-- }}}

-- vim:tabstop=2 shiftwidth=2 expandtab syntax=lua foldmethod=marker foldlevelstart=0 foldlevel=0
