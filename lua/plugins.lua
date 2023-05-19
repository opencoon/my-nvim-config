-- This file can be loaded by calling `lua require('plugins')` from your init.vim

require "utils"

-- nnoremap { '<leader>hello', function() print("Hello world, from lua") end }

require("lazy").setup({
	{
		"folke/which-key.nvim",
		config = function()
			vim.o.timeout = true
			vim.o.timeoutlen = 300
			require("which-key").setup {
			}
		end
	},
	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "v2.x",
		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
			"MunifTanjim/nui.nvim",
		},
		config = function()
			nnoremap { "<leader>f", ":NeoTreeFocusToggle<CR>", silent = true }
			nnoremap { "<leader>fd", ":NeoTreeFocus<CR>", silent = true }
			nnoremap { "<leader>ff", ":NeoTreeReveal<CR>", silent = true }
		end
	},
	{
		"github/copilot.vim",
		config = function()
			vim.g.copilot_no_tab_map = true
			vim.g.copilot_assume_mapped = true
			vim.api.nvim_set_keymap("i", "<C-l>", 'copilot#Accept("<CR>")', { silent = true, expr = true })
		end
	},
	-- {
	-- 	"folke/noice.nvim",
	-- 	config = function()
	-- 		require("noice").setup({
	-- 			-- add any options here
	-- 			lsp = {
	-- 				signature = {
	-- 					enabled = false
	-- 				},
	-- 				-- override markdown rendering so that **cmp** and other plugins use **Treesitter**
	-- 				override = {
	-- 					["vim.lsp.util.convert_input_to_markdown_lines"] = true,
	-- 					["vim.lsp.util.stylize_markdown"] = true,
	-- 					["cmp.entry.get_documentation"] = true,
	-- 				},
	-- 			},
	-- 			-- you can enable a preset for easier configuration
	-- 			presets = {
	-- 				bottom_search = true,    -- use a classic bottom cmdline for search
	-- 				command_palette = true,  -- position the cmdline and popupmenu together
	-- 				long_message_to_split = true, -- long messages will be sent to a split
	-- 				inc_rename = false,      -- enables an input dialog for inc-rename.nvim
	-- 				lsp_doc_border = false,  -- add a border to hover docs and signature help
	-- 			},
	-- 		})
	-- 	end,
	-- 	dependencies = {
	-- 		-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
	-- 		"MunifTanjim/nui.nvim",
	-- 		-- OPTIONAL:
	-- 		--   `nvim-notify` is only needed, if you want to use the notification view.
	-- 		--   If not available, we use `mini` as the fallback
	-- 		"rcarriga/nvim-notify",
	-- 	}
	-- },
	-- treesitter = AST (syntax/parsing)
	-- LSP = whole-project semantic analysis
	-- https://github.com/nvim-treesitter/nvim-treesitter
	{
		"nvim-treesitter/nvim-treesitter",
		-- branch = "0.5-compat",
		build = ":TSUpdate",
		config = function()
			require "config.nvim-treesitter"
		end,
	},

	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
	},

	"stevearc/dressing.nvim",
	{
		"ThePrimeagen/harpoon",
		config = function()
			require("harpoon").setup()
			vim.api.nvim_set_keymap("n", "<leader>m", "<cmd>lua require('harpoon.mark').add_file()<CR>", { silent = false })
			vim.api.nvim_set_keymap("n", "<leader>hn", "<cmd>lua require('harpoon.ui').nav_next()<CR>", { silent = false })
			vim.api.nvim_set_keymap("n", "<leader>hp", "<cmd>lua require('harpoon.ui').nav_prev()<CR>", { silent = false })
			vim.api.nvim_set_keymap("n", "<leader>hh", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<CR>",
				{ silent = false })
		end,
		dependencies = { "nvim-lua/plenary.nvim" }
	},
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate", -- :MasonUpdate updates registry contents
		config = function()
			require("mason").setup()
		end
	},
	{
		'akinsho/bufferline.nvim',
		version = "*",
		dependencies = 'nvim-tree/nvim-web-devicons',
		config = function()
			require("bufferline").setup {
				options = {
					mode = "tabs",
					offsets = {
						{
							filetype = "neo-tree",
							text = "File Explorer",
							text_align = "center",
							separator = true
						}, {
						filetype = "dbui",
						text = "DB Explorer",
						text_align = "center",
						separator = true
					}

					},
				}
			}
			vim.api.nvim_set_keymap("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>bl", "<cmd>BufferLinePick<CR>", { silent = true })
		end
	},

	{
		"ahmedkhalf/project.nvim",
		config = function()
			require("project_nvim").setup {
			}
		end
	},
	{
		"nvim-pack/nvim-spectre",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("spectre").setup {}
			-- open
			vim.api.nvim_set_keymap("n", "<leader>S", "<cmd>lua require('spectre').open()<CR>", { silent = true })
			vim.api.nvim_set_keymap("n", "<leader>sc", "<cmd>lua require('spectre').close()<CR>", { silent = true })
			-- search current word
			vim.api.nvim_set_keymap("n", "<leader>sn", "<cmd>lua require('spectre').open_visual({select_word=true})<CR>",
				{ silent = true })
			vim.api.nvim_set_keymap("v", "<leader>S", "<esc>:lua require('spectre').open_visual()<CR> ", { silent = true })

			-- search in current file
			vim.api.nvim_set_keymap("n", "<leader>sp", "viw:lua require('spectre').open_file_search()<cr>", { silent = true })
		end,
	},

	{
		"rest-nvim/rest.nvim",
		config = function()
			require("rest-nvim").setup({
				-- Open request results in a horizontal split
				result_split_horizontal = true,
				-- Keep the http file buffer above|left when split horizontal|vertical
				result_split_in_place = false,
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = false,
				-- Encode URL before making request
				encode_url = true,
				-- Highlight request on run
				highlight = {
					enabled = true,
					timeout = 150,
				},
				result = {
					-- toggle showing URL, HTTP info, headers at top the of result window
					show_url = true,
					show_http_info = true,
					show_headers = true,
					-- executables or functions for formatting response body [optional]
					-- set them to false if you want to disable them
					formatters = {
						json = "jq",
						html = function(body)
							return vim.fn.system({ "tidy", "-i", "-q", "-" }, body)
						end
					},
				},
				-- Jump to request line on run
				jump_to_request = false,
				env_file = '.env',
				custom_dynamic_variables = {},
				yank_dry_run = true,
			})
			nnoremap { "<leader>re", ":lua require('rest-nvim').run()<cr>" }
			vnoremap { "<leader>re", ":lua require('rest-nvim').run()<cr>" }
		end,
		dependencies = { "nvim-lua/plenary.nvim" }
	},

	"tpope/vim-dadbod",
	{
		"kristijanhusak/vim-dadbod-ui",
		config = function()
			nnoremap { "<leader>db", ":DBUI<cr>" }
			vnoremap { "<leader>db", ":DBUI<cr>" }
		end
	},
	{
		"vim-test/vim-test",
		config = function()
			vim.g["test#go#gotest#options"] = "-v --count=1"
			nnoremap { "<leader>tl", ":TestLast<cr>" }
			nnoremap { "<leader>tf", ":TestFile<cr>" }
			nnoremap { "<leader>tr", ":TestNearest<cr>" }
		end
	},
	{
		"sebdah/vim-delve",
		config = function()
			nnoremap { "<leader>tb", ":DlvToggleBreakpoint<cr>" }
			nnoremap { "<leader>tc", ":DlvClearAll<cr>" }
			nnoremap { "<leader>tv", ":DlvTest<cr>" }
		end
	},
	{
		"voldikss/vim-translate-me",
		config = function()
			vmap { "<Leader>fy", ":Translate<Enter>" }
			nmap { "<Leader>fy", ":Translate<Enter>" }
		end
	},

	-- https://github.com/folke/todo-comments.nvim
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("todo-comments").setup {
				-- your configuration comes here
				-- or leave it empty to use the default settings
				-- refer to the configuration section below
			}
			nnoremap { "tn", ":lua require('todo-comments').jump_next()<cr>" }
			nnoremap { "tp", ":lua require('todo-comments').jump_prev()<cr>" }
			nnoremap { "<leader>tt", ":TodoTelescope<cr>" }
		end,
	},

	-- Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
	-- related works: godlygeek/tabular
	{
		"junegunn/vim-easy-align",
		config = function()
			-- Start interactive EasyAlign for a motion/text object (e.g. gaip)
			nmap { "ga", "<Plug>(EasyAlign)" }
			-- Start interactive EasyAlign in visual mode (e.g. vipga)
			xmap { "ga", "<Plug>(EasyAlign)" }
			-- Align GitHub-flavored Markdown tables
			-- https://thoughtbot.com/blog/align-github-flavored-markdown-tables-in-vim
			vmap { "<Leader><Bslash>", ":EasyAlign*<Bar><Enter>" }
		end,
	},

	-- https://github.com/karb94/neoscroll.nvim
	-- "psliwka/vim-smoothie",
	{
		"karb94/neoscroll.nvim",
		config = function()
			require("neoscroll").setup()
		end,
	},
	{
		"rcarriga/nvim-notify",
		config = function()
			vim.notify = require("notify")
		end
	},

	-- lsp
	{
		"neovim/nvim-lspconfig",
		dependencies = { "simrat39/rust-tools.nvim" },
		config = function()
			-- require "config.rust-tools"
			require "config.nvim-lspconfig"
		end,
	},

	-- local-highlight.nvim: blazing fast highlight of word under the cursor
	-- see https://www.reddit.com/r/neovim/comments/10xf7s0/comment/j7tjqgm/?utm_source=reddit&utm_medium=web2x&context=3
	{
		"tzachar/local-highlight.nvim",
		config = function()
			require("local-highlight").setup {
				file_types = { "c", "rust", "go", "html", "javascript", "java", "swift", "lua", "python", "cpp", "typescript" },
				hlgroup = "TSDefinitionUsage",
			}
		end,
	},

	-- https://github.com/ray-x/lsp_signature.nvim
	"ray-x/lsp_signature.nvim",

	-- Lang extra

	-- RON: Rusty Object Notation
	"ron-rs/ron.vim",
	"f-person/git-blame.nvim",

	{
		"mfussenegger/nvim-dap",
		config = function()
			require("config.nvim-dap")
		end
	},
	{
		"rcarriga/nvim-dap-ui",
		dependencies = { "mfussenegger/nvim-dap" },
		config = function()
			require("dapui").setup {
			}
		end,
	},

	-- Snippet support
	-- For luasnip user.
	{
		"L3MON4D3/LuaSnip",
		dependencies = { "rafamadriz/friendly-snippets" },
		config = function()
			require("luasnip.loaders.from_vscode").lazy_load()
			local config_path = vim.fn.stdpath('config')
			require("luasnip.loaders.from_snipmate").lazy_load({ paths = { config_path .. "/UltiSnips" } })
		end,
	},
	"saadparwaiz1/cmp_luasnip",
	"hrsh7th/cmp-nvim-lsp",
	"hrsh7th/cmp-nvim-lua",
	"hrsh7th/cmp-buffer",
	"hrsh7th/cmp-path",
	{
		"tzachar/cmp-tabnine",
		build = "./install.sh",
		dependencies = { "hrsh7th/nvim-cmp" },
		-- https://github.com/tzachar/cmp-tabnine#setup
		config = function()
			local tabnine = require "cmp_tabnine.config"
			tabnine:setup {
				max_lines = 1000,
				max_num_results = 20,
				sort = true,
				run_on_every_keystroke = true,
				snippet_placeholder = "..",
			}
		end,
	},
	{
		"hrsh7th/nvim-cmp",
		config = function()
			require "config.nvim-cmp"
		end,
	},

	-- https://github.com/windwp/nvim-autopairs
	-- https://github.com/steelsojka/pears.navim
	{
		"windwp/nvim-autopairs",
		config = function()
			-- https://github.com/windwp/nvim-autopairs/wiki/Endwise
			local npairs = require "nvim-autopairs"
			npairs.setup {
				check_ts = true,
			}
			npairs.add_rules(require "nvim-autopairs.rules.endwise-lua")

			-- https://github.com/windwp/nvim-autopairs#mapping-cr
			-- [nvim-autopairs] function nvim-autopairs.completion.cmp setup is deprecated.
			-- [nvim-autopairs]you only need to add <cr> mapping on nvim-cmp.
		end,
	},

	-- quickfix
	-- " https://github.com/romainl/vim-qf
	-- " Vim-qf and all quickfix-related plugins necessarily have overlapping features and thus undefined behaviors.
	-- " Therefore, I don't recommend vim-qf to Syntastic/Neomake/ALE users.
	-- " Plug 'romainl/vim-qf'
	-- " https://github.com/kevinhwang91/nvim-bqf
	-- https://github.com/nvim-lua/wishlist/issues/21#issuecomment-1364100079
	-- https://github.com/debugloop/telescope-undo.nvim
	"kevinhwang91/nvim-bqf",

	{
		"nvim-telescope/telescope.nvim",
		dependencies = {
			"nvim-lua/popup.nvim",
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-fzy-native.nvim",
			"debugloop/telescope-undo.nvim",
		},
		config = function()
			require "config.telescope"
		end,
	},

	{
		"numtostr/FTerm.nvim",
		config = function()
			require "config.fterm"
		end,
	},

	-- Automatic input method switching for vim
	-- https://github.com/rlue/vim-barbaric
	-- auto switch to en on normal
	-- 'kevinhwang91/vim-ibus-sw'
	{
		"rlue/vim-barbaric",
		config = function()
			Variable.g {
				barbaric_ime = "fcitx",
				barbaric_default = 0,
				barbaric_scope = "buffer",
				barbaric_fcitx_cmd = "fcitx5-remote",
			}
		end,
	},
	{
		"windwp/windline.nvim",
		config = function()
			require "config.windline"
		end,
	},

	{
		"goolord/alpha-nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		config = function()
			require("alpha").setup(require("alpha.themes.startify").config)
			nnoremap { "<leader>al", ":Alpha<cr>" }

			-- require 'alpha'.setup(require 'alpha.themes.dashboard'.config)
		end,
	},

	{
		-- https://github.com/mhartington/formatter.nvim
		-- related work: https://github.com/lukas-reineke/format.nvim
		"mhartington/formatter.nvim",
		config = function()
			require "config.formatter"
		end,
	},

	-- https://github.com/glepnir/indent-guides.nvim
	{
		"glepnir/indent-guides.nvim",
		config = function()
			require "config.indent-guides"
		end,
	},

	{
		"kylechui/nvim-surround",
		config = function()
			require("nvim-surround").setup {
				-- Configuration here, or leave empty to use defaults
			}
		end,
	},

	"tpope/vim-repeat",
	-- " unimpaired has many useful maps, like
	-- " ]p pastes on the line below, [p pastes on the line above
	-- https://www.reddit.com/r/neovim/comments/118511i/minibracketed_go_forwardbackward_with_square/
	-- https://github.com/echasnovski/mini.nvim/blob/main/readmes/mini-bracketed.md
	{ "echasnovski/mini.bracketed" },

	-- https://github.com/b3nj5m1n/kommentary
	-- https://github.com/numToStr/Comment.nvim
	{
		"numToStr/Comment.nvim",
		config = function()
			-- https://github.com/numToStr/Comment.nvim#configuration-optional
			require("Comment").setup()
		end,
	},

	-- https://github.com/ggandor/leap.nvim
	{
		"phaazon/hop.nvim",
		branch = "v2",
		config = function()
			require "config.hop"
		end,
	},

	{
		"mg979/vim-visual-multi",
		branch = "master",
	},

	{
		"mfussenegger/nvim-lint",
		config = function()
			require "config.nvim-lint"
		end,
	},

	-- https://github.com/lewis6991/gitsigns.nvim
	{
		"lewis6991/gitsigns.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require "config.gitsigns"
			nnoremap { "gn", ":Gitsigns next_hunk<cr>" }
			nnoremap { "gp", ":Gitsigns prev_hunk<cr>" }
		end,
	},

	-- https://github.com/sindrets/diffview.nvim
	{
		"sindrets/diffview.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			nnoremap { "<F2>", ":DiffviewOpen<cr>" }
			nnoremap { "<leader>dc", ":DiffviewClose<cr>" }
			nnoremap { "<F4>", ":DiffviewFileHistory<cr>" }
			nnoremap { "<F3>", ":DiffviewFileHistory %<cr>" }
		end
	},

	{
		"ruifm/gitlinker.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		config = function()
			require("gitlinker").setup {
				callbacks = {
					["gitlab.gnome.org"] = require("gitlinker.hosts").get_gitlab_type_url,
					["code.pterclub.com"] = require("gitlinker.hosts").get_gitea_type_url,
				},
				opts = {
					-- callback for what to do with the url
					-- action_callback = require "gitlinker.actions".copy_to_clipboard,
					action_callback = require("gitlinker.actions").open_in_browser,
					-- print the url after performing the action
					print_url = true,
				},
				-- default mapping to call url generation with action_callback
				mappings = "<leader>gy",
			}
		end,
	},

	-- " https://github.com/ttys3/vim-gomodifytags
	-- " Add or remove tags on struct fields with :GoAddTags and :GoRemoveTags
	"ttys3/vim-gomodifytags",

	-- " generates method stubs for implementing an interface
	-- " :GoImpl {receiver} {interface}
	-- " :GoImpl f *File io.Reader
	-- " https://github.com/rhysd/vim-go-impl
	"rhysd/vim-go-impl",

	-- https://github.com/norcalli/nvim-colorizer.lua
	{
		"norcalli/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	--  https://github.com/iamcco/markdown-preview.nvim
	{
		"iamcco/markdown-preview.nvim",
		build = function()
			vim.cmd "call mkdp#util#install()"
		end,
		config = function()
			require "config.markdown-preview"
		end,
	},

	-- https://github.com/plasticboy/vim-markdown#options
	{
		"plasticboy/vim-markdown",
		config = function()
			require "config.vim-markdown"
		end,
	},

	{
		"bfredl/nvim-miniyank",
		config = function()
			require "config.nvim-miniyank"
		end,
	},

	-- " NeoVim plugin to paste image from clipboard written in lua.
	-- " https://github.com/ekickx/clipboard-image.nvim
	"ekickx/clipboard-image.nvim",

	-- " one dark like colorscheme
	"sainnhe/edge",

	{
		"navarasu/onedark.nvim",
		config = function()
			require('onedark').setup {
				-- style = 'darker'
				-- style = 'dark'
			}
			require('onedark').load()
		end,
	}
}, {
	log = { level = os.getenv "PACKER_LOG_LEVEL" or "warn" },
	display = {
		non_interactive = os.getenv "PACKER_NON_INTERACTIVE" or false,
		open_fn = function()
			return require("packer.util").float { border = "single" }
		end,
	},
})
