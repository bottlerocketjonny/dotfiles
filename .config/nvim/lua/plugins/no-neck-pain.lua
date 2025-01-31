return {
  'shortcuts/no-neck-pain.nvim',
  opts = {
    width = 200,
    buffers = {
      colors = {
        blend = 1,
      }
    },
    autocmds = {
      -- enableOnVimEnter = true,
      skipEnteringNoNeckPainBuffer = true
    }
  },
}
