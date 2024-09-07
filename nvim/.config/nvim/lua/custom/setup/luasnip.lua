local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt
local extras = require("luasnip.extras")
local rep = extras.rep

vim.keymap.set({ "i", "s" }, "<A-n>", function()
	if ls.choice_active() then
		ls.change_choice(1)
	end
end)

vim.keymap.set({ "i", "s" }, "<C-l>", function()
	if ls.expand_or_jumpable() then
		ls.expand_or_jump()
	end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<C-h>", function()
	if ls.jumpable(-1) then
		ls.jump(-1)
	end
end, { silent = true })

ls.add_snippets("lua", {
	s("hello", {
		t('print("hello '),
		i(1),
		t(' world")'),
	}),

	s("if", {
		t("if "),
		i(1, "true"),
		t(" then "),
		i(2),
		t(" end"),
	}),
})

ls.add_snippets("javascriptreact", {

	s(
		"rfe",
		fmt(
			[[function {}({}){{
        return {}
}}
export default {}
    ]],
			{ i(1), i(2), i(0), rep(1) }
		)
	),

	s(
		"ref",
		fmt(
			[[export function {}({}){{
        return {}
}} 
    ]],
			{ i(1), i(2), i(0) }
		)
	),

	s(
		"ra",
		fmt(
			[[({}) => {{
    return {}
}}
    ]],
			{ i(1), i(2) }
		)
	),

	s(
		"rea",
		fmt(
			[[export const {} = ({}) => {{
    return {}
}}
    ]],
			{ i(1), i(2), i(3) }
		)
	),

	s(
		"rae",
		fmt(
			[[const {} = ({}) => {{
    return {}
}}
export default {}
    ]],
			{ i(1), i(2), i(3), rep(1) }
		)
	),
})

ls.add_snippets("typescriptreact", {

	s(
		"rde",
		fmt(
			[[function {}({}){{
        return {}
}}
export default {};
    ]],
			{ i(1), i(2), i(0), rep(1) }
		)
	),

	s(
		"re",
		fmt(
			[[export function {}({}){{
        return {}
}} 
    ]],
			{ i(1), i(2), i(0) }
		)
	),

	s(
		"af",
		fmt(
			[[({}) => {{
    return {}
}}
    ]],
			{ i(1), i(2) }
		)
	),

	s(
		"afe",
		fmt(
			[[export const {} = ({}) => {{
    return {}
}}
    ]],
			{ i(1), i(2), i(3) }
		)
	),

	s(
		"afde",
		fmt(
			[[const {} = ({}) => {{
    return {}
}}
export default {}
    ]],
			{ i(1), i(2), i(3), rep(1) }
		)
	),
})

ls.add_snippets("go", {
	s(
		"fe",
		fmt(
			[[{}, err := {}({})
if err != nil{{
    log.Fatal({})
}} 
        ]],
			{ i(1), i(2), i(3), i(4) }
		)
	),
	s(
		"ie",
		fmt(
			[[if err != nil{{
  return err
}}]],
			{}
		)
	),
})

vim.keymap.set("n", "<leader>ms", "<cmd>source ~/.config/nvim/init.lua<CR>")
