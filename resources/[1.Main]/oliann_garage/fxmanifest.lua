fx_version 'cerulean'

game 'gta5'

lua54 'yes'

author 'https://www.github.com/Slashy'

version '2.10.0'

dependencies { 
    '/server:5104',
    '/gameBuild:2612',
    '/onesync',
}

shared_scripts {
    '@es_extended/imports.lua',
    '@ox_lib/init.lua',
    'locale.lua',
    'locales/*.lua',
    'config.lua'
}

client_scripts {
    '@PolyZone/client.lua',
    '@PolyZone/BoxZone.lua',
    '@PolyZone/CircleZone.lua',
    'client/vehicle_names.lua',
    'client/client.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/version_check.lua',
    'server/server.lua'
}
