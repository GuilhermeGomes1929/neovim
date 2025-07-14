require("nvim-treesitter.configs").setup({
	-- A list of parser names, or "all" (the five listed parsers should always be installed)
	ensure_installed = {
		"java",
		"dart",
		"javascript",
		"typescript",
		"c",
		"lua",
		"vim",
		"vimdoc",
		"query",
		"c_sharp",
    "html",
    "css",
	},
	sync_install = true,
	auto_install = true,
	highlight = {
		enable = true,
	},
	indent = {
		enable = false,
	},
})
