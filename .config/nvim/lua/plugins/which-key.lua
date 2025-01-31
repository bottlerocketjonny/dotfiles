return {
  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter', -- Sets the loading event to 'VimEnter'
    config = function() -- This is the function that runs, AFTER loading
      require('which-key').setup()
      -- Document existing key chains
      require('which-key').add {
        -- Main groups
        { '<leader>z', group = 'Spell check' },
        { '<leader>b', group = '[B]reakpoints' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>d', group = '[D]ebug' },
        { '<leader>e', group = '[E]xplorer' },
        { '<leader>s', group = '[S]earch files' },
        { '<leader>g', group = '[G]o to' },
        { '<leader>h', group = '[H]arpoon' },
        { '<leader>q', group = '[Q]uickfix' },
        { '<leader>f', group = '[F]ile management' },
        { '<leader>w', group = '[W]indow splits' },
        { '<leader>t', group = '[T]ab/Test' },
        { '<leader>x', group = 'E[x]tra tools' },
        { '<leader>p', group = '[P]rojects' },
        { '<leader>v', group = '[V]ersion control (Git)' },

        -- Individual key bindings
        { '<leader>ch', name = 'Command history' },
        { 'gh', name = 'Go to start of line' },
        { 'gl', name = 'Go to end of line' },
        { 'gp', name = 'Go to matching bracket' },
        { 'gx', name = 'Open URL under cursor' },

        -- Movement keys
        { '<A-j>', name = 'Move line down', mode = { 'n', 'i', 'v' } },
        { '<A-k>', name = 'Move line up', mode = { 'n', 'i', 'v' } },

        -- Search
        { '<Esc>', name = 'Clear search highlight', mode = 'n' },

        -- New line
        { '<CR>', name = 'New line below', mode = 'n' },
      }
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
