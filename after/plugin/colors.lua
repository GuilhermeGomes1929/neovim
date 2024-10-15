local dracula = require("dracula")
dracula.setup({
    transparent_bg = true,
    italic_comment = true
})
function ColorMyPencils(color)
	color = color or 'dracula'
	vim.cmd.colorscheme(color)

end

ColorMyPencils()
