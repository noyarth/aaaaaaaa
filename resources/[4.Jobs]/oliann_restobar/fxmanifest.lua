fx_version 'adamant'

game 'gta5'

developer 'OliannDev'

lua54 'yes'

shared_scripts {
	'@ox_lib/init.lua'
}

client_scripts {
	'config/config.lua',
	'client/cl_taco.lua',
	'client/cl_burger.lua',
	'client/cl_vigneron.lua',
	'client/cl_government.lua',
	'client/cl_mcdo.lua'
}

server_scripts {
	'config/config.lua',
	'server/sv_taco.lua',
	'server/sv_burger.lua',
	'server/sv_vigneron.lua',
	'server/sv_government.lua',
	'server/sv_mcdo.lua'
}
