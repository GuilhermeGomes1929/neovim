local status, toggle = pcall(require, "toggleterm")
if not status then
    return -- Para a execução se o telescope não estiver instalado
end
require('toggleterm').setup{
    size = 20,
    hide_numbers = true,
    autochdir = false,
    direction = 'horizontal',
    open_mapping = [[<c-t>]],
}
