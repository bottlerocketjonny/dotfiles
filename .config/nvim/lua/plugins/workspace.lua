return {
  "sanathks/workspace.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    require("workspace").setup({
      workspaces = {
        { name = "Work",  path = "~/code/work-projects",  keymap = { "<leader>pw" } },
        { name = "Personal", path = "~/code/personal-projects", keymap = { "<leader>pp" } },
      }
    })
  end,
}
