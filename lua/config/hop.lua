-- 跳转到文本的任何位置
require("hop").setup { keys = "etovxqpdygfblzhckisuran" }

vim.api.nvim_set_keymap("n", "s", "<cmd>lua require'hop'.hint_char2()<cr>", {})
vim.api.nvim_set_keymap("n", "S", "<cmd>lua require'hop'.hint_patterns()<cr>", {})
