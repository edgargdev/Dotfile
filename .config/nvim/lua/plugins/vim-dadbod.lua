return {
	{ "tpope/vim-dadbod" },
	{
		"kristijanhusak/vim-dadbod-ui",
		config = function()
			vim.keymap.set("n", "<leader>db", "<cmd>DBUI<CR>", { desc = "Open DB UI" })
		end,
	},
	{
		"kristijanhusak/vim-dadbod-completion",
	},
}
