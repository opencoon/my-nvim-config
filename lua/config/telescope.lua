#!/usr/bin/env lua

-- 弹窗
-- This will load fzy_native and have it override the default file sorter
require("telescope").load_extension "fzy_native"

-- see https://github.com/nvim-telescope/telescope.nvim/blob/master/lua/telescope/pickers/layout_strategies.lua
nnoremap { "<leader>t", "<cmd>Telescope<cr>" }
nnoremap { "<leader>g", "<cmd>lua require('telescope.builtin').find_files()<cr>" }
nnoremap { "<leader><leader>", "<cmd>lua require('telescope.builtin').live_grep()<cr>" }
nnoremap { "<leader>m", "<cmd>lua require('telescope.builtin').marks()<cr>" }
nnoremap { "<leader>gi", "<cmd>lua require('telescope.builtin').git_status()<cr>" }
nnoremap { "<leader>gc", "<cmd>lua require('telescope.builtin').git_commits()<cr>" }
nnoremap { "<leader>gs", "<cmd>lua require('telescope.builtin').git_stash()<cr>" }
nnoremap { "<leader>cc", "<cmd>lua require('telescope.builtin').keymaps()<cr>" }
nnoremap { "<leader>d", "<cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>" }

-- internal.buffers
-- https://github.com/nvim-telescope/telescope.nvim/blob/9cad3a4a5d0e36b07b25c4be1db1c1306fcec945/lua/telescope/builtin/internal.lua
nnoremap {
	"<leader>b",
	"<cmd>lua require('telescope.builtin').buffers({ignore_current_buffer = true, sort_mru = true, layout_strategy='vertical',layout_config={width=80}})<cr>",
}
nnoremap { "<leader>h", "<cmd>lua require('telescope.builtin').help_tags()<cr>" }

local actions = require "telescope.actions"
-- Global remapping
------------------------------
require("telescope").setup {
	defaults = {
		mappings = {
			i = {
				-- To disable a keymap, put [map] = false
				-- So, to not map "<C-n>", just put
				["<C-n>"] = false,
				["<C-p>"] = false,

				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
	},
	pickers = {
		find_files = {
			prompt_prefix = "🔍",
		},
	},
	extensions = {
		-- telescope-undo.nvim config
		undo = {
			use_delta = true,
			side_by_side = true,
			diff_context_lines = 3,
			layout_strategy = "vertical",
			layout_config = {
				preview_height = 0.8,
			},
		},
	},
}

require("telescope").load_extension "undo"
-- telescope-undo.nvim default mappings
-- "<cr>" require("telescope-undo.actions").yank_additions,
-- "<S-cr>" require("telescope-undo.actions").yank_deletions,
-- "<C-cr>" require("telescope-undo.actions").restore,
vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
