local M = {}

M.setup = function()
    vim.api.nvim_create_autocmd('FileType', {
        pattern = { 'python', 'lua' },
        callback = function()
            vim.treesitter.start()

            vim.wo[0][0].foldmethod = 'expr'
            vim.wo[0][0].foldexpr   = 'v:lua.vim.treesitter.foldexpr()'
            vim.wo[0][0].foldenable  = false

            vim.bo.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
        end,
    })
end

return M
