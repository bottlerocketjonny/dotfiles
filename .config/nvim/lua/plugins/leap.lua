return {
  "folke/flash.nvim",
  event = "VeryLazy",
  ---@type Flash.Config
  opts = {},
  -- stylua: ignore
  keys = {
    { "s",     mode = { "n", "x", "o" }, function() require("flash").jump() end,              desc = "Flash" },
    { "S",     mode = { "n", "x", "o" }, function() require("flash").treesitter() end,        desc = "Flash Treesitter" },
    { "r",     mode = "o",               function() require("flash").remote() end,            desc = "Remote Flash" },
    { "R",     mode = { "o", "x" },      function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
    { "<c-s>", mode = { "c" },           function() require("flash").toggle() end,            desc = "Toggle Flash Search" },
  },
}
-- {
--   'ggandor/flit.nvim',
--   enabled = true,
--   keys = function()
--     ---@type LazyKeys[]
--     local ret = {}
--     for _, key in ipairs { 'f', 'F', 't', 'T' } do
--       ret[#ret + 1] = { key, mode = { 'n', 'x', 'o' }, desc = key }
--     end
--     return ret
--   end,
--   opts = { labeled_modes = 'nx' },
-- },
-- {
--   'ggandor/leap.nvim',
--   enabled = true,
--   keys = {
--     { 's', mode = { 'n', 'x', 'o' }, desc = 'Leap Bidirectional' },
--   },
--   config = function(_, opts)
--     local leap = require 'leap'
--     leap.set_default_keymaps(false)
--
--     -- Set custom mappings
--     leap.add_default_mappings()
--     vim.keymap.set({ 'n', 'x', 'o' }, 's', function()
--       leap.leap {
--         target_windows = { vim.fn.win_getid() },
--       }
--     end, { desc = 'Leap Bidirectional' })
--
--     for k, v in pairs(opts) do
--       leap.opts[k] = v
--     end
--   end,
-- },
