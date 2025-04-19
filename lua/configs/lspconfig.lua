
local lspconfig = require "lspconfig"

local servers = { "html", "cssls", "clangd", "lua_ls", "ts_ls", "eslint", "rust_analyzer", "gopls", "pylsp" }

-- lsps with default config
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    capabilities = vim.lsp.protocol.make_client_capabilities(),
  }
end


-- Without the loop, you would have to manually set up each LSP 
-- 
-- lspconfig.html.setup {
--   on_attach = nvlsp.on_attach,
--   capabilities = nvlsp.capabilities,
-- }
