local function safe_require(module)
    local status, lib = pcall(require, module)
    if not status then
        print("Aguardando plugin: " .. module)
        return nil
    end
    return lib
end

safe_require("guilherme")
