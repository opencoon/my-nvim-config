nnoremap { "<F7>", ":MundoToggle<CR>" }
nnoremap { "<leader>h", ":MundoToggle<cr>" }

-- 修改记录
Variable.g {
	-- Default: 1 (auto preview diff)
	mundo_auto_preview = 1,
	mundo_width = 60,
	mundo_preview_height = 35,
	-- set to 1 open on the right side
	mundo_right = 1,
	mundo_preview_bottom = 0,
}
