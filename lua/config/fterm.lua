require("FTerm").setup {
	dimensions = {
		height = 0.8,
		width = 0.8,
		x = 0.5,
		y = 0.5,
	},
	border = "single", -- or 'double'
}

local term = require "FTerm.terminal"

-- Running gitui
local gitui = term:new():setup {
	cmd = "gitui",
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
}
function _G.__fterm_gitui()
	gitui:toggle()
end

local termp = term:new():setup {
}
function _G.__fterm_termp()
	termp:toggle()
end

-- Running bpytop
local top = term:new():setup {
	cmd = "bpytop",
}
-- Use this to toggle bpytop in a floating terminal
function _G.__fterm_top()
	top:toggle()
end

-- Keybinding
local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

map("n", "<A-i>", '<CMD>lua require("FTerm").toggle()<CR>', opts)
map("t", "<A-i>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>', opts)

map("n", "<A-O>", "<CMD>lua __fterm_gitui()<CR>", opts)
map("t", "<A-O>", "<C-\\><C-n><CMD>lua __fterm_gitui()<CR>", opts)

map("n", "<A-g>", "<CMD>lua __fterm_termp()<CR>", opts)
map("t", "<A-g>", "<C-\\><C-n><CMD>lua __fterm_termp()<CR>", opts)
