return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	tag = "v2.17", -- latest VimTeX release that supports Neovim < 0.12.4
	init = function()
		-- OS-specific viewer configuration
		if vim.fn.has("mac") == 1 then
			vim.g.vimtex_view_method = "skim"
			vim.g.vimtex_view_skim_sync = 1
			vim.g.vimtex_view_skim_activate = 1
		else
			vim.g.vimtex_view_method = "zathura"
		end

		vim.g.vimtex_compiler_method = "latexmk"
		vim.g.vimtex_compiler_latexmk = {
			options = {
				"-pdf",
				"-shell-escape",
				"-verbose",
				"-file-line-error",
				"-synctex=1",
				"-interaction=nonstopmode",
			},
		}

		vim.g.vimtex_syntax_enabled = 0

		vim.keymap.set("n", "<leader>ll", "<cmd>VimtexCompile<CR>", { silent = true, desc = "Toggle VimTeX compile" })
		vim.keymap.set("n", "<leader>lv", "<cmd>VimtexView<CR>", { silent = true, desc = "View VimTeX PDF" })
		vim.keymap.set("n", "<leader>lt", "<cmd>VimtexTocOpen<CR>", { silent = true, desc = "Open VimTeX TOC" })
	end,
}
