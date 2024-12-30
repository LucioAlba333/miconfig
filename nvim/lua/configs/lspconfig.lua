-- load defaults i.e lua_lsp
require("nvchad.configs.lspconfig").defaults()
require'lspconfig'.clangd.setup{}
require'lspconfig'.pyright.setup{}

--require'lspconfig'.ts_ls.setup{}
local lspconfig = require "lspconfig"
--require'lspconfig'.lua_ls.setup{}
-- EXAMPLE
local servers = { "html", "cssls","clangd","ts_ls","pyright","eslint",}
local nvlsp = require "nvchad.configs.lspconfig"

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = nvlsp.on_attach,
    on_init = nvlsp.on_init,
    capabilities = nvlsp.capabilities,
  }
end

-- configuring single server, example: typescript
-- lspconfig.ts_ls.setup {
--   on_attach = nvlsp.on_attach,
--   on_init = nvlsp.on_init,
--   capabilities = nvlsp.capabilities,
-- }
