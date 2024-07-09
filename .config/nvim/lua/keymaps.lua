-- [[ Basic Keymaps ]]
--  See `:help vim.keymap.set()`
vim.keymap.set('n', '<leader>np', '<cmd>NoNeckPain<cr>', { desc = 'No [N]eck [P]ain' })

-- Remap annoying command history
vim.keymap.set('n', 'q:', '<Nop>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>ch', ':<C-f>', { noremap = true, silent = true, desc = '[C]ommand history' })

-- Better up/down
vim.keymap.set({ 'n', 'x' }, 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Down>', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set({ 'n', 'x' }, '<Up>', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Set modifiable
vim.keymap.set('n', '<leader>m', 'set: ma', { desc = '[M]odifiable toggle' })

-- Quit selected buffer
vim.keymap.set('n', '<leader>db', ':bdelete<CR>', { desc = '[D]elete current [b]uffer' })

-- Move Lines
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move Down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move Up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move Down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move Up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move Down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move Up' })

-- Map Enter to insert a new line below the current line and return to normal mode
-- vim.keymap.set('n', '<CR>', 'o<Esc>', { noremap = true, silent = true })

-- Quick s/eol navigation
vim.keymap.set('n', 'gh', '_', { desc = 'Jump to start of line' })
vim.keymap.set('n', 'gl', '$', { desc = 'Jump to end of line' })

-- Easier than % for matching bracket
vim.keymap.set('n', 'gp', '%', { desc = 'Jump to matching parenthesis' })

-- Center viewport when pg up/down
local function lazy(keys)
  keys = vim.api.nvim_replace_termcodes(keys, true, false, true)
  return function()
    local old = vim.o.lazyredraw
    vim.o.lazyredraw = true
    vim.api.nvim_feedkeys(keys, 'nx', false)
    vim.o.lazyredraw = old
  end
end

vim.keymap.set('n', '<C-d>', lazy('<C-d>zz'), { desc = 'Scroll down half screen' })
vim.keymap.set('n', '<C-u>', lazy('<C-u>zz'), { desc = 'Scroll up half screen' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous [D]iagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next [D]iagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Show diagnostic [E]rror messages' })
vim.keymap.set('n', '<leader>qd', vim.diagnostic.setloclist, { desc = 'Open diagnostic [Q]uickfix list' })

-- Quickfix list (populate with tab in telescope)
local function toggle_quickfix()
  local qf_exists = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      qf_exists = true
      break
    end
  end
  if qf_exists then
    vim.cmd 'cclose'
  else
    vim.cmd 'copen'
  end
end

vim.keymap.set('n', '<leader>q', toggle_quickfix, { desc = 'Toggle [Q]uickfix list' })
vim.keymap.set('n', '<leader>qn', ':cnext<CR>', { desc = 'Go to next [Q]uickfix item' })
vim.keymap.set('n', '<leader>qp', ':cprev<CR>', { desc = 'Go to previous [Q]uickfix item' })

-- Keybinds to make split navigation easier.
--  Use CTRL+<hjkl> to switch between windows
--
--  See `:help wincmd` for a list of all window commands
vim.keymap.set('n', '<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
vim.keymap.set('n', '<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- [[ Basic Autocommands ]]
--  See `:help lua-guide-autocommands`

-- Highlight when yanking (copying) text
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('kickstart-highlight-yank', { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})


-- Function to toggle a markdown checkbox
local function toggle_markdown_checkbox()
  local current_line = vim.api.nvim_get_current_line()
  local unchecked_pattern = "^%s*%- %[ %]"
  local checked_pattern = "^%s*%- %[x%]"

  if current_line:match(unchecked_pattern) then
    -- If the line contains an unchecked box, change it to checked
    local new_line = current_line:gsub("%[ %]", "[x]")
    vim.api.nvim_set_current_line(new_line)
  elseif current_line:match(checked_pattern) then
    -- If the line contains a checked box, change it to unchecked
    local new_line = current_line:gsub("%[x%]", "[ ]")
    vim.api.nvim_set_current_line(new_line)
  end
end

-- Function to create a new checkbox on Enter
-- local function create_new_checkbox()
--   local current_line = vim.api.nvim_get_current_line()
--   local indent = current_line:match("^%s*")
--   local new_line = indent .. "- [ ] "
--   vim.api.nvim_input('<ESC>o' .. new_line)
-- end

-- Export functions to the global scope
_G.toggle_markdown_checkbox = toggle_markdown_checkbox
-- _G.create_new_checkbox = create_new_checkbox

-- Key mapping for toggling checkboxes
vim.api.nvim_set_keymap('n', '<C-x>', ':lua toggle_markdown_checkbox()<CR>', { noremap = true, silent = true })

-- Autocommand to create a new checkbox on Enter in Markdown files
-- vim.cmd([[
--   augroup MarkdownCheckbox
--     autocmd!
--     autocmd FileType markdown inoremap <buffer> <CR> <C-o>:lua create_new_checkbox()<CR>
--   augroup END
-- ]])

-- vim: ts=2 sts=2 sw=2 et
