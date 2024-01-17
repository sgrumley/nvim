require("helpers/globals")
require("helpers/keyboard")

g.mapleader = " "

-- Neovim {{{
nmap("<leader>q", "<cmd>q!<CR>", "Force Quit")
nmap(";", "<cmd>FineCmdline<CR>", "Enter Fine Command Line Mode")
-- c-w has all window commands they might be nice to move behind leader, otherwise some sort of way to remember. also different section of keymap
-- find command: nmap('<leader>wc', 'cycle window', '[W]indow [C]ycle')
-- }}}

-- Terminal {{{
nmap("<leader>s", "<cmd>ToggleTerm<CR>", "Open [Shell]")
-- }}}

-- Harpoon {{{
nmap("<leader>am", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>", "Toggle Harpoon quick menu")
nmap("<leader>al", "<cmd>lua require('harpoon.ui').nav_next()<CR>", "Harpoon Next")
nmap("<leader>ah", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", "Harpoon Prev")
nmap("<leader>aa", "<cmd>lua require('harpoon.mark').add_file()<CR>", "Harpoon Add file")
-- }}}

-- Telescope {{{
nmap("<leader>fr", "<cmd>Telescope oldfiles<CR>", "[F]ind [R]ecent Files")
nmap("<leader>fg", "<cmd>Telescope git_files<CR>", "[F]ind [G]it Files")
nmap("<leader>ff", "<cmd>Telescope find_files<CR>", "[F]ind [F]iles")
nmap("<leader>fp", "<cmd>Telescope jumplist<CR>", "[F]ind [P]laces (previous locations)")
nmap("<leader>fl", "<cmd>Telescope live_grep<CR>", "[F]ind [L]ive grep")
nmap("<leader>fb", "<cmd>Telescope buffers<CR>", "[F]ind [B]uffers")
-- vim.keymap.set('n', '<leader>sr', require('telescope.builtin').resume, { desc = '[S]earch [R]esume' })
-- vim.keymap.set('n', '<leader>sh', require('telescope.builtin').help_tags, { desc = '[S]earch [H]elp' })
-- }}}

-- Neo Tree {{{
nmap("<leader>e", "<cmd>Neotree filesystem reveal float<CR>", "Open Floating Filetree")
-- }}}

-- Plugin Menus {{{
nmap("<leader>ml", "<cmd>Lazy home<CR>", "[M]enu [L]azy")
nmap("<leader>mm", "<cmd>Mason<CR>", "[M]enu [M]ason")
nmap("<leader>mt", "<cmd>Telescope<CR>", "[M]enu [T]elescope")
-- }}}

-- Diagnostic {{{
nmap("[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", "Previous Diagnostic")
nmap("]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", "Next Diagnostic")
-- TODO: don't need both of the options below. Keep telescope func as a varient
-- vim.keymap.set('n', '<leader>sd', require('telescope.builtin').diagnostics, { desc = '[S]earch [D]iagnostics' })
nmap("<leader>do", "<cmd>lua vim.diagnostic.open_float()<CR>", "[D]iagnostic [O]pen Float")
nmap("<leader>dl", "<cmd>lua vim.diagnostic.setloclist()<CR>", "[D]iagnostic [L]oclist")
-- }}}

-- LSP {{{
nmap("K", "<cmd>lua vim.lsp.buf.hover()<CR>", "Show Documentation")
nmap("C-k", "<cmd>lua vim.lsp.buf.signature_help()<CR>", "Signature Help") -- this might be replaced with plugin
nmap("<leader>ck", "<cmd>lua require('lsp_signature').toggle_float_win()<CR>", "Foating Signature Help")

nmap("gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", "[g]oto [Declaration]")
nmap("gd", "<cmd>Telescope lsp_definitions<CR>", "[g]oto [d]efinitions")
nmap("gr", "<cmd>Telescope lsp_references<CR>", "[g]oto [r]eferences")
nmap("gI", "<cmd>Telescope lsp_implementations<CR>", "[g]oto [I]mplementations")

-- peek
nmap("gpd", "<cmd>lua require('goto-preview').goto_preview_definition()<CR>", "[P]eek Definition")
nmap("gpt", "<cmd>lua require('goto-preview').goto_preview_type_definition()<CR>", "[P]eek Type Definition")
nmap("gpi", "<cmd>lua require('goto-preview').goto_preview_implementation()<CR>", "[P]eek Implementation")
nmap("gpD", "<cmd>lua require('goto-preview').goto_preview_declaration()<CR>", "[P]eek Type Declaration")
nmap("gpr", "<cmd>lua require('goto-preview').goto_preview_references()<CR>", "[P]eek Type Declaration")
nmap("gP", "<cmd>lua require('goto-preview').goto_preview_close_all_win()<CR>", "[P]eek Type Declaration")

-- telescope
nmap("<leader>cd", "<cmd>Telescope lsp_type_definitions<CR>", "List Type Definitions")
nmap("<leader>cs", "<cmd>Telescope lsp_document_symbols<CR>", "List Document Symbols")
nmap("<leader>cw", "<cmd>Telescope lsp_dynamic_workspace_symbols<CR>", "List Workspace Symbols") -- this is super slow, need to be careful with it or filter vendor
nmap("<leader>cr", "<cmd>lua vim.lsp.buf.rename()<CR>", "[C]ode [R]ename")
nmap("<leader>ca", "<cmd>lua  vim.lsp.buf.code_action()<cr>", "[C]ode [A]ction")
-- }}}

-- Go {{{
nmap("<leader>lgc", "<cmd>GoCmt<CR>", "[L]anguage [G]o [C]omment")
nmap("<leader>lgi", "<cmd>GoImport<CR>", "[L]anguage [G]o [I]mport")
nmap("<leader>lgt", "<cmd>GoAddTag<CR>", "[L]anguage [G]o Add Struct [T]ags")
nmap("<leader>lgs", "<cmd>GoFillStruct<CR>", "[L]anguage [G]o Fill [S]truct")
nmap("<leader>lge", "<cmd>GoIfErr<CR>", "[L]anguage [G]o Insert [E]rror")
nmap("<leader>lgl", "<cmd>GoLint<CR>", "[L]anguage [G]o [L]int")
nmap("<leader>lgo", "<cmd>GoPkgOutline -f<CR>", "[L]anguage [G]o Package [O]utline") -- pass -p package_name for pkgs other than current
nmap("<leader>lgf", "<cmd>GoFmt<CR>", "[L]anguage [G]o [F]ormat")
nmap("<leader>lgm", "<cmd>GoModTidy<CR>", "[L]anguage [G]o [M]od Tidy")
nmap("<leader>lgv", "<cmd>GoModVendor<CR>", "[L]anguage [G]o [M]od Tidy")
nmap("<leader>lga", "<cmd>GoCodeAction<CR>", "[L]anguage [G]o Code [A]ction") -- not sure this is needed
-- GoCodeLensAct will activate code lens but requires it to be activated in gopls
-- there is an option for GoJson2Stuct <struct_name>
-- register somewhere cmd GoCheat and GoDoc
-- GoImpl <interface_name>
-- }}}

-- Debugging {{{

-- }}}

-- Testing {{{
nmap("<leader>th", "<cmd>GoTest -n<CR>", "[T]est [H]ere")
nmap("<leader>tf", "<cmd>GoTest -f<CR>", "[T]est [F]ile")
nmap("<leader>ta", "<cmd>GoTest<CR>", "[T]est [A]ll")
nmap("<leader>ts", "<cmd>GoAltS<CR>", "Open [T]est File In [S]plit")
nmap("<leader>to", "<cmd>GoAlt<CR>", "Open [T]est File")

nmap("<leader>tdd", "<cmd>GoDebug -t<CR>", "[T]est [D]ebug") -- if the current file is not the test this will go to the test file, if cursor is in func it will db that func otherwise it will db the file
nmap("<leader>tdr", "<cmd>GoDebug -R<CR>", "[T]est [D]ebug [R]estart")
nmap("<leader>tds", "<cmd>GoDebug -s<CR>", "[T]est [D]ebug [S]top")
nmap("<leader>td?", "<cmd>GoDbgKeys<CR>", "[T]est [D]ebug Session Key Maps")
-- todo golang test coverage toggle
-- }}}

-- Git {{{
-- todo: need to move git chunk navigation from gitsigns here
nmap("<leader>ghp", "<cmd>Gitsigns preview_hunk<CR>", "[G]it Preview Chunk")
nmap("<leader>ghd", "<cmd>Gitsigns diffthis<CR>", "[G]it [D]iff") -- diff current file. Is this only from main?
nmap("<leader>ghs", "<cmd>Gitsigns stage_hunk<CR>", "[G]it [S]tage Chunk")
nmap("<leader>ghu", "<cmd>Gitsigns reset_hunk<CR>", "[G]it [U]ndo Chunk")

nmap("<leader>ghb", "<cmd>Telescope git_branches<CR>", "[G]it [B]ranches")
-- Todo figure out if I want fugitive. Need some more research
-- can use https://github.com/pwntester/octo.nvim to review prs in neovim. Am I looking for this or just a way to diff the changes?

nmap("<leader>gl", "<cmd>LazyGit<CR>", "[G]it [L]azygit") -- open lazy git
-- }}}

-- window management

-- treesitter

-- database

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
keymap("n", "dd", '"_dd')
keymap("n", "c", '"_c')
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
