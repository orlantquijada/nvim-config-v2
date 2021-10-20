local M = {}

M.setup_lsp = function(attach, capabilities)
   local lspconfig = require "lspconfig"

   -- lspservers with default config

   local servers = { "html", "cssls", "pyright", "tsserver" }

   for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
         on_attach = attach,
         capabilities = capabilities,
         flags = {
            debounce_text_changes = 150,
         },
      }
   end
   
   -- typescript
  lspconfig.tsserver.setup {
    on_attach = function(client, bufnr)
       attach(client, bufnr)
       client.resolved_capabilities.document_formatting = false
    end,
  }
  -- the above tsserver config will remvoe the tsserver's inbuilt formatting 
  -- since I use null-ls with denofmt for formatting ts/js stuff.
   
   lspconfig.pyright.setup {
      on_attach = attach,
      settings = {
        python = {
          analysis = {
            -- enum: 'strict' | 'off' | 'basic'
            -- turned off since errors are unbearable in django
            typeCheckingMode = "off"
          }
        }
      }
   }

end

return M

