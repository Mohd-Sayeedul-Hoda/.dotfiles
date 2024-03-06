-- Unless you are still migrating, remove the deprecated commands from v0.x
vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

return {
  "nvim-neo-tree/neo-tree.nvim",
  version = "*",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
    "MunifTanjim/nui.nvim",
  },
  config = function ()
    require('neo-tree').setup {
      close_if_last_window = false, 
      mappings = {
       ["P"] = { "toggle_preview", config = { use_float = true, use_image_nvim = true } },
      }
    }
  end,
}

