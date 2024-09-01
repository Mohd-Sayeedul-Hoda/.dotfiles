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
end
return M
