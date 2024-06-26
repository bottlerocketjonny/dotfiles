return {
  { -- Collection of various small independent plugins/modules
    'echasnovski/mini.nvim',
    config = function()
      -- Better Around/Inside textobjects
      --
      -- Examples:
      --  - va)  - [V]isually select [A]round [)]paren
      --  - yinq - [Y]ank [I]nside [N]ext [']quote
      --  - ci'  - [C]hange [I]nside [']quote
      require('mini.ai').setup { n_lines = 500 }

      -- Add/delete/replace surroundings (brackets, quotes, etc.)
      --
      -- - saiw) - [S]urround [A]dd [I]nner [W]ord [)]Paren
      -- - sd'   - [S]urround [D]elete [']quotes
      -- - sr)'  - [S]urround [R]eplace [)] [']
      require('mini.surround').setup()

      -- local mouse_scrolled = false
      -- for _, scroll in ipairs { 'Up', 'Down' } do
      --   local key = '<ScrollWheel' .. scroll .. '>'
      --   vim.keymap.set({ '', 'i' }, key, function()
      --     mouse_scrolled = true
      --     return key
      --   end, { expr = true })
      -- end
      --
      -- local animate = require 'mini.animate'
      -- animate.setup {
      --   resize = {
      --     timing = animate.gen_timing.linear { duration = 100, unit = 'total' },
      --   },
      --   scroll = {
      --     timing = animate.gen_timing.linear { duration = 150, unit = 'total' },
      --     subscroll = animate.gen_subscroll.equal {
      --       predicate = function(total_scroll)
      --         if mouse_scrolled then
      --           mouse_scrolled = false
      --           return false
      --         end
      --         return total_scroll > 1
      --       end,
      --     },
      --   },
      -- }

      -- Simple and easy statusline.
      --  You could remove this setup call if you don't like it,
      --  and try some other statusline plugin
      -- local statusline = require 'mini.statusline'
      -- -- set use_icons to true if you have a Nerd Font
      -- statusline.setup {
      --   -- Adjusting highlight for normal and non-current status line
      --   use_icons = vim.g.have_nerd_font,
      --   set_vim_settings = false,
      -- }
      --
      -- vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = '#3a3a3a', bold = true })
      -- vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#aaaaaa', bg = '#202020' })
      --
      -- You can configure sections in the statusline by overriding their
      -- default behavior. For example, here we set the section for
      -- cursor location to LINE:COLUMN
      ---@diagnostic disable-next-line: duplicate-set-field
      -- statusline.section_location = function()
      --   return '%2l:%-2v'
      -- end

      -- ... and there is more!
      --  Check out: https://github.com/echasnovski/mini.nvim
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
