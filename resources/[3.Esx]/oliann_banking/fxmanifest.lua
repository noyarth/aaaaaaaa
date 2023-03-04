fx_version 'adamant'

game 'gta5'

lua54 "yes"

ui_page 'web/ui.html'

files {
	'web/*.*'
}

shared_scripts {
    'config.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'client.lua',
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'server.lua'
}