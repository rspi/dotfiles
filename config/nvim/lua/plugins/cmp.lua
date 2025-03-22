return {
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
				{ name = "lazydev", group_index = 0 },
			}),
		}
	end,
}
