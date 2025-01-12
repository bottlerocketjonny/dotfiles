return {
  'iamcco/markdown-preview.nvim',
  cmd = { 'MarkdownPreviewToggle', 'MarkdownPreview', 'MarkdownPreviewStop' },
  ft = { 'markdown', 'codecompanion' },
  build = function()
    vim.fn['mkdp#util#install']()
  end,
}

