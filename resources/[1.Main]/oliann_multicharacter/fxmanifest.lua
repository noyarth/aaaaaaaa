fx_version 'cerulean'
lua54 'yes'
game 'gta5' 
ui_page {
    'web/index.html',
}
client_scripts {
	'config.lua',
	'default_skin.lua',
	'client/main.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'config.lua',
	'server/framework/*.lua',
	'server/*.lua'
}

files {
	'web/index.html',
	'web/script.js',
	'web/style.css',
	'web/logo.png',
	'web/loading.gif',
	'web/ped.jpg',
}

dependencies {
	'/server:5848',
	'/onesync',
	'oxmysql',
}