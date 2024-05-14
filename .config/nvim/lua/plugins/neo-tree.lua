-- Neo-tree is a Neovim plugin to browse the file system
-- https://github.com/nvim-neo-tree/neo-tree.nvim

return {
  'nvim-neo-tree/neo-tree.nvim',
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  keys = {
    { '<leader>x', ':Neotree reveal<CR>', { desc = 'NeoTree reveal' } },
  },
  opts = {
    filesystem = {
      window = {
        position = 'current',
        mappings = {
          ['<leader>x'] = 'close_window',
          ['l'] = 'open',
        },
      },
    },
    event_handlers = {
      {
        event = 'file_opened',
        handler = function(file_path)
          -- auto close the tree when a file is opened
          require('neo-tree.command').execute { action = 'close' }
        end,
      },
    },
  },
}
