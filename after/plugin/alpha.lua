local status, alpha = pcall(require, "alpha")
if not status then
    return -- Para a execução se o telescope não estiver instalado
end
local dashboard = require("alpha.themes.startify")

dashboard.section.header.val = {
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                     ]],
	[[       ████ ██████           █████      ██                     ]],
	[[      ███████████             █████                             ]],
	[[      █████████ ███████████████████ ███   ███████████   ]],
	[[     █████████  ███    █████████████ █████ ██████████████   ]],
	[[    █████████ ██████████ █████████ █████ █████ ████ █████   ]],
	[[  ███████████ ███    ███ █████████ █████ █████ ████ █████  ]],
	[[ ██████  █████████████████████ ████ █████ █████ ████ ██████ ]],
	[[                                                                       ]],
	[[                                                                       ]],
	[[                                                                       ]],
}
dashboard.section.header.opts = {
    position = "center",
    hl = "Type"
}

alpha.setup(dashboard.opts)
