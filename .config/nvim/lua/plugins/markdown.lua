return {
  'MeanderingProgrammer/markdown.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  config = function()
    require('render-markdown').setup {
      file_types = { 'markdown', 'codecompanion' }
    }
  end,
}
