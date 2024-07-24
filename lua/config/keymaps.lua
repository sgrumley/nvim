require("config.helpers")
require("config.globals")

g.mapleader = " "

-- Neovim
nmap("<leader>q", "<cmd>q!<CR>", "Force Quit")
nmap("<leader>cl", "<cmd>noh<CR>", "Clear Search Highlight")

-- Plugin Menus
nmap("<leader>ml", "<cmd>Lazy home<CR>", "[M]enu [L]azy")
nmap("<leader>mm", "<cmd>Mason<CR>", "[M]enu [M]ason")
nmap("<leader>mt", "<cmd>Telescope<CR>", "[M]enu [T]elescope")

-- move lines
nmap("<A-j>", "<cmd>m .+1<cr>==", "Move down")
nmap("<A-k>", "<cmd>m .-2<cr>==", "Move up")
imap("<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
imap("<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
vmap("<A-j>", ":m '>+1<cr>gv=gv", "Move down")
vmap("<A-k>", ":m '<-2<cr>gv=gv", "Move up")

-- window management
nmap("<leader>wq", "<cmd>wincmd q<CR>", "Quit Window")
nmap("<leader>ws", "<cmd>vsplit<CR>", "Window Split")
nmap("<leader>wf", "<cmd>wincmd |<CR>", "Window Focus")
nmap("<leader>wr", "<cmd>wincmd =<CR>", "Window Reset Size")
nmap("<leader>wl", "<cmd>vertical resize +50<CR>", "Window Bigger")
nmap("<leader>wh", "<cmd>vertical resize -50<CR>", "Window Smaller")
nmap("<leader>wk", "<cmd>resize +8<CR>", "Horizontal Window Bigger")
nmap("<leader>wj", "<cmd>resize -8<CR>", "Horizontal Window Smaller")

-- Folds
nmap("<leader>zo", "zR", "Open All")
nmap("<leader>zc", "zM", "Close All")
nmap("<leader>za", "za", "Toggle At Cursor")

-- QOL
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

-- TODO: move somewhere else
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

nmap("<leader>gl", "<cmd>LazyGit<CR>", "[G]it [L]azygit") -- open lazy git
