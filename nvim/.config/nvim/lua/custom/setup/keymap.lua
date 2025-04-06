local M = {}

M.setup = function()
	vim.api.nvim_set_keymap("n", "<Leader>q;", 'ciw""<Esc>P', { noremap = true })
	vim.api.nvim_set_keymap("n", "<Leader>q'", "ciw''<Esc>P", { noremap = true })
	vim.api.nvim_set_keymap("n", "<Leader>vf", "V$%", { noremap = true })
	vim.keymap.set("n", "H", "_")
	vim.keymap.set("n", "L", "$")
	vim.keymap.set("v", "L", "$")
	vim.keymap.set("v", "H", "_")
	-- this is custom you can use it for layering in nvim
	vim.api.nvim_set_keymap("i", "<C-r>", "!", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("i", "<C-l>", "`", { noremap = true, silent = true })
	vim.api.nvim_set_keymap("n", "<C-[>", ":set tabstop=2 shiftwidth=2<CR>", { noremap = true })
	vim.api.nvim_set_keymap("n", "<Leader>pv", ":Oil --float<CR>", { noremap = true })

	vim.api.nvim_set_keymap("n", "<C-Tab>", ":tabnext<CR>", { noremap = true, silent = true }) -- Normal mode
	vim.api.nvim_set_keymap("i", "<C-Tab>", "<C-o>:tabnext<CR>", { noremap = true, silent = true }) -- Insert mode (use <C-o> to execute a normal command)
	-- Add mappings for other modes if needed (e.g., visual mode, command-line mode)

	-- Tab Previous (Ctrl+Shift+Tab)
	vim.api.nvim_set_keymap("n", "<C-S-Tab>", ":tabprevious<CR>", { noremap = true, silent = true }) -- Normal mode
	vim.api.nvim_set_keymap("i", "<C-S-Tab>", "<C-o>:tabprevious<CR>", { noremap = true, silent = true }) -- Insert mode
	print("Custom tab key mappings loaded.") -- Confirmation message
end
return M
