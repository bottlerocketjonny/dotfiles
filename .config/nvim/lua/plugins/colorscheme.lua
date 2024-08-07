return {
  { -- You can easily change to a different colorscheme.
    -- Change the name of the colorscheme plugin below, and then
    -- change the command in the config to whatever the name of that colorscheme is.
    --
    -- If you want to see what colorschemes are already installed, you can use `:Telescope colorscheme`.
    'folke/tokyonight.nvim',
    priority = 1000, -- Make sure to load this before all the other start plugins.
    init = function()
      -- vim.cmd.colorscheme 'retrobox'

      -- You can configure highlights by doing something like:
      vim.cmd.hi 'Comment gui=none'
    end,
  },

  {
    'loctvl842/monokai-pro.nvim',
    priority = 1000, -- Ensure this is loaded before other plugins
    opts = {
      transparent_background = false,
      terminal_colors = true,
      -- devicons = true,
      styles = {
        comment = { italic = true },
        keyword = { italic = true },
        type = { italic = true },
        storageclass = { italic = true },
        structure = { italic = true },
        parameter = { italic = true },
        annotation = { italic = true },
        tag_attribute = { italic = true },
      },
      filter = 'ristretto',
      inc_search = 'background',
      background_clear = {
        'neo-tree',
        'telescope',
      },
      plugins = {
        bufferline = {
          underline_selected = false,
          underline_visible = false,
        },
        indent_blankline = {
          context_highlight = 'default',
          context_start_underline = false,
        },
      },
      override = function(c)
        Normal = { bg = "#000000" }
        vim.api.nvim_set_hl(0, 'StatusLine', { fg = '#ffffff', bg = '#3a3a3a' })
        vim.api.nvim_set_hl(0, 'StatusLineNC', { fg = '#aaaaaa', bg = '#202020' })
      end,
    },
    config = function(_, opts)
      require('monokai-pro').setup(opts)
      vim.cmd 'colorscheme monokai-pro-ristretto'
    end,
  },
  -- {
  --   'ofirgall/ofirkai.nvim',
  --   opts = {},
  --   config = function(_, opts)
  --     require('ofirkai').setup(opts)
  --     -- vim.cmd 'colorscheme ofirkai-darkblue'
  --   end,
  -- },

  {
    'rose-pine/neovim',
    name = 'rose-pine',
    event = 'VeryLazy',
    opts = {
      styles = {
        bold = false,
        transparency = true,
      },
      highlight_groups = {
        -- StatusLine
        StatusLine = { bg = 'overlay', fg = 'subtle' },
        --- modes
        StatusLineAccent = { bg = 'none', fg = 'love' },
        StatusLineInsertAccent = { bg = 'none', fg = 'gold' },
        StatusLineVisualAccent = { bg = 'none', fg = 'rose' },
        StatusLineReplaceAccent = { bg = 'none', fg = 'pine' },
        StatusLineCmdLineAccent = { bg = 'none', fg = 'foam' },
        StatusLineTerminalAccent = { bg = 'none', fg = 'iris' },
        --- gitsigns
        StatusLineGitSignsAdd = { bg = 'overlay', fg = 'foam' },
        StatusLineGitSignsChange = { bg = 'overlay', fg = 'rose' },
        StatusLineGitSignsDelete = { bg = 'overlay', fg = 'love' },
        --- diagnostics
        StatusLineDiagnosticSignError = { bg = 'overlay', fg = 'love' },
        StatusLineDiagnosticSignWarn = { bg = 'overlay', fg = 'gold' },
        StatusLineDiagnosticSignInfo = { bg = 'overlay', fg = 'foam' },
        StatusLineDiagnosticSignHint = { bg = 'overlay', fg = 'iris' },
        StatusLineDiagnosticSignOk = { bg = 'overlay', fg = 'pine' },

        Cursor = { bg = 'text', fg = 'base' },
        CursorLine = { bg = 'none' },
      },
    },
    config = function(_, opts)
      require('rose-pine').setup(opts)
      -- vim.cmd('colorscheme rose-pine')
    end,
  },

  {
    'rebelot/kanagawa.nvim',
    lazy = false,
    priority = 1000,
    opts = {
      -- transparent = true,
      background = {
        -- light = "lotus",
        dark = 'wave', -- "wave, dragon"
      },
      colors = {
        palette = {
          -- Background colors
          sumiInk0 = '#161616', -- modified
          sumiInk1 = '#181818', -- modified
          sumiInk2 = '#1a1a1a', -- modified
          sumiInk3 = '#1F1F1F', -- modified
          sumiInk4 = '#2A2A2A', -- modified
          sumiInk5 = '#363636', -- modified
          sumiInk6 = '#545454', -- modified

          -- Popup and Floats
          waveBlue1 = '#322C47', -- modified
          waveBlue2 = '#4c4464', -- modified

          -- Diff and Git
          winterGreen = '#2B3328',
          winterYellow = '#49443C',
          winterRed = '#43242B',
          winterBlue = '#252535',
          autumnGreen = '#76A56A', -- modified
          autumnRed = '#C34043',
          autumnYellow = '#DCA561',

          -- Diag
          samuraiRed = '#E82424',
          roninYellow = '#FF9E3B',
          waveAqua1 = '#7E9CD8',  -- modified
          dragonBlue = '#7FB4CA', -- modified

          -- Foreground and Comments
          oldWhite = '#C8C093',
          fujiWhite = '#F9E7C0',   -- modified
          fujiGray = '#727169',
          oniViolet = '#BFA3E6',   -- modified
          oniViolet2 = '#BCACDB',  -- modified
          crystalBlue = '#8CABFF', -- modified
          springViolet1 = '#938AA9',
          springViolet2 = '#9CABCA',
          springBlue = '#7FC4EF', -- modified
          waveAqua2 = '#77BBDD',  -- modified

          springGreen = '#98BB6C',
          boatYellow1 = '#938056',
          boatYellow2 = '#C0A36E',
          carpYellow = '#FFEE99', -- modified

          sakuraPink = '#D27E99',
          waveRed = '#E46876',
          peachRed = '#FF5D62',
          surimiOrange = '#FFAA44', -- modified
          katanaGray = '#717C7C',
        },
      },
    },
    config = function(_, opts)
      require('kanagawa').setup(opts) -- Replace this with your favorite colorscheme
      -- vim.cmd 'colorscheme kanagawa' -- Replace this with your favorite colorscheme

      -- Custom diff colors
      vim.cmd [[
      autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
      autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
      autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
      autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
    ]]

      -- Custom border colors
      vim.cmd [[
      autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
      autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
    ]]
    end,
  },

  {
    'mcchrish/zenbones.nvim',
    dependencies = { 'rktjmp/lush.nvim' },
    config = function()
      -- vim.cmd('colorscheme rosebones')
      vim.g.darkness = 'stark'
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
