vim.g.mapleader = " "

vim.keymap.set("n", "<leader>e", function()
  if vim.bo.filetype == "netrw" then
    vim.cmd("bd")
  else
    vim.cmd("Ex")
  end
end, { desc = "toggle netrw" })
