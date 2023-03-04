Config                            = {}

--MED SYSTEM--
Config.Declared = 'Tu est coma!' -- This Msg appeared when the player died using /med [id] to display blood = 0 - 5% and Hurt area is Head

Config.Timer = 8   -- Timer to Remove Med Display after using MedSystem

Config.job = {

		names = {
		ambulance = true, 
		police =  true, 
		mechanic = true
			--ambulance = true,             
			--police = false,  --SET This to false so Police job cant use /med commands
			--mechanic = true,  --SET This to false so mech job cant use /med commands
			--unemployed = false, --Default to False so unemployed Player cant use /med
		}
	
}

Config.TextDrawDistance           = 1.5

Config.DrawDistance               = 10.0 -- How close do you need to be in order for the markers to be drawn (in GTA units).

Config.Marker                     = {type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false}

Config.ReviveReward               = 350  -- Revive reward, set to 0 if you don't want it enabled
Config.SaveDeathStatus            = true -- Save Death Status?
Config.LoadIpl                    = true -- Disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

Config.EarlyRespawnTimer          = 60000 * 10  -- time til respawn is available
Config.BleedoutTimer              = 60000 * 10-- time til the player bleeds out

Config.EnablePlayerManagement     = true -- Enable society managing (If you are using esx_society).

Config.RemoveWeaponsAfterRPDeath  = true
Config.RemoveCashAfterRPDeath     = true
Config.RemoveItemsAfterRPDeath    = true

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = true
Config.EarlyRespawnFineAmount     = 500

Config.OxInventory                = ESX.GetConfig().OxInventory
Config.RespawnPoints = {
	{coords = vector3(335.3092, -623.8850, 29.2985), heading = 250.6986}
}

Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(296.6450, -583.7185, 43.1371),
			sprite = 61,
			scale  = 0.9,
			color  = 2
		},
	}
}

Config.cars = {
    {nom = "Ranger véhicule", modele = ""},
   -- {nom = "Dodge", modele = "dodgeEMS"},
	{nom = "Ambulance", modele = "ambulance"},
}

Config.Plate = "EMS"

Config.Ambulance = {
    SpawnVeh = vector3(294.839935, -607.602417, 43.242344),
}