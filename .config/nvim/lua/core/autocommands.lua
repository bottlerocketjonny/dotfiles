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

vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
