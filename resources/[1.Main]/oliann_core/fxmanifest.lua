fx_version 'bodacious'
games { 'gta5' }

lua54 'yes'

shared_scripts {
    '@es_extended/imports.lua',
	'@ox_lib/init.lua'
}

ui_page 'progressBars/h.html'

loadscreen_manual_shutdown 'yes'

client_scripts {
    'takehostage/th_c.lua',
	'carry/cl_carry.lua',
	'progressBars/client.lua',
	'config.lua',
	'sit/lists/seat.lua',
	'sit/client.lua',
	'sirencontrol/luxvehcontrol_c.lua',
	'announce/announce_c.lua',
	'recoil.lua',
	'targets.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'takehostage/th_s.lua',
	'carry/sv_carry.lua',
	'config.lua',
	'sit/lists/seat.lua',
	'sit/server.lua',
	'sirencontrol/luxvehcontrol_s.lua',
	'announce/announce_s.lua',
	'server.lua'
}

files {
    'progressBars/h.html'
}

exports {
	'startUI',
	'closeUI',
}