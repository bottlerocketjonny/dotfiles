-- Set leader key to space
vim.g.mapleader = " "
local keymap = vim.keymap

-- Misc improvements
-----------------------------------------------------------------------------------------
keymap.set('n', 'q:', '<Nop>', { noremap = true, silent = true })
keymap.set('n', '<CR>', 'o<Esc>', { noremap = true, silent = true })
keymap.set('n', 'gh', '_', { desc = 'Go to start of line' })
keymap.set('n', 'gl', '$', { desc = 'Go to end of line' })
keymap.set('n', 'gp', '%', { desc = 'Go to matching bracket' })
keymap.set("n", "<leader>fw", ":w<CR>", { desc = 'Write file' })
keymap.set('n', '<C-u>', '<C-u>zz', { noremap = true, desc = 'Scroll up and center' })
keymap.set('n', '<C-d>', '<C-d>zz', { noremap = true, desc = 'Scroll down and center' })

-- Write/Save commands
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>fw", ":w<CR>", { desc = 'Write file' })
keymap.set("n", "<leader>fq", ":wq<CR>", { desc = 'Write and quit' })
keymap.set("n", "<leader>fa", ":wa<CR>", { desc = 'Write all' })
keymap.set("n", "<leader>fQ", ":q!<CR>", { desc = 'Quit without saving' })

-- Explorer commands
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>ee", ":NvimTreeToggle<CR>", { desc = 'Toggle explorer' })
keymap.set("n", "<leader>er", ":NvimTreeFocus<CR>", { desc = 'Focus explorer' })
keymap.set("n", "<leader>ef", ":NvimTreeFindFile<CR>", { desc = 'Find in explorer' })

-- Search (Telescope)
-----------------------------------------------------------------------------------------
local telescope = require('telescope.builtin')
keymap.set('n', '<leader>sf', telescope.find_files, { desc = 'Search files' })
keymap.set('n', '<leader>sg', telescope.live_grep, { desc = 'Search by grep' })
keymap.set('n', '<leader>sb', telescope.buffers, { desc = 'Search buffers' })
keymap.set('n', '<leader>sh', telescope.help_tags, { desc = 'Search help' })
keymap.set('n', '<leader>ss', telescope.current_buffer_fuzzy_find, { desc = 'Search in buffer' })
keymap.set('n', '<leader>so', telescope.lsp_document_symbols, { desc = 'Search symbols' })
keymap.set('n', '<leader>si', telescope.lsp_incoming_calls, { desc = 'Search incoming calls' })
keymap.set('n', '<leader>sm', function()
    telescope.treesitter({symbols={'function', 'method'}})
end, { desc = 'Search methods' })
keymap.set('n', '<leader>st', function()
    local success, node = pcall(function() return require('nvim-tree.lib').get_node_at_cursor() end)
    if not success or not node then return end
    telescope.live_grep({search_dirs = {node.absolute_path}})
end, { desc = 'Search in tree node' })
keymap.set('n', '<leader>sn', function()
    telescope.find_files({
        cwd = vim.fn.stdpath('config')
    })
end, { desc = 'Search neovim config' })

-- Window management
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>ws", "<C-w>s", { desc = 'Split horizontal' })
keymap.set("n", "<leader>wv", "<C-w>v", { desc = 'Split vertical' })
keymap.set("n", "<leader>we", "<C-w>=", { desc = 'Make splits equal' })
keymap.set("n", "<leader>wx", ":close<CR>", { desc = 'Close split' })
keymap.set("n", "<leader>wm", ":MaximizerToggle<CR>", { desc = 'Toggle maximize' })
keymap.set("n", "<leader>wj", "<C-w>-", { desc = 'Decrease height' })
keymap.set("n", "<leader>wk", "<C-w>+", { desc = 'Increase height' })
keymap.set("n", "<leader>wl", "<C-w>>5", { desc = 'Increase width' })
keymap.set("n", "<leader>wh", "<C-w><5", { desc = 'Decrease width' })

-- Tab management
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>to", ":tabnew<CR>", { desc = 'Open new tab' })
keymap.set("n", "<leader>tx", ":tabclose<CR>", { desc = 'Close tab' })
keymap.set("n", "<leader>tn", ":tabn<CR>", { desc = 'Next tab' })
keymap.set("n", "<leader>tp", ":tabp<CR>", { desc = 'Previous tab' })

-- Formatting
-- TODO sort this better
-----------------------------------------------------------------------------------------
keymap.set('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', { desc = 'Code action' })
keymap.set("n", "<leader>cr", ':w<CR>:call slime#send("gcc " . expand("%") . " -o " . expand("%:r") . " && ./" . expand("%:r") . "\\n")<CR>',
    { noremap = true, silent = true, desc = 'Compile and run C' })
