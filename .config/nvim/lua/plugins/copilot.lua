return {
	"github/copilot.vim",
	cmd = "Copilot",
	event = "InsertEnter",
	init = function()
		vim.g.copilot_enabled = false
		vim.g.copilot_no_tab_map = true
	end,
	keys = {
		{ "<leader>ce", "<cmd>Copilot enable<CR>", desc = "Enable Copilot" },
		{ "<leader>cd", "<cmd>Copilot disable<CR>", desc = "Disable Copilot" },
	},
	config = function()
		vim.keymap.set("i", "<A-j>", 'copilot#Accept("<CR>")', { expr = true, replace_keycodes = false })
		pcall(vim.keymap.del, "i", "<Tab>")

		vim.g.copilot_assume_mapped = true
		vim.keymap.set("i", "<A-w>", "<Plug>(copilot-accept-word)")
		vim.keymap.set("i", "<A-n>", "<Plug>(copilot-next)")
	end,
}
