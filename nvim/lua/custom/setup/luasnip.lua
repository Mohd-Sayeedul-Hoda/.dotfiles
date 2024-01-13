local ls = require "luasnip"
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

vim.keymap.set({ "i", "s" }, "<A-j>", function()
    if ls.expand_or_jumpable() then
        ls.expand_or_jump()
    end
end, { silent = true })

vim.keymap.set({ "i", "s" }, "<A-k>", function()
    if ls.jumpable(-1) then
        ls.jump(-1)
    end
end, { silent = true })


ls.add_snippets("lua", {
    s("hello", {
        t('print("hello '),
        i(1),
        t(' world")')
    }),

    s("if", {
        t('if '),
        i(1, "true"),
        t(' then '),
        i(2),
        t(' end')
    })
})

ls.add_snippets("javascriptreact", {

    s("fde",
    fmt([[function {}({}){{
        return {}
}}
export default {};
    ]], {i(1), i(2), i(0), rep(1)})),

    s("fe",
    fmt([[export function {}({}){{
        return {}
}} 
    ]], {i(1), i(2),  i(0)})),

    s("af", 
    fmt([[({}) => {{
    return {}
}}
    ]], {i(1), i(2)})), 

    s("afe",
    fmt([[export const {} = ({}) => {{
    return {}
}}
    ]], {i(1), i(2), i(3)})),

    s("afde",
    fmt([[export default const {} = ({}) => {{
    return {}
}}
export default {}
    ]], {i(1), i(2), i(3), rep(1)})),

})

vim.keymap.set("n", "<leader>ms", "<cmd>source ~/.config/nvim/lua/custom/setup/luasnip.lua<CR>")
