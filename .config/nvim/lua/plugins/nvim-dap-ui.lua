return {
	"rcarriga/nvim-dap-ui",
	dependencies = {
		"mfussenegger/nvim-dap",
		"nvim-neotest/nvim-nio",
	},
	opts = {
		icons = { expanded = "▾", collapsed = "▸", current_frame = "▸" },
		mappings = {
			expand = { "<CR>", "<2-LeftMouse>" },
			open = "o",
			remove = "d",
			edit = "e",
			repl = "r",
			toggle = "t",
		},
		element_mappings = {},
		expand_lines = vim.fn.has("nvim-0.7") == 1,
		layouts = {
			{
				elements = {
					{ id = "scopes", size = 0.25 },
					"breakpoints",
					"stacks",
					"watches",
				},
				size = 60, -- Width of left panel (increase from 40)
				position = "left",
			},
			{
				elements = {
					"repl",
					"console",
				},
				size = 0.30, -- Height of bottom panel (increase from 0.25 = 30% of screen height)
				position = "bottom",
			},
		},
		controls = {
			enabled = true,
			element = "repl",
			icons = {
				pause = "⏸",
				play = "▶",
				step_into = "⏎",
				step_over = "⏭",
				step_out = "⏮",
				step_back = "b",
				run_last = "▶▶",
				terminate = "⏹",
				disconnect = "⏏",
			},
		},
		floating = {
			max_height = nil,
			max_width = nil,
			border = "single",
			mappings = {
				close = { "q", "<Esc>" },
			},
		},
		windows = { indent = 1 },
		render = {
			max_type_length = nil,
			max_value_lines = 100,
		},
	},
}
