--[[
  File: treesitter.lua
  Description: Mapping of which keys helper
  See: https://github.com/tree-sitter/tree-sitter
  Help `:help nvim-whichkey`
]]
local wk = require('which-key')
wk.register {
    ['<leader>d'] = { name = '[D]iagnostics', _ = 'which_key_ignore' }, -- not sold on this one could be debugging
    ['<leader>f'] = { name = '[F]ind', _ = 'which_key_ignore' },
    ['<leader>m'] = { name = '[M]enu', _ = 'which_key_ignore' },
    ['<leader>c'] = { name = '[C]ode', _ = 'which_key_ignore' },
    ['<leader>cp'] = { name = '[P]eek', _ = 'which_key_ignore' },
    ['<leader>g'] = { name = '[G]it', _ = 'which_key_ignore' },
    ['<leader>gh'] = { name = 'c[H]unk', _ = 'which_key_ignore' },
    ['<leader>l'] = { name = '[L]anguage', _ = 'which_key_ignore' },
    ['<leader>lg'] = { name = '[G]o', _ = 'which_key_ignore' },
    ['<leader>t'] = { name = '[T]esting', _ = 'which_key_ignore' },
    ['<leader>td'] = { name = '[D]ebugging', _ = 'which_key_ignore' },
    ['<leader>u'] = { name = '[U]I', _ = 'which_key_ignore'}
}