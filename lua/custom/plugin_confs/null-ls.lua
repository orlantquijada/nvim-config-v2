local ok, null_ls = pcall(require, "null-ls")

if not ok then
   return
end

local b = null_ls.builtins

local sources = {

   -- JS html css stuff
   b.formatting.prettierd.with {
      filetypes = {
         "html",
         "json",
         "markdown",
         "css",
         "javascript",
         "javascriptreact",
         "typescript",
         "typescriptreact",
      },
   },
   b.diagnostics.eslint.with {
      command = "eslint_d",
   },
   -- enable if you want to auto organize tailwind classes on save
   -- b.formatting.rustywind, -- tailwind

   -- Lua
   b.formatting.stylua,
   b.diagnostics.luacheck.with { extra_args = { "--global vim" } },

   -- Shell
   b.formatting.shfmt,
   b.diagnostics.shellcheck.with { diagnostics_format = "#{m} [#{c}]" },

   -- Python
   b.formatting.black,
   b.diagnostics.flake8,
}

local M = {}

M.setup = function(on_attach)
   null_ls.config {
      sources = sources,
   }
   require("lspconfig")["null-ls"].setup { on_attach = on_attach }
end

return M
