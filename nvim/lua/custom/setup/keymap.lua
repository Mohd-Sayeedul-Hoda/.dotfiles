local M = {}

M.setup = function ()
    vim.api.nvim_set_keymap("n", "<Leader>q\"", "ciw\"\"<Esc>P", { noremap = true })
    vim.api.nvim_set_keymap("n", "<Leader>q\'", "ciw\'\'<Esc>P", { noremap = true })
    vim.keymap.set('n', 'H', '_')
    vim.keymap.set('n', 'L', '$')
end

return M
