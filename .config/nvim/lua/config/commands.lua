-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
	desc = "Highlight when yanking (copying) text",
	group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- Delete all listed buffers except the ones currently visible in any tab
local function delete_buffers()
	-- Get all visible buffers in all tabs
	local visible_bufs = {}
	for tab = 1, vim.fn.tabpagenr("$") do
		local tab_bufs = vim.fn.tabpagebuflist(tab)
		for _, b in ipairs(tab_bufs) do
			visible_bufs[b] = true
		end
	end

	-- Delete non-visible listed buffers
	for bnr = 1, vim.fn.bufnr("$") do
		if vim.fn.buflisted(bnr) == 1 and not visible_bufs[bnr] then
			vim.cmd("bd " .. bnr)
		end
	end
end

local function open_nvim_tree()
	-- Only open tree if no file argument was provided
	if vim.fn.argc() == 0 or vim.fn.isdirectory(vim.fn.argv(0)) == 1 then
		require("nvim-tree.api").tree.open()
	end
end

vim.keymap.set("n", "<leader>z", delete_buffers, { silent = true, desc = "Delete all non-windowed buffers" })
vim.api.nvim_create_autocmd({ "VimEnter" }, { callback = open_nvim_tree })
