-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = '*',
--   callback = function()
--     vim.cmd 'Neotree reveal'
--   end,
-- })
vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('ScrollOffEOF', {}),
  callback = function()
    local win_h = vim.api.nvim_win_get_height(0)
    local off = math.min(vim.o.scrolloff, math.floor(win_h / 2))
    local dist = vim.fn.line '$' - vim.fn.line '.'
    local rem = vim.fn.line 'w$' - vim.fn.line 'w0' + 1
    if dist < off and win_h - rem + dist < off then
      local view = vim.fn.winsaveview()
      view.topline = view.topline + off - (win_h - rem + dist)
      vim.fn.winrestview(view)
    end
  end,
})
-- Autocommand to run Telescope when opening notes

local function open_telescope_notes()
  vim.cmd 'cd ~/notes'
  require('telescope.builtin').find_files { search_dirs = { '~/notes' } }
end

local function open_telescope_notes_grep()
  vim.cmd 'cd ~/notes'
  require('telescope.builtin').live_grep { search_dirs = { '~/notes' } }
end

vim.api.nvim_create_user_command('FNotes', open_telescope_notes, {})
vim.api.nvim_create_user_command('GNotes', open_telescope_notes_grep, {})
