-- File Explorer / Tree
--
local function my_on_attach(bufnr)
  local api = require "nvim-tree.api"

  local function opts(desc)
    return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- default mappings
  api.config.mappings.default_on_attach(bufnr)

  -- custom mappings
  vim.keymap.set('n', '?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', 'l', api.node.open.edit, opts('Open'))
end

return {
  -- https://github.com/nvim-tree/nvim-tree.lua
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    -- https://github.com/nvim-tree/nvim-web-devicons
    'nvim-tree/nvim-web-devicons', -- Fancy icon support
  },
  opts = {
    view = {
      width = 70,
      -- float = {
      --   enable = true,
      --   width = '100%',
      -- }
    },
    on_attach = my_on_attach,
    actions = {
      open_file = {
        quit_on_open = true,
        window_picker = {
          enable = false
        },
      }
    },
  },
  config = function(_, opts)
    -- Recommended settings to disable default netrw file explorer
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
    require("nvim-tree").setup(opts)
  end
}

-- -- Neo-tree is a Neovim plugin to browse the file system
-- -- https://github.com/nvim-neo-tree/neo-tree.nvim
--
-- return {
--   'nvim-neo-tree/neo-tree.nvim',
--   version = '*',
--   dependencies = {
--     'nvim-lua/plenary.nvim',
--     'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
--     'MunifTanjim/nui.nvim',
--   },
--   cmd = 'Neotree',
--   keys = {
--     { '<leader>x', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
--   },
--   opts = {
--     filesystem = {
--       window = {
--         position = 'current',
--         mappings = {
--           ['<leader>x'] = 'close_window',
--           ['l'] = 'open',
--         },
--       },
--     },
--     event_handlers = {
--       {
--         event = 'file_opened',
--         handler = function(file_path)
--           -- auto close the tree when a file is opened
--           require('neo-tree.command').execute { action = 'close' }
--         end,
--       },
--     },
--   },
-- }
