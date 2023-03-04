fx_version 'adamant'

game 'gta5'

lua54 'yes'

description 'ESX Vehicle Shop'

version '1.7.5'

shared_script {
	'@es_extended/imports.lua',
	'@ox_lib/init.lua',
	'@es_extended/locale.lua',
	'locales/*.lua',
	'config.lua'
}

server_scripts {
	'@async/async.lua',
	'@oxmysql/lib/MySQL.lua',
	'server/*.lua'
}

client_scripts {
    'src/RMenu.lua',
    'src/menu/RageUI.lua',
    'src/menu/Menu.lua',
    'src/menu/MenuController.lua',
    'src/components/*.lua',
    'src/menu/elements/*.lua',
    'src/menu/items/*.lua',
    'src/menu/panels/*.lua',
    'src/menu/windows/*.lua',
	'client/*.lua'
}

dependency 'es_extended'

export 'GeneratePlate'
