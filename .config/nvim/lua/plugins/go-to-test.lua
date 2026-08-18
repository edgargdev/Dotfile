return {
	"jtzero/go-to-test-file.nvim",
	lazy = false,
	config = true,
	keys = {
		{
			"<leader>gt",
			"<cmd>FindTestOrSourceCodeFileWithFallback<CR>",
			mode = { "n" },
			desc = "Opens a corresponding test file or source file if not found opens the test folder",
		},
	},
}
