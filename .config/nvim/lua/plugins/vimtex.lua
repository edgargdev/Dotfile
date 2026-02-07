return {
	"lervag/vimtex",
	lazy = false, -- we don't want to lazy load VimTeX
	-- tag = "v2.15", -- uncomment to pin to a specific release
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

		-- set key mapping for :VimtexView
		vim.api.nvim_set_keymap("n", "<leader>lv", ":VimtexView<CR>", { noremap = true, silent = true })
		-- set key mapping for :VimtexTocOpen
		vim.api.nvim_set_keymap("n", "<leader>lt", ":VimtexTocOpen<CR>", { noremap = true, silent = true })

		-- Autocommand to fold LaTeX sections on file open under cursor
		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = "*.tex",
			callback = function()
				vim.cmd("normal zM") -- Close all folds
				vim.cmd("normal zR") -- Open top-level folds
			end,
		})
	end,
}
