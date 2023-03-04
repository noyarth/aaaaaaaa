Config                            = Config or {}
Config.DrawDistance               = 5.0
Config.Distance               	  = 1.5
Config.MarkerColor                = {r = 255, g = 255, b = 255}
Config.ResellPercentage           = 50
Config.ox_target 		          = false
Config.RentCar 			  		  = true
Config.PlateRentedCar 		  	  = "PDM"
Config.IPL 			  			  = true
Config.CloseCar 		  		  = true
Config.changePrice 		  		  = true
Config.Locale                     = 'fr'

Config.ColorMenu = {
	Red = 255,
	Green = 255,
	Blue = 255,
	Alpha = 100
}

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.OxInventory = ESX.GetConfig().OxInventory

Config.Blip = {
	Coords = vector3(-63.3, -1092.6, 26.5),
	Sprite  = 326,
	Display = 4,
	Scale   = 0.7,
	Colour  = 0
}

Config.Zone = {

	ShopOutside = {
		Pos     = vector3(-35.9, -1102.8, 25.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = 330.0,
		Type    = -1,
	},

	ShopInside = {
		Pos     = vector3(-35.9, -1102.8, 25.5),
		Size    = {x = 1.5, y = 1.5, z = 1.0},
		Heading = -20.0,
		Type    = -1,
	},
}

Config.Zones = {

	ShopEntering = {
		Pos   = vector3(-30.10, -1105.13, 25.45),
		Size  = {x = 0.7, y = 0.7, z = 0.7},
		Type  = 25,
		message = "Appuyez sur [E]",
		ox_message = "Accéder à l'ordinateur",
		icon = "fa-solid fa-car",
		func = function() openCarDealer() end,
		event = "esx_vehicleshop:openCarDealer",
		grade = {recruit = true, novice = true, experienced = true, boss = true},
		ox_grade = 0, -- Minimum access rank
		activate = true
	},


	BossActions = {
		Pos   = vector3(-32.0, -1114.2, 25.45),
		Size  = {x = 0.7, y = 0.7, z = 0.7},
		Type  = 25,
		message = "Appuyez sur [E]",
		ox_message = "Accéder à l'ordinateur",
		icon = "fa-solid fa-euro-sign",
		func = function() OpenBossMenu() end,
		event = "esx_vehicleshop:OpenBossMenu",
		grade = {boss = true},
		ox_grade = 3, -- Minimum access rank
		activate = true
	},

	GiveBackVehicle = {
		Pos   = vector3(-18.2, -1078.5, 25.6),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = -1,
		message = "Appuyez sur ~r~[~s~E~r~]~s~ pour rendre le véhicule",
		func = function() GiveBackVehicle() end,
		grade = 'none',
		activate = true
	},

	ResellVehicle = {
		Pos   = vector3(-43.92, -1082.63, 25.96),
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Type  = 1,
		message = "Appuyez sur ~r~[~s~E~r~]~s~ pour revendre le véhicule",
		func = function() ResellVehiclePlayers() end,
		grade = 'none',
		activate = true
	}

}