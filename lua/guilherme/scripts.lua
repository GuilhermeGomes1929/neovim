local function create_module_structure()
    local input = vim.fn.input
    local module_name = input("Enter the module name: ")
    local lang = input("Enter the programming language (e.g., cs, java): ")

    if module_name == "" or lang == "" then
        print("Both module name and language are required.")
        return
    end

    local base_path = input("Enter the base directory (relative to project root): ")
    if base_path == "" then
        base_path = "."
    end

    local function create_file(path, content)
        vim.fn.mkdir(vim.fn.fnamemodify(path, ":h"), "p") -- Create parent directories if they don't exist
        local file = io.open(path, "w")
        if file then
            file:write(content or "")
            file:close()
        end
    end

    -- Define paths
    local module_path = base_path .. "/" .. module_name
    local controller_path = module_path .. "/Controllers/" .. module_name .. "Controller." .. lang
    local service_interface_path = module_path .. "/Services/Interfaces/" .. module_name .. "Service." .. lang
    local service_impl_path = module_path .. "/Services/Impl/" .. module_name .. "ServiceImpl." .. lang
    local repository_interface_path = module_path .. "/Repositories/Interfaces/" .. module_name .. "Repository." .. lang
    local repository_impl_path = module_path .. "/Repositories/Impl/" .. module_name .. "RepositoryImpl." .. lang

    -- Create files
    create_file(controller_path, "// " .. module_name .. " Controller")
    create_file(service_interface_path, "// Interface for " .. module_name .. " Service")
    create_file(service_impl_path, "// Implementation for " .. module_name .. " Service")
    create_file(repository_interface_path, "// Interface for " .. module_name .. " Repository")
    create_file(repository_impl_path, "// Implementation for " .. module_name .. " Repository")

    vim.cmd("NERDTreeRefreshRoot")
    print("Module structure created successfully!")
end

-- Add a Neovim command to execute the script
vim.api.nvim_create_user_command("CreateModule", create_module_structure, {})

