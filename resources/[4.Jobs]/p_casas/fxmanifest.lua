fx_version 'cerulean'
author 'Pa1nlessz#2021'
games {'gta5'}

client_scripts {
	"cfg.lua",
	'cl.lua',
	"cl_U.lua",
	"_instance/cl.lua",
	"_garage/cl.lua",
}

shared_script 'translation.lua'

server_scripts{
	'@oxmysql/lib/MySQL.lua',
	"cfg.lua",
	"sv_U.lua",
	'sv.lua',
	"_instance/sv.lua",
	"_garage/sv.lua",
}

files {
	"ui/*.*"
}

ui_page 'ui/index.html'


--[[files {
    "interiorproxies.meta"
}
    
data_file 'INTERIOR_PROXY_ORDER_FILE' 'interiorproxies.meta']]