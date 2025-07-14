local dracula = require("dracula")
dracula.setup({
    transparent_bg = false,
    italic_comment = true
})
function ColorMyPencils(color)
	color = color or 'gruvbox'
	vim.cmd.colorscheme(color)

end

ColorMyPencils()
