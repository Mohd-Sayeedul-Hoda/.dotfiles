local M = {}

M.setup = function ()
    vim.api.nvim_set_keymap("n", "<Leader>q;", "ciw\"\"<Esc>P", { noremap = true })
    vim.api.nvim_set_keymap("n", "<Leader>q\'", "ciw\'\'<Esc>P", { noremap = true })
    vim.keymap.set('n', 'H', '_')
    vim.keymap.set('n', 'L', '$')
    -- this is custom you can use it for layring in nvim
    vim.api.nvim_set_keymap('i', '<C-r>', '!', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', '<C-l>', '`', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('n', '<C-[>', ":set tabstop=2 shiftwidth=2<CR>", {noremap = true})
    vim.api.nvim_set_keymap('n', '<Leader>pv', ":Oil --float<CR>", {noremap = true})
end
return M

