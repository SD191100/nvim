local cmp_nvim_lsp = require("cmp_nvim_lsp")
local keymap = vim.keymap

-- diagnostics UI
vim.diagnostic.config({
	virtual_text = true,
	signs = true,
	underline = true,
	update_in_insert = false,
	severity_sort = true,
})

-- capabilities for autocompletion
local capabilities = cmp_nvim_lsp.default_capabilities()

-- LSP attach keymaps
vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(ev)
		local opts = { buffer = ev.buf, silent = true }

		opts.desc = "Show LSP references"
		keymap.set("n", "gR", "<cmd>Telescope lsp_references<CR>", opts)

		opts.desc = "Go to declaration"
		keymap.set("n", "gD", vim.lsp.buf.declaration, opts)

		opts.desc = "Show LSP definitions"
		keymap.set("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opts)

		opts.desc = "Show LSP implementations"
		keymap.set("n", "gi", "<cmd>Telescope lsp_implementations<CR>", opts)

		opts.desc = "Show LSP type definitions"
		keymap.set("n", "gt", "<cmd>Telescope lsp_type_definitions<CR>", opts)

		opts.desc = "Code actions"
		keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)

		opts.desc = "Rename symbol"
		keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)

		opts.desc = "Show diagnostics"
		keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)

		opts.desc = "Hover docs"
		keymap.set("n", "K", vim.lsp.buf.hover, opts)

		opts.desc = "Restart LSP"
		keymap.set("n", "<leader>rs", "<cmd>LspRestart<CR>", opts)
	end,
})
-- diagnostic signs
local signs = { Error = " ", Warn = " ", Hint = "󰠠 ", Info = " " }

for type, icon in pairs(signs) do
	local hl = "DiagnosticSign" .. type
	vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = "" })
end

-- =========================
-- NEW LSP CONFIG (0.11+)
-- =========================

-- helper function
local function enable_servers(list)
	for _, server in ipairs(list) do
		vim.lsp.enable(server)
	end
end

-- basic servers
enable_servers({
	"lua_ls",
	"ts_ls",
	"html",
	"cssls",
	"emmet_ls",
	"graphql",
	"svelte",
	"gopls",
--	"clangd",
	"pyright",

	"asm_lsp",
})

vim.lsp.config("asm_lsp", {
	filetypes = { "asm", "nasm" },
})

vim.lsp.config("clangd", {
	capabilities = capabilities,

    cmd = {
        "clangd",

        "--background-index",

        "--header-insertion=never",

        "--query-driver=/home/sd/.platformio/packages/toolchain-xtensa-esp32/bin/*",

        "--compile-commands-dir=.",
    },
})
-- lua_ls config
vim.lsp.config("lua_ls", {
	capabilities = capabilities,
	settings = {
		Lua = {
			diagnostics = {
				globals = { "vim" },
			},
			completion = {
				callSnippet = "Replace",
			},
		},
	},
})

-- graphql config
vim.lsp.config("graphql", {
	capabilities = capabilities,
	filetypes = {
		"graphql",
		"gql",
		"svelte",
		"typescriptreact",
		"javascriptreact",
	},
})

--htmx config
vim.lsp.config("htmx", {
	capabilities = capabilities,
	filetypes = {
		"html",
		"htmx",
	},
})

-- svelte config
vim.lsp.config("svelte", {
	capabilities = capabilities,
	on_attach = function(client)
		vim.api.nvim_create_autocmd("BufWritePost", {
			pattern = { "*.js", "*.ts" },
			callback = function(ctx)
				client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
			end,
		})
	end,
})
