if vim.g.loaded_undotree ~= nil then  -- Check if g:loaded_undotree is defined
    return  -- Exit the script if Undotree is already loaded
end
if vim.g.undotree_SetFocusWhenToggle == nil then
    vim.g.undotree_SetFocusWhenToggle = 1
end
---- keymaps undotree
vim.keymap.set('n', '<leader>U', vim.cmd.UndotreeToggle)

return { 'mbbill/undotree' }
