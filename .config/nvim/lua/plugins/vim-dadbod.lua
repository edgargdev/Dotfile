return {
	"kristijanhusak/vim-dadbod-ui",
	dependencies = {
		{ "tpope/vim-dadbod", lazy = true },
		{ "kristijanhusak/vim-dadbod-completion", ft = { "sql", "mysql", "plsql" }, lazy = true },
	},
	cmd = {
		"DBUI",
		"DBUIToggle",
		"DBUIAddConnection",
		"DBUIFindBuffer",
	},
	keys = {
		{ "<leader>db", "<cmd>DBUI<CR>", desc = "Open DB UI" },
	},
	init = function()
		vim.g.db_ui_win_position = "right"

		-- Register the dadbod completion source for sql buffers (buffer-local).
		-- Note: the cmp source name is "vim-dadbod-completion" (with hyphens).
		vim.api.nvim_create_autocmd("FileType", {
			pattern = { "sql", "mysql", "plsql" },
			callback = function()
				local ok, cmp = pcall(require, "cmp")
				if not ok then
					return
				end
				cmp.setup.buffer({
					sources = {
						{ name = "vim-dadbod-completion" },
						{ name = "luasnip" },
						{ name = "path" },
					},
				})
			end,
		})
	end,
}
