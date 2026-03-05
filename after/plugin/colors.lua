local status, dracula = pcall(require, "dracula")
if not status then
    return -- Para a execução se o telescope não estiver instalado
end
dracula.setup({
    transparent_bg = false,
    italic_comment = true
})
function ColorMyPencils(color)
	color = color or 'gruvbox'
	vim.cmd.colorscheme(color)

end

ColorMyPencils()
