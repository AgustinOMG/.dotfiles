local status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not status_ok then
	return
end

local lspconfig = require("lspconfig")

local servers = { "sumneko_lua","gopls" }

lsp_installer.setup({
	ensure_installed = servers,
})


-- alternatively you can override the default configs
require("flutter-tools").setup {
      debugger = {
      enabled = true,
      run_via_dap = true,
    },
    outline = { auto_open = false },
    decorations = {
      statusline = { device = true, app_version = true },
    },
    widget_guides = { enabled = true, debug = true },
    dev_log = { enabled = false, open_cmd = "tabedit" },
    lsp = {
      color = {
        enabled = true,
        background = true,
        virtual_text = false,
      },
      settings = {
        showTodos = true,
        renameFilesWithClasses = "prompt",
      },
      on_attach = require("chancito.lsp.handlers").on_attach,
      capabilities = require("chancito.lsp.handlers").capabilities,
    },}

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("chancito.lsp.handlers").on_attach,
		capabilities = require("chancito.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "chancito.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lspconfig[server].setup(opts)
end
