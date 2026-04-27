vim.keymap.set("n", "<C-a>b",function ()
    print("Seek not outside yourself.")
end , { silent = true })

vim.keymap.set({ "n", "i" }, "<C-z>", "<Cmd>undo<CR>", { silent = true})

vim.g.mapleader = " "
vim.keymap.set("n", "<leader>aa", ":lua print(123)<CR>", { silent = true })
