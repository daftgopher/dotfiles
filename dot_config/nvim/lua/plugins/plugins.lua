return {
  {
    "github/copilot.vim",
    "rebelot/kanagawa.nvim",
    config = function()
      vim.cmd("colorscheme kanagawa")
    end,
    event = "VimEnter",
  },
}
