local function my_on_attach(bufnr)
	local api = require("nvim-tree.api")

	local function opts(desc)
		return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
	end

	-- default mappings
	api.config.mappings.default_on_attach(bufnr)

	-- custom mappings
	vim.keymap.set("n", "<C-m>", api.tree.change_root_to_parent, opts("Up"))
	vim.keymap.set("n", "<C-n>", api.tree.change_root_to_node, opts("CD"))
	vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
end
--

require("nvim-tree").setup({
	on_attach = my_on_attach,
	update_focused_file = {
		enable = true,
		update_cwd = false,
	},
	sort = {
		sorter = "case_sensitive",
	},
	renderer = {
		group_empty = true,
	},
	filters = {
		dotfiles = true,
		custom = {
			"node_modules",
			".git/",
			".venv",
			"venv",
		},
	},
})
