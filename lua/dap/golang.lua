#!/usr/bin/env lua

local M = {}
dapui = require "dapui"

local function close_dap_ui()
    dapui.close()
end

local function on_delve_exit(handle,code)
    handle:close()
    print("Delve exited with exit code: " .. code)

    vim.defer_fn(close_dap_ui, 0)
end

function M.init(dap)
	dap.adapters.go = function(callback, config)
		local handle
		local pid_or_err
		local port = 8088

		handle, pid_or_err = vim.loop.spawn("dlv", {
			args = { "dap", "-l", "127.0.0.1:" .. port },
			detached = true,
		}, function(code)
			on_delve_exit(handle,code)
		end)
		----should we wait for delve to start???
		vim.defer_fn(function()
			dapui.open()
			callback { type = "server", host = "127.0.0.1", port = port }
		end, 500)

		callback { type = "server", host = "127.0.0.1", port = port }
	end

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${env:PN}/main.go",
			args = {'--config',"${env:PC}"},
		},
	}
end

return M
