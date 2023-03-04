fx_version 'adamant'

game 'gta5'

description "Jail and Community Service"

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
	'@ox_lib/init.lua'
}
server_scripts {
    "@es_extended/locale.lua",
	"@oxmysql/lib/MySQL.lua",
	"locales/en.lua",
	"config.lua",
	"server/server.lua",
	"server/community_s.lua"
}

client_scripts {
    "@es_extended/locale.lua",
	"locales/en.lua",
	"config.lua",
	"client/utils.lua",
	"client/client.lua",
	"client/community_c.lua"
}




