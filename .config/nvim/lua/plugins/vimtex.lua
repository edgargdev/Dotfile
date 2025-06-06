return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
	init = function()
		-- VimTeX configuration goes here, e.g.
		vim.g.vimtex_view_method = "skim"
		vim.g.vimtex_view_skim_sync = 1
		vim.g.vimtex_view_skim_activate = 1
		vim.g.vimtex_syntax_enabled = 0

		-- set key mapping for :VimtexView
		vim.api.nvim_set_keymap("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true })
		-- set key mapping for :VimtexTocOpen
		vim.api.nvim_set_keymap("n", "<leader>lt", ":VimtexTocOpen<CR>", { noremap = true, silent = true })
	end,
}
