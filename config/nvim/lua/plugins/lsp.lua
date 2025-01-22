return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"folke/neodev.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		opts = {
			diagnostics = {
				virtual_text = false,
			},
			servers = {
				jsonls = {},
				elmls = {},
				rust_analyzer = {},
				pyright = {},
				ts_ls = {},
				stylelint_lsp = {},
				ruff = {},
				cssls = {},
				lua_ls = {
					settings = {
						Lua = {
							workspace = { checkThirdParty = false },
							telemetry = { enable = false },
						},
					},
				},
			},
			tools = {
				"eslint_d",
				"stylua",
				"prettier",
			},
		},
		config = function(_, opts)
			require("neodev").setup()
			require("mason").setup()
			local mason_lspconfig = require("mason-lspconfig")

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			-- Diagnostics
			vim.fn.sign_define("DiagnosticSignError", { text = "", numhl = "DiagnosticSignError" })
			vim.fn.sign_define("DiagnosticSignWarn", { text = "", numhl = "DiagnosticWarn" })
			vim.fn.sign_define("DiagnosticSignHint", { text = "", numhl = "DiagnosticSignHint" })
			vim.fn.sign_define("DiagnosticSignInfo", { text = "", numhl = "DiagnosticSignInfo" })
			vim.diagnostic.config(opts.diagnostics)
			vim.keymap.set("n", "[c", vim.diagnostic.goto_prev)
			vim.keymap.set("n", "]c", vim.diagnostic.goto_next)

			local on_attach = function(client, bufnr)
				local nmap = function(keys, func, desc)
					if desc then
						desc = "LSP: " .. desc
					end

					vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
				end

				local format = function()
					vim.lsp.buf.format({
						timeout_ms = 5000,
						filter = function(client)
							return client.name ~= "cssls"
						end,
					})
				end

				-- Keymaps
				local telescope = require("telescope.builtin")
				nmap("gd", telescope.lsp_definitions, "Goto Definitions")
				nmap("gr", telescope.lsp_references, "Goto References")
				nmap("<leader>rn", vim.lsp.buf.rename, "Rename")
				nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")
				nmap("K", vim.lsp.buf.hover, "Hover Documentation")
				nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
				nmap("<c-_>", telescope.lsp_document_symbols, "Document Symbols")

				nmap("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")
				nmap("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
				nmap("gI", vim.lsp.buf.implementation, "Goto Implementation")

				-- Format on save
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = vim.api.nvim_create_augroup("LspFormat." .. bufnr, {}),
					buffer = bufnr,
					callback = format,
				})

				-- Create a command `:Format`
				vim.api.nvim_buf_create_user_command(
					bufnr,
					"Format",
					format,
					{ desc = "Format current buffer with LSP" }
				)
			end

			-- Ensure tools installed
			local mr = require("mason-registry")
			for _, tool in ipairs(opts.tools) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end

			-- Ensure LSPs installed
			mason_lspconfig.setup({
				ensure_installed = vim.tbl_keys(opts.servers),
			})

			mason_lspconfig.setup_handlers({
				function(server_name)
					require("lspconfig")[server_name].setup({
						capabilities = capabilities,
						on_attach = on_attach,
						settings = opts.servers[server_name],
					})
				end,
			})
		end,
	},

	-- Formatters
	{
		"jose-elias-alvarez/null-ls.nvim",
		event = "BufReadPre",
		dependencies = { "mason.nvim" },
		opts = function()
			local nls = require("null-ls")
			return {
				sources = {
					nls.builtins.formatting.stylua,
					nls.builtins.formatting.eslint_d,
					nls.builtins.formatting.prettier,
					nls.builtins.diagnostics.eslint_d,
					nls.builtins.hover.dictionary,
				},
			}
		end,
	},

	{
		"hrsh7th/nvim-cmp",
		version = false,
		dependencies = {
			"hrsh7th/cmp-nvim-lsp", -- nvim-cmp <> lsp
			"L3MON4D3/LuaSnip",
			"saadparwaiz1/cmp_luasnip", -- nvim-cmp <> luasnip
		},
		opts = function()
			local cmp = require("cmp")
			local luasnip = require("luasnip")
			return {
				completion = {
					completeopt = "menu,menuone,noinsert,noselect",
				},
				snippet = {
					expand = function(args)
						luasnip.lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-Space>"] = cmp.mapping.complete({}),
					["<C-l>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.confirm({ select = true })
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.abort()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-e>"] = cmp.mapping.scroll_docs(2),
					["<C-y>"] = cmp.mapping.scroll_docs(-2),
					["<C-C>"] = function()
						vim.cmd("stopinsert")
					end,
				}),
				sources = cmp.config.sources({
					{ name = "nvim_lsp" },
					{ name = "luasnip" },
					{ name = "buffer" },
				}),
			}
		end,
	},
}
