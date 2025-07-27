return {
	"rest-nvim/rest.nvim",
	dependencies = {
		"nvim-treesitter/nvim-treesitter",
		opts = function(_, opts)
			opts.ensure_installed = opts.ensure_installed or {}
			table.insert(opts.ensure_installed, "http")
			rest_load = function()
				require("telescope").load_extension("rest")
				require("telescope").extensions.rest.select_env()
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = { "json" },
				callback = function()
					vim.api.nvim_set_option_value("formatprg", "jq", { scope = "local" })
				end,
			})
			vim.keymap.set("n", "<leader>v", rest_load, { desc = "Set RestNvim env" })
			vim.keymap.set("n", "<leader>H", ":Rest run<CR>", { desc = "Run RestNvim request" })
		end,
	},
}
