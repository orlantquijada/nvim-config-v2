-- This is where your custom modules and plugins go.
-- See the wiki for a guide on how to extend NvChad

local hooks = require "core.hooks"

-- NOTE: To use this, make a copy with `cp example_init.lua init.lua`

--------------------------------------------------------------------

-- To modify packaged plugin configs, use the overrides functionality
-- if the override does not exist in the plugin config, make or request a PR,
-- or you can override the whole plugin config with 'chadrc' -> M.plugins.default_plugin_config_replace{}
-- this will run your config instead of the NvChad config for the given plugin

-- hooks.override("lsp", "publish_diagnostics", function(current)
--   current.virtual_text = false;
--   return current;
-- end)

-- To add new mappings, use the "setup_mappings" hook,
-- you can set one or many mappings
-- example below:

hooks.add("setup_mappings", function(map)
  -- general
  map("n", "<m-j>", ":move .+1<CR>")
  map("n", "<m-k>", ":move .-2<CR>")
  map('v', "<m-j>", ":move '>+1<CR>gv=gv")
  map('v', "<m-k>", ":move '<-2<CR>gv=gv")

  -- telescope
  map("n", "<C-P>", ":Telescope find_files <CR>")

  -- vim fugitive
  map('n', "<leader>gs", ":G<CR>")
end)

-- To add new plugins, use the "install_plugin" hook,
-- NOTE: we heavily suggest using Packer's lazy loading (with the 'event' field)
-- see: https://github.com/wbthomason/packer.nvim
-- examples below:

hooks.add("install_plugins", function(use)
   use {
        "jose-elias-alvarez/null-ls.nvim",
        after = "nvim-lspconfig",
        config = function()
           require("custom.plugin_confs.null-ls").setup()
        end,
   }
   
   use {
      "tpope/vim-surround",
      after = "nvim-lspconfig",
   }
   
   use {
      "tpope/vim-fugitive",
      after = "nvim-lspconfig",
   }

end)

vim.cmd [[ autocmd BufWritePre *.ts,*.tsx,*.html,*.js,*.jsx,*.json lua vim.lsp.buf.formatting() ]]

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
   
