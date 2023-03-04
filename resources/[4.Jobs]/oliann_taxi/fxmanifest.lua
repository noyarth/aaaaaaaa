fx_version 'adamant'

game 'gta5'

description 'OliannDev'
lua54 'yes'
version '1.8.5'


shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

client_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'client/main.lua'
}

server_scripts {
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua',
	'server/main.lua'
}

dependency 'es_extended'
