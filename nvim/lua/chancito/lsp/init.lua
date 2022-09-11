local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  return
end

require "chancito.lsp.configs"
require("chancito.lsp.handlers").setup()
require "chancito.lsp.null-ls"
require("flutter-tools").setup{} -- use defaults
