fx_version 'adamant'

game 'gta5'

lua54 'yes'

Author 'OliannDev'

shared_scripts {
    '@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server/main.lua'
}

client_scripts {
	'client/main.lua'
}
