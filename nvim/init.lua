local Plug = vim.fn['plug#']

vim.call('plug#begin', '~/.config/nvim/plugged')

Plug 'phaazon/hop.nvim'
Plug 'wolflo/vim-huff'
Plug 'catppuccin/nvim'
Plug 'shortcuts/no-neck-pain.nvim'
Plug 'nvim-tree/nvim-tree.lua'

vim.call('plug#end')

require'hop'.setup {
  -- Hop configuration goes there
}

-- Basic nvim-tree configuration
require("nvim-tree").setup({
  -- Optional settings (customize as needed)
  sort_by = "case_sensitive",
  view = {
    width = 30,
    side = "left",
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false, -- Show/hide dotfiles
  },
})

vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

vim.keymap.set("n", "<C-n>", ":NvimTreeToggle<CR>", { noremap = true, silent = true })

local hop = require('hop')
local directions = require('hop.hint').HintDirection
vim.keymap.set('', 'f', function()
  hop.hint_char1({ current_line_only = false })
end, {remap=true})
vim.keymap.set('', 'F', function()
  hop.hint_lines_skip_whitespace({})
end, {remap=true})
vim.keymap.set('', 't', function()
  hop.hint_char1({ direction = directions.AFTER_CURSOR, current_line_only = true, hint_offset = -1 })
end, {remap=true})
vim.keymap.set('', 'T', function()
  hop.hint_char1({ direction = directions.BEFORE_CURSOR, current_line_only = true, hint_offset = 1 })
end, {remap=true})

vim.opt.linebreak = true

-- Insert mode: jk to escape
vim.keymap.set('i', 'jk', '<Esc>', { noremap = true })

-- Insert mode: Ctrl-e to jump to end of line
vim.keymap.set('i', '<C-e>', '<C-o>A', { noremap = true })
