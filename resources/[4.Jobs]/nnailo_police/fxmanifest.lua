fx_version 'adamant'

game 'gta5'

lua54 'yes'

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

developer 'nnailoDev'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'server/main.lua',
	'server/gsr_s.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/en.lua',
	'locales/fr.lua',
	'config.lua',
	'client/main.lua',
	'client/vehicle.lua',
	'client/action.lua',
	'client/gsr_c.lua'	
}

exports {
	'IsInPolCuffs',
}