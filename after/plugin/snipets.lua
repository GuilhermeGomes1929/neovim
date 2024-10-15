local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node

ls.snippets = {
	cs = {
		s("fn", {
			i(1, "public"),
			t(" "),
			i(2, "return"),
			t(" "),
			i(3, "name"),
			t("("),
			i(4, "params"),
            t({
                "",
                "\t{",
                "\t}"
            })
		}),
	},
}
