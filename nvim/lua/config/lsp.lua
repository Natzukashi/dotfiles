local M = {}

M.setup = function()
    vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        underline = true,
        float = { border = "rounded" },
    })

    vim.lsp.config("*", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
    })

    vim.lsp.config('nil_ls', {
        cmd = { 'nil' },
        filetypes = { 'nix' },
        root_markers = { 'flake.nix', '.git' },
    })
    local servers = { "lua_ls", "basedpyright", "nil_ls" }

    for _, server in ipairs(servers) do
        vim.lsp.enable(server)
    end


    vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(ev)
            local opts = { buffer = ev.buf, noremap = true, silent = true }
            vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
            vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
            vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
            vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)


            vim.api.nvim_create_autocmd("BufWritePre", {
                buffer = ev.buf,
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end,

    })
end

return M
