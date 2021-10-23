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
   map("v", "<m-j>", ":move '>+1<CR>gv=gv")
   map("v", "<m-k>", ":move '<-2<CR>gv=gv")
   map("n", "<leader><space>", ":b#<CR>") -- <C-6> or <C-^> functionality
   map("n", "<c-Tab>", ":b#<CR>") -- <C-6> or <C-^> functionality

   -- telescope
   map("n", "<C-P>", ":Telescope find_files <CR>")

   -- vim fugitive
   map("n", "<leader>gs", ":G<CR>")

   -- Trouble
   map("n", "<leader>t", ":TroubleToggle<CR>")

   -- Bufferline
   map("n", "<m-1>", ":BufferLineGoToBuffer 1<CR>")
   map("n", "<m-2>", ":BufferLineGoToBuffer 2<CR>")
   map("n", "<m-3>", ":BufferLineGoToBuffer 3<CR>")
   map("n", "<m-4>", ":BufferLineGoToBuffer 4<CR>")
   map("n", "<m-5>", ":BufferLineGoToBuffer 5<CR>")
   map("n", "<m-6>", ":BufferLineGoToBuffer 6<CR>")
   map("n", "<m-7>", ":BufferLineGoToBuffer 7<CR>")
   map("n", "<m-8>", ":BufferLineGoToBuffer 8<CR>")
   map("n", "<m-9>", ":BufferLineGoToBuffer 9<CR>")
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
         require("custom.plugin_confs.null-ls").setup(function(client)
            if client.resolved_capabilities.document_formatting then
               vim.cmd "autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()"
            end
         end)
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

   use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function()
         require("trouble").setup {}
      end,
   }
end)

-- alternatively, put this in a sub-folder like "lua/custom/plugins/mkdir"
-- then source it with

-- require "custom.plugins.mkdir"
