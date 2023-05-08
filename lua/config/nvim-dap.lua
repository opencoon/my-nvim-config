nnoremap { "<F5>", ":lua require'dap'.continue()<CR>" }
nnoremap { "<F6>", ":lua require'dap'.step_over()<CR>" }
nnoremap { "<F7>", ":lua require'dap'.step_into()<CR>" }
nnoremap { "<F8>", ":lua require'dap'.step_out()<CR>" }
nnoremap { "<F9>", ":DapTerminate<CR>" }
nnoremap { "<leader>bp", ":lua require'dap'.toggle_breakpoint()<CR>" }
-- nnoremap { "<leader>bc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>" }
nnoremap { "<leader>dl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>" }
nnoremap { "<leader>dr", ":lua require'dap'.run_last()<CR>" }
nnoremap { "<leader>du", ":lua require'dapui'.toggle()<CR>" }

-- nvim-dap setup
local dap = require "dap"
-- nvim-dap uses three signs:
-- `DapBreakpoint` which defaults to `B` for breakpoints
-- `DapLogPoint` which defaults to `L` and is for log-points
-- `DapStopped` which defaults to `→` and is used to indicate the position where the debugee is stopped.

vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapLogPoint", { text = "✳️ ", texthl = "", linehl = "", numhl = "" })
vim.fn.sign_define("DapStopped", { text = "⭕", texthl = "", linehl = "", numhl = "" })

-- dap.defaults.fallback.external_terminal = {
-- 	command = "alacritty",
-- 	args = { "-e" },
-- }
require("dap.golang").init(dap)
