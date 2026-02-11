return {
	"mfussenegger/nvim-dap",
	dependencies = {
		"rcarriga/nvim-dap-ui",
		"nvim-neotest/nvim-nio",
	},
	config = function()
		local dap = require("dap")
		local dapui = require("dapui")

		-- Setup DAP UI
		dapui.setup()

		-- Configure pwa-node adapter (modern Node.js debugger)
		dap.adapters["pwa-node"] = {
			type = "server",
			host = "localhost",
			port = "${port}",
			executable = {
				command = vim.fn.stdpath("data") .. "/mason/bin/js-debug-adapter",
				args = { "${port}" },
			},
		}

		-- Also support 'node' type for compatibility
		dap.adapters.node = function(callback, config)
			if config.type == "node" then
				config.type = "pwa-node"
			end
			-- Ensure cwd is set before launching
			if not config.cwd or config.cwd == "" then
				config.cwd = vim.fn.getcwd()
			end
			callback(dap.adapters["pwa-node"])
		end

		-- Add default configurations for TypeScript/JavaScript
		for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
			if not dap.configurations[language] then
				dap.configurations[language] = {}
			end
		end

		-- Load configurations from .vscode/launch.json
		local function load_vscode_launch_json()
			local cwd = vim.fn.getcwd()
			local launch_json_path = cwd .. "/.vscode/launch.json"

			print("Looking for launch.json at: " .. launch_json_path)

			if vim.fn.filereadable(launch_json_path) == 1 then
				print("Found launch.json, reading...")
				local content = vim.fn.readfile(launch_json_path)
				
				-- Remove comments from JSON (VSCode allows comments in launch.json)
				local cleaned_lines = {}
				for _, line in ipairs(content) do
					-- Remove // comments
					local cleaned = line:gsub("%s*//.*$", "")
					-- Skip empty lines
					if cleaned:match("%S") then
						table.insert(cleaned_lines, cleaned)
					end
				end
				local json_str = table.concat(cleaned_lines, "\n")
				
				local ok, launch_data = pcall(vim.fn.json_decode, json_str)
				
				if not ok then
					print("Error parsing launch.json: " .. tostring(launch_data))
					return
				end
				
				if launch_data.configurations then
					print("Found " .. #launch_data.configurations .. " configurations")
					-- Add configurations to all JS/TS filetypes
					for _, language in ipairs({ "typescript", "javascript", "typescriptreact", "javascriptreact" }) do
						-- Clone and modify each configuration
						local configs = {}
						for _, config in ipairs(launch_data.configurations) do
							local new_config = vim.deepcopy(config)
							-- Set cwd to project root if not specified
							if not new_config.cwd then
								new_config.cwd = cwd
								print("Set cwd for '" .. (new_config.name or "?") .. "' to: " .. cwd)
							end
							table.insert(configs, new_config)
						end
						dap.configurations[language] = configs
					end
					print("✓ Loaded " .. #launch_data.configurations .. " debug configurations")
				else
					print("No configurations found in launch.json")
				end
			else
				print("launch.json not found at: " .. launch_json_path)
			end
		end

		-- Load launch.json on startup (with delay to ensure DAP is ready)
		vim.defer_fn(function()
			load_vscode_launch_json()
		end, 100)

		-- Reload launch.json command
		vim.api.nvim_create_user_command("DapLoadLaunchJson", load_vscode_launch_json, {
			desc = "Reload .vscode/launch.json configurations",
		})

		-- Automatically open/close DAP UI
		dap.listeners.before.attach.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.launch.dapui_config = function()
			dapui.open()
		end
		dap.listeners.before.event_terminated.dapui_config = function()
			dapui.close()
		end
		dap.listeners.before.event_exited.dapui_config = function()
			dapui.close()
		end

		-- Keymaps
		vim.keymap.set("n", "<leader>db", dap.toggle_breakpoint, { desc = "Debug: Toggle Breakpoint" })
		vim.keymap.set("n", "<leader>dc", dap.continue, { desc = "Debug: Continue" })
		vim.keymap.set("n", "<leader>dC", dap.run_to_cursor, { desc = "Debug: Run to Cursor" })
		vim.keymap.set("n", "<leader>di", dap.step_into, { desc = "Debug: Step Into" })
		vim.keymap.set("n", "<leader>do", dap.step_over, { desc = "Debug: Step Over" })
		vim.keymap.set("n", "<leader>dO", dap.step_out, { desc = "Debug: Step Out" })
		vim.keymap.set("n", "<leader>dq", dap.terminate, { desc = "Debug: Terminate" })
		vim.keymap.set("n", "<leader>dr", dap.repl.toggle, { desc = "Debug: Toggle REPL" })
		vim.keymap.set("n", "<leader>du", dapui.toggle, { desc = "Debug: Toggle UI" })
		vim.keymap.set("n", "<leader>dh", function()
			require("dap.ui.widgets").hover()
		end, { desc = "Debug: Hover Variables" })
		vim.keymap.set("n", "<leader>dB", function()
			dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
		end, { desc = "Debug: Set Conditional Breakpoint" })
		vim.keymap.set("n", "<leader>dl", function()
			vim.cmd("edit " .. vim.fn.stdpath("cache") .. "/dap.log")
		end, { desc = "Debug: View Log" })
		vim.keymap.set("n", "<leader>dL", function()
			dap.set_log_level("TRACE")
			print("DAP log level set to TRACE")
		end, { desc = "Debug: Enable Trace Logging" })
		vim.keymap.set("n", "<leader>dI", function()
			print("=== DAP Configurations ===")
			for ft, configs in pairs(dap.configurations) do
				if configs and #configs > 0 then
					print("Filetype: " .. ft)
					for i, config in ipairs(configs) do
						print("  [" .. i .. "] " .. (config.name or "unnamed"))
						print("      cwd: " .. vim.inspect(config.cwd))
					end
				end
			end
		end, { desc = "Debug: Show Configurations" })

		-- DAP signs
		vim.fn.sign_define("DapBreakpoint", { text = "🔴", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointCondition", { text = "🟡", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapBreakpointRejected", { text = "🚫", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "", linehl = "", numhl = "" })
	end,
}
