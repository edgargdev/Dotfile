return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
			rest_load = function()
				require("telescope").load_extension("rest")
				-- then use it, you can also use the `:Telescope rest select_env` command
				require("telescope").extensions.rest.select_env()
			end
			--- When this keybind is hit, load the rest.nvim extension

			vim.keymap.set("n", "<leader>v", rest_load, { desc = "Set RestNvim env" })
		end,
	},
}
