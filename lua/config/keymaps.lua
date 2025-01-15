require("config.helpers")

--[[
  Helpful Commands
  - `:verbose setlocal ts?` -> shows what last changed tabshift option
  - `:cnext` -> next file in quickfix list (good for git merges)
  - [c-q] -> dumps telescope list into quickfix
]]

vim.g.mapleader = " "

-- after go mod tidy you need to restart the LSP
Nmap("<leader>R", "<cmd>LspRestart<CR>", "Restart LSP")

-- Neovim
Nmap("<leader>q", "<cmd>q!<CR>", "Force Quit")
Nmap("<leader>h", "<cmd>noh<CR>", "Clear Search Highlight")
-- Weird paste fix
vim.api.nvim_set_keymap("n", "<leader>M", "mmHmt:%s/\\r//ge<CR>'tzt'm", { noremap = true, silent = true })

-- Plugin Menus
Nmap("<leader>ml", "<cmd>Lazy home<CR>", "[M]enu [L]azy")
Nmap("<leader>mm", "<cmd>Mason<CR>", "[M]enu [M]ason")
Nmap("<leader>mt", "<cmd>Telescope<CR>", "[M]enu [T]elescope")

-- move lines
Nmap("<A-j>", "<cmd>m .+1<cr>==", "Move down")
Nmap("<A-k>", "<cmd>m .-2<cr>==", "Move up")
Imap("<A-j>", "<esc><cmd>m .+1<cr>==gi", "Move down")
Imap("<A-k>", "<esc><cmd>m .-2<cr>==gi", "Move up")
Vmap("<A-j>", ":m '>+1<cr>gv=gv", "Move down")
Vmap("<A-k>", ":m '<-2<cr>gv=gv", "Move up")

-- window management
Nmap("<leader>wq", "<cmd>wincmd q<CR>", "Quit Window")
Nmap("<leader>ws", "<cmd>vsplit<CR>", "Window Split")
Nmap("<leader>wf", "<cmd>wincmd |<CR>", "Window Focus")
Nmap("<leader>wr", "<cmd>wincmd =<CR>", "Window Reset Size")
Nmap("<leader>wl", "<cmd>vertical resize +50<CR>", "Window Bigger")
Nmap("<leader>wh", "<cmd>vertical resize -50<CR>", "Window Smaller")
Nmap("<leader>wk", "<cmd>resize +8<CR>", "Horizontal Window Bigger")
Nmap("<leader>wj", "<cmd>resize -8<CR>", "Horizontal Window Smaller")

-- Folds
Nmap("<leader>zo", "zR", "Open All")
Nmap("<leader>zc", "zM", "Close All")
Nmap("<leader>za", "za", "Toggle At Cursor")

-- navigate through word wrap like it's a new line
vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true })
vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true })

-- Scrolling
-- Center screen when page up / page down
Nmap("<C-d>", "<C-d>zz")
Nmap("<C-u>", "<C-u>zz")

-- Center screen when interating through search results
Nmap("n", "nzzzv")
Nmap("N", "Nzzzv")

-- Better indent
Vmap("<", "<gv")
Vmap(">", ">gv")

-- When deleting text don't copy over yank
Nmap("DD", "dd") -- CUT
Vmap("D", "d") -- CUT
-- TODO: this should work for all instances of d e.g. diw
Nmap("dd", '"_dd')
Nmap("d", '"_d')
Nmap("c", '"_c')
Vmap("c", '"_c')
Nmap("x", '"_x')

-- Paste over currently selected text without yanking it
Vmap("p", '"_dp')

-- Insert blank line
Nmap("]<Space>", "o<Esc>")
Nmap("[<Space>", "O<Esc>")
