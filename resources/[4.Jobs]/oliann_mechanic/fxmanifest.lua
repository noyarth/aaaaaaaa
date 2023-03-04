fx_version 'adamant'

game 'gta5'

lua54 'yes'

developer 'OliannDev'

shared_scripts {
    '@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'config.lua',
	'client/main.lua',
	'client/lscustom_c.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'@oxmysql/lib/MySQL.lua',
	'locales/en.lua',
	'config.lua',
	'server/main.lua',
	'server/lscustom_s.lua'
}

exports {
	'GetVehicleStatusList',
	'GetVehicleStatus',
	'SetVehicleStatus',
}
