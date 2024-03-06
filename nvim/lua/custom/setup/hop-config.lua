-- lua/custom/custom-hop.lua

local M = {}

M.setup = function()
    local hop = require('hop')
    local directions = require('hop.hint').HintDirection
    vim.keymap.set('', 'T', function()
        hop.hint_anywhere()
    end, { remap = true })

    vim.keymap.set('', 't', function()
        hop.hint_vertical()
    end, { remap = true })
end

return M
