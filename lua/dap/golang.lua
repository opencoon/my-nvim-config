#!/usr/bin/env lua

local M = {}
-- dapui = require "dapui"

-- local function close_dap_ui()
-- 	dapui.close()
-- end

-- local function on_delve_exit(handle, code)
-- 	handle:close()
-- 	print("Delve exited with exit code: " .. code)
--
-- 	vim.defer_fn(close_dap_ui, 0)
-- end

function M.init(dap)
	dap.adapters.go = function(callback, config)
		-- local handle
		-- local pid_or_err
		local port = 8088

		-- handle, pid_or_err = vim.loop.spawn("dlv", {
		-- 	args = { "dap", "-l", "127.0.0.1:" .. port },
		-- 	detached = true,
		-- }, function(code)
		-- 	on_delve_exit(handle, code)
		-- end)

		----should we wait for delve to start???
		-- vim.defer_fn(function()
		-- 	dapui.open()
		-- 	callback { type = "server", host = "127.0.0.1", port = port }
		-- end, 500)

		callback { type = "server", host = "127.0.0.1", port = port }
	end

	-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
	local utils = require("dap.utils")
	local projectConfigPath = {
		cms = 'config/nacos-test/test/cms/cms-api.toml',
		configCenter = 'config/nacos-test/test/im/config-center.toml'
	}
	-- 创建命令
	dap.configurations.go = {
		{
			type = 'go',
			name = 'Debug',
			request = 'launch',
			program = '${env:PWD}/main.go',
			args = {},
			preLaunch = function()
				-- 弹出窗口，获取用户输入
				local prompt = 'Enter the arguments for the Go program:'
				local result = vim.fn.input(prompt)

				-- 检查用户输入
				if result == nil or result:match('^%s*$') then
					-- 如果用户未输入参数，则将 args 字段设置为空值
					dap.configurations.go[1].args = {}
				else
					-- 如果用户输入了参数，则拆分为字符串数组并更新 args 字段
					local args = vim.split(result, ' ')
					dap.configurations.go[1].args = args

					-- 检查用户输入是否为 'cms-api'
					if result == 'cms-api' or result == '1' then
						dap.configurations.go[1].args = { '--config', projectConfigPath.cms }
					end
					-- 检查用户输入是否为 'config-center'
					if result == 'config-center' or result == '2' then
						dap.configurations.go[1].args = { '--config', projectConfigPath.configCenter }
					end

					local message = 'Go program arguments: ' .. vim.inspect(dap.configurations.go[1].args)
					utils.notify(message)
				end
			end,
		},
	}
end

return M

