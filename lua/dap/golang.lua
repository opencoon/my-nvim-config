#!/usr/bin/env lua

local M = {}
dapui = require "dapui"

function M.init(dap)
	dap.adapters.go = function(callback, config)
		local handle
		local pid_or_err
		local port = 8088

		handle, pid_or_err = vim.loop.spawn("dlv", {
			args = { "dap", "-l", "127.0.0.1:" .. port },
			detached = true,
		}, function(code)
			handle:close()
			print("Delve exited with exit code: " .. code)
		end)
		----should we wait for delve to start???
		vim.defer_fn(function()
			dapui.open()
			callback { type = "server", host = "127.0.0.1", port = port }
		end, 500)

		callback { type = "server", host = "127.0.0.1", port = port }
	end

	dap.close = function()
		if handle ~= nil and not handle:is_closing() then
			handle:kill()
			handle:close()
		end
		dapui.close()
	end
	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	dap.configurations.go = {
		{
			type = "go",
			name = "Debug",
			request = "launch",
			program = "${file}",
			args = {'--config','./config/nacos-test/test/cms/cms-api.toml'}
		},
	}
end

return M
