return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",
			"j-hui/fidget.nvim",
			"hrsh7th/cmp-nvim-lsp",
		},
		config = function()
			require("mason").setup({})
			require("fidget").setup({})
			vim.api.nvim_create_autocmd("LspAttach", {
				callback = function(event)
					local telescope = require("telescope.builtin")
					local map = function(keys, func, desc)
						vim.keymap.set("n", keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
					end
					map("gd", telescope.lsp_definitions, "Goto Definitions")
					map("gr", telescope.lsp_references, "Goto References")
					map("<leader>rn", vim.lsp.buf.rename, "Rename")
					map("<leader>ca", vim.lsp.buf.code_action, "Code Action")
					map("K", vim.lsp.buf.hover, "Hover Documentation")
					map("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")
					map("<c-_>", telescope.lsp_document_symbols, "Document Symbols")
					map("<leader>ws", telescope.lsp_dynamic_workspace_symbols, "Workspace Symbols")
					map("<leader>D", vim.lsp.buf.type_definition, "Type Definition")
					map("gI", vim.lsp.buf.implementation, "Goto Implementation")
				end,
			})

			vim.diagnostic.config({
				virtual_text = false,
				signs = {
					active = true,
					text = {
						[vim.diagnostic.severity.ERROR] = "",
						[vim.diagnostic.severity.WARN] = "",
						[vim.diagnostic.severity.INFO] = "",
						[vim.diagnostic.severity.HINT] = "",
					},
					numhl = {
						[vim.diagnostic.severity.ERROR] = "DiagnosticSignError",
						[vim.diagnostic.severity.WARN] = "DiagnosticSignWarn",
						[vim.diagnostic.severity.INFO] = "DiagnosticSignInfo",
						[vim.diagnostic.severity.HINT] = "DiagnosticSignHint",
					},
				},
			})

			vim.keymap.set("n", "[c", function()
				vim.diagnostic.jump({ count = -1, float = true })
			end)

			vim.keymap.set("n", "]c", function()
				vim.diagnostic.jump({ count = 1, float = true })
			end)

			vim.api.nvim_create_autocmd("BufWritePre", {
				callback = function()
					if vim.bo.ft == "python" then
						vim.lsp.buf.code_action({
							context = { only = { "source.organizeImports" } },
							apply = true,
						})
					end
				end,
			})

			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local tools = {
				"stylua",
				"eslint_d",
				"prettier",
			}

			local servers = {
				-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/configs.md
				lua_ls = {
					settings = {
						Lua = {
							diagnostics = { disable = { "missing-fields" } },
						},
					},
				},
				jsonls = {},
				elmls = {},
				pyright = {},
				ts_ls = {},
				css_variables = {},
				ruff = {
					init_options = {
						settings = {
							organizeImports = true,
						},
					},
				},
				cssls = {
					init_options = {
						provideFormatter = false,
					},
				},
				stylelint_lsp = {
					settings = {
						stylelintplus = {
							autoFixOnSave = true,
							autoFixOnFormat = true,
						},
					},
				},
			}

			local ensure_installed = vim.tbl_keys(servers)
			vim.list_extend(ensure_installed, tools)
			require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

			vim.lsp.enable("gleam")

			require("mason-lspconfig").setup({
				automatic_enable = true,
				ensure_installed = {}, -- handled by mason-tool-installer
				automatic_installation = false,
				handlers = {
					function(server_name)
						local server = servers[server_name] or {}
						server.capabilities = capabilities
						vim.lsp.config(server)
					end,
				},
			})
		end,
	},
	{
		-- Lazydev configures LuaLS for editing Neovim config
		"folke/lazydev.nvim",
		ft = "lua",
		opts = {
			library = {
				{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
			},
		},
	},
	-- Formatters
	{
		"stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				lua = { "stylua" },
				javascript = { "eslint_d", "prettier" },
				javascriptreact = { "eslint_d", "prettier" },
				html = { "prettier" },
				scss = { "prettier" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_format = "fallback",
			},
		},
	},
}