keymap.set('n', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = 'Format code' })
keymap.set('v', '<leader>cf', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', { desc = 'Format selection' })
keymap.set('n', '<leader>cn', '<cmd>lua vim.diagnostic.goto_next()<CR>', { desc = 'Next diagnostic' })
keymap.set('n', '<leader>cp', '<cmd>lua vim.diagnostic.goto_prev()<CR>', { desc = 'Previous diagnostic' })

-- Refactoring
keymap.set('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', { desc = 'Rename variables' })

-- LSP navigation (Go to)
-----------------------------------------------------------------------------------------
keymap.set('n', '<leader>gg', '<cmd>lua vim.lsp.buf.hover()<CR>', { desc = 'Show hover' })
keymap.set('n', '<leader>gd', '<cmd>lua vim.lsp.buf.definition()<CR>', { desc = 'Go to definition' })
keymap.set('n', '<leader>gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', { desc = 'Go to declaration' })
keymap.set('n', '<leader>gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', { desc = 'Go to implementation' })
keymap.set('n', '<leader>gt', '<cmd>lua vim.lsp.buf.type_definition()<CR>', { desc = 'Go to type definition' })
keymap.set('n', '<leader>gr', '<cmd>lua vim.lsp.buf.references()<CR>', { desc = 'Go to references' })
keymap.set('n', '<leader>gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', { desc = 'Show signature' })
keymap.set('n', '<leader>gl', '<cmd>lua vim.diagnostic.open_float()<CR>', { desc = 'Show line diagnostics' })


-- Go to URL under cursor using the system's default browser
keymap.set('n', '<leader>gu', function()
    local url = vim.fn.expand('<cfile>')
    -- Check if it's a valid URL
    if url:match('^https?://') or url:match('^www%.') then
        -- Use xdg-open on Linux, open on macOS, or start on Windows
        local opener = vim.fn.has('mac') == 1 and 'open' or vim.fn.has('unix') == 1 and 'xdg-open' or 'start'
        vim.fn.jobstart({ opener, url }, { detach = true })
        vim.notify('Opening ' .. url)
    else
        vim.notify('No valid URL under cursor', vim.log.levels.WARN)
    end
end, { desc = 'Go to URL' })

-- Quickfix navigation
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>qo", ":copen<CR>", { desc = 'Open quickfix' })
keymap.set("n", "<leader>qf", ":cfirst<CR>", { desc = 'First quickfix item' })
keymap.set("n", "<leader>qn", ":cnext<CR>", { desc = 'Next quickfix item' })
keymap.set("n", "<leader>qp", ":cprev<CR>", { desc = 'Previous quickfix item' })
keymap.set("n", "<leader>ql", ":clast<CR>", { desc = 'Last quickfix item' })
keymap.set("n", "<leader>qc", ":cclose<CR>", { desc = 'Close quickfix' })

-- Harpoon
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>ha", require("harpoon.mark").add_file, { desc = 'Add file' })
keymap.set("n", "<leader>hh", require("harpoon.ui").toggle_quick_menu, { desc = 'Toggle menu' })
for i = 1, 9 do
    keymap.set("n", string.format("<leader>h%d", i), 
        function() require("harpoon.ui").nav_file(i) end,
        { desc = string.format('Navigate to file %d', i) })
end

-- Debug
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>bb", "<cmd>lua require'dap'.toggle_breakpoint()<cr>", { desc = 'Toggle breakpoint' })
keymap.set("n", "<leader>bc", "<cmd>lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", { desc = 'Conditional breakpoint' })
keymap.set("n", "<leader>bl", "<cmd>lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", { desc = 'Logpoint' })
keymap.set("n", '<leader>br', "<cmd>lua require'dap'.clear_breakpoints()<cr>", { desc = 'Clear breakpoints' })
keymap.set("n", '<leader>ba', '<cmd>Telescope dap list_breakpoints<cr>', { desc = 'List breakpoints' })
keymap.set("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>", { desc = 'Continue' })
keymap.set("n", "<leader>dj", "<cmd>lua require'dap'.step_over()<cr>", { desc = 'Step over' })
keymap.set("n", "<leader>dk", "<cmd>lua require'dap'.step_into()<cr>", { desc = 'Step into' })
keymap.set("n", "<leader>do", "<cmd>lua require'dap'.step_out()<cr>", { desc = 'Step out' })
keymap.set("n", '<leader>dd', function() 
    require('dap').disconnect()
    require('dapui').close()
end, { desc = 'Disconnect' })
keymap.set("n", '<leader>dt', function() 
    require('dap').terminate()
    require('dapui').close()
end, { desc = 'Terminate' })
keymap.set("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>", { desc = 'Toggle REPL' })
keymap.set("n", "<leader>dl", "<cmd>lua require'dap'.run_last()<cr>", { desc = 'Run last' })
keymap.set("n", '<leader>di', function() require "dap.ui.widgets".hover() end, { desc = 'Variables' })
keymap.set("n", '<leader>ds', function() 
    local widgets = require "dap.ui.widgets"
    widgets.centered_float(widgets.scopes) 
end, { desc = 'Scopes' })
keymap.set("n", '<leader>df', '<cmd>Telescope dap frames<cr>', { desc = 'List frames' })
keymap.set("n", '<leader>dh', '<cmd>Telescope dap commands<cr>', { desc = 'List commands' })
keymap.set("n", '<leader>de', function() 
    require('telescope.builtin').diagnostics({default_text=":E:"}) 
end, { desc = 'List errors' })

-- Spell checking
-----------------------------------------------------------------------------------------
keymap.set('n', '<leader>zp', ':set spell!<CR>', { desc = 'Toggle spell check' })
keymap.set('n', '<leader>zn', ']s', { desc = 'Next misspelled word' })
keymap.set('n', '<leader>zb', '[s', { desc = 'Previous misspelled word' })
keymap.set('n', '<leader>za', 'zg', { desc = 'Add word to spellfile' })
keymap.set('n', '<leader>zr', 'zw', { desc = 'Remove word from spellfile' })
keymap.set('n', '<leader>z?', 'z=', { desc = 'Suggest corrections' })

-- Extra tools
-----------------------------------------------------------------------------------------
keymap.set("n", "<leader>xr", ":call VrcQuery()<CR>", { desc = 'Run REST query' })
keymap.set("n", "<leader>xa", ':ASToggle<CR>', { desc = 'Toggle autosave' })
keymap.set("n", "<leader>np", '<cmd>NoNeckPain<cr>', { desc = 'Toggle no neck pain' })
keymap.set("n", "<leader>xm", ':set ma<CR>', { desc = 'Toggle modifiable' })
keymap.set('n', '<leader>xh', ':<C-f>', { noremap = true, silent = true, desc = 'Command history' })

-- Line movement
-----------------------------------------------------------------------------------------
vim.keymap.set('n', '<A-j>', '<cmd>m .+1<cr>==', { desc = 'Move line down' })
vim.keymap.set('n', '<A-k>', '<cmd>m .-2<cr>==', { desc = 'Move line up' })
vim.keymap.set('i', '<A-j>', '<esc><cmd>m .+1<cr>==gi', { desc = 'Move line down' })
vim.keymap.set('i', '<A-k>', '<esc><cmd>m .-2<cr>==gi', { desc = 'Move line up' })
vim.keymap.set('v', '<A-j>', ":m '>+1<cr>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', '<A-k>', ":m '<-2<cr>gv=gv", { desc = 'Move selection up' })

-- Git (LazyGit + Gitsigns)
-----------------------------------------------------------------------------------------
local gitsigns = require('gitsigns')

-- LazyGit
keymap.set('n', '<leader>vv', function() vim.cmd('LazyGit') end, { desc = 'Open LazyGit' })
keymap.set('n', '<leader>vf', function() vim.cmd('LazyGitFilter') end, { desc = 'LazyGit file history' })
keymap.set('n', '<leader>vc', function() vim.cmd('LazyGitConfig') end, { desc = 'LazyGit config' })

-- Navigation between hunks
keymap.set('n', ']c', function()
    if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
    else
        gitsigns.nav_hunk('next')
    end
end, { desc = 'Next git change' })

keymap.set('n', '[c', function()
    if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
    else
        gitsigns.nav_hunk('prev')
    end
end, { desc = 'Previous git change' })

-- Quick actions (inline)
keymap.set('n', '<leader>vs', gitsigns.stage_hunk, { desc = 'Stage hunk' })
keymap.set('n', '<leader>vr', gitsigns.reset_hunk, { desc = 'Reset hunk' })
keymap.set('v', '<leader>vs', function()
    gitsigns.stage_hunk { vim.fn.line('.'), vim.fn.line('v') }
end, { desc = 'Stage hunk' })
keymap.set('v', '<leader>vr', function()
    gitsigns.reset_hunk { vim.fn.line('.'), vim.fn.line('v') }
end, { desc = 'Reset hunk' })
keymap.set('n', '<leader>vp', gitsigns.preview_hunk, { desc = 'Preview git changes' })
keymap.set('n', '<leader>vb', gitsigns.blame_line, { desc = 'View git blame' })

-- Toggles
keymap.set('n', '<leader>tb', gitsigns.toggle_current_line_blame, { desc = 'Toggle git blame' })
keymap.set('n', '<leader>td', gitsigns.preview_hunk_inline, { desc = 'Toggle git deleted' })

-- Set highlight on search, but clear on pressing <Esc> in normal mode
vim.opt.hlsearch = true
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')

-- Java-specific keymaps
keymap.set("n", '<leader>co', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').organize_imports()
    end
end, { desc = 'Organize imports' })

keymap.set("n", '<leader>cu', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').update_projects_config()
    end
end, { desc = 'Update project config' })

keymap.set("n", '<leader>tc', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').test_class()
    end
end, { desc = 'Test class' })

keymap.set("n", '<leader>tm', function()
    if vim.bo.filetype == 'java' then
        require('jdtls').test_nearest_method()
    end
end, { desc = 'Test method' })
