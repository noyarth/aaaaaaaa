Config = {}

--SERVICE--
-- # Locale to be used. You can create your own by simple copying the 'en' and translating the values.
Config.Locale       				= 'fr' -- Traduções disponives en / br

-- # By how many services a player's community service gets extended if he tries to escape
Config.ServiceExtensionOnEscape		= 8

-- # Don't change this unless you know what you are doing.
Config.ServiceLocation 				= {x =  170.43, y = -990.7, z = 30.09}

-- # Don't change this unless you know what you are doing.
Config.ReleaseLocation				= {x = 427.33, y = -979.51, z = 30.2}


-- # Don't change this unless you know what you are doing.
Config.ServiceLocations = {
	{ type = "cleaning", coords = vector3(170.0, -1006.0, 29.34) },
	{ type = "cleaning", coords = vector3(177.0, -1007.94, 29.33) },
	{ type = "cleaning", coords = vector3(181.58, -1009.46, 29.34) },
	{ type = "cleaning", coords = vector3(189.33, -1009.48, 29.34) },
	{ type = "cleaning", coords = vector3(195.31, -1016.0, 29.34) },
	{ type = "cleaning", coords = vector3(169.97, -1001.29, 29.34) },
	{ type = "cleaning", coords = vector3(164.74, -1008.0, 29.43) },
	{ type = "cleaning", coords = vector3(163.28, -1000.55, 29.35) },
	{ type = "gardening", coords = vector3(181.38, -1000.05, 29.29) },
	{ type = "gardening", coords = vector3(188.43, -1000.38, 29.29) },
	{ type = "gardening", coords = vector3(194.81, -1002.0, 29.29) },
	{ type = "gardening", coords = vector3(198.97, -1006.85, 29.29) },
	{ type = "gardening", coords = vector3(201.47, -1004.37, 29.29) }
}



Config.Uniforms = {
	prison_wear = {
		male = {
			['tshirt_1'] = 15,  ['tshirt_2'] = 0,
			['torso_1']  = 139, ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 1, ['pants_1']  = 143,
			['pants_2']  = 4,   ['shoes_1']  = 12,
			['shoes_2']  = 100,  ['chain_1']  = 0,
			['chain_2']  = 0
		},
		female = {
			['tshirt_1'] = 10,   ['tshirt_2'] = 0,
			['torso_1']  = 449,  ['torso_2']  = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms']     = 0,  ['pants_1'] = 36,
			['pants_2']  = 6,  ['shoes_1']  = 61,
			['shoes_2']  = 0,   ['chain_1']  = 0,
			['chain_2']  = 0
		}
	}
}

--JAILS--
Config.Locations = {
    ["reclaim_items"] = { x = 1841.66, y = 2580.5, z = 45.02 }
}

Config.PrisonMisc ={
	[1] = {
		pos = vector3(1767.52, 2585.06, 45.8),
		text = '[E] look for food/water',
		func = 'searchFood',
		done = false
	},

	[2] = {
		pos = vector3(1768.34, 2581.7, 45.8),
		text = '[E] search',
		func = 'searchRand',
		done = false
	},

	[3] = {
		pos = vector3(1767.56, 2577.3, 45.8),
		text = '[E] search',
		func = 'searchRand',
		done = false
	},

	[4] = {
		pos = vector3(1768.34, 2573.89, 45.00),
		text = '[E] search',
		func = 'searchRand',
		done = false
	},	

	[5] = {
		pos = vector3(1790.48, 2574.41, 45.8),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},	

	[6] = {
		pos = vector3(1790.48, 2578.17, 45.56),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},	

	[7] = {
		pos = vector3(1790.45, 2582.0, 45.8),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},	

	[8] = {
		pos = vector3(1790.48, 2585.88, 45.56),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},		

	[9] = {
		pos = vector3(1762.05, 2593.45, 45.56),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},		

	[10] = {
		pos = vector3(1765.67, 2589.42, 45.95),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},

	[11] = {
		pos = vector3(1762.51, 2571.06, 45.92),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},

	[12] = {
		pos = vector3(1762.93, 2584.99, 45.8),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},

	[13] = {
		pos = vector3(1763.36, 2578.63, 45.72),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},

	[14] = {
		pos = vector3(1773.61, 2598.88, 45.59),
		text = '[E] search',
		func = 'searchRand',
		done=  false
	},

	[15] = {
		pos = vector3(1776.32, 2598.78, 45.5),
		text = '[E] look for food',
		func = 'searchFood',
		done = false
	},	

}

Config.JailPositions = {
	["Cell"] = { ["x"] = 1679.815, ["y"] = 2589.112, ["z"] = 45.91064, ["h"] = 277.7953 }
}

Config.Cutscene = {
	["PhotoPosition"] = { ["x"] = 1679.815, ["y"] = 2589.112, ["z"] = 45.91064, ["h"] = 277.7953 },

	["CameraPos"] = { ["x"] = 1684.444, ["y"] = 2589.165, ["z"] = 45.91064, ["rotationX"] = -15.433070763946, ["rotationY"] = 0.0, ["rotationZ"] = -0.31496068835258, ["cameraId"] = 0 },

	["PolicePosition"] = { ["x"] = 1684.444, ["y"] = 2589.165, ["z"] = 45.91064, ["h"] = 356.88052368164 }
}

Config.PrisonWork = {
	["DeliverPackage"] = { ["x"] = 1729.23, ["y"] = 2563.9, ["z"] = 45.56, ["h"] = 188.85 },

  ["Packages"] = {
    [1] = { ["x"] = 1714.47, ["y"] = 2527.58, ["z"] = 45.56, ["state"] = true },
    [2] = { ["x"] = 1712.32, ["y"] = 2527.04, ["z"] = 45.56, ["state"] = true },
    [3] = { ["x"] = 1709.76, ["y"] = 2525.47, ["z"] = 45.56, ["state"] = true },
    [4] = { ["x"] = 1707.82, ["y"] = 2523.91, ["z"] = 45.56, ["state"] = true },
    [5] = { ["x"] = 1704.77, ["y"] = 2526.32, ["z"] = 45.56, ["state"] = true },
    [6] = { ["x"] = 1706.91, ["y"] = 2527.92, ["z"] = 45.56, ["state"] = true },
    [7] = { ["x"] = 1709.14, ["y"] = 2529.26, ["z"] = 45.56, ["state"] = true },
    [8] = { ["x"] = 1711.79, ["y"] = 2530.43, ["z"] = 45.56, ["state"] = true },
    [9] = { ["x"] = 1711.94, ["y"] = 2532.87, ["z"] = 45.56, ["state"] = true },
    [10] = { ["x"] = 1709.36, ["y"] = 2531.92, ["z"] = 45.56, ["state"] = true }
  },

	["Welding"] = {
		[1] = { ["x"] = 1622.44, ["y"] = 2507.69, ["z"] = 45.56, ["state"] = true },
		[2] = { ["x"] = 1643.89, ["y"] = 2490.82, ["z"] = 45.56, ["state"] = true },
		[3] = { ["x"] = 1627.97, ["y"] = 2538.24, ["z"] = 45.56, ["state"] = true },
		[4] = { ["x"] = 1609.93, ["y"] = 2539.75, ["z"] = 45.56, ["state"] = true },
		[5] = { ["x"] = 1609.07, ["y"] = 2566.95, ["z"] = 45.56, ["state"] = true },
		[6] = { ["x"] = 1624.30, ["y"] = 2577.38, ["z"] = 45.56, ["state"] = true },
		[7] = { ["x"] = 1629.93, ["y"] = 2564.24, ["z"] = 45.56, ["state"] = true },
		[8] = { ["x"] = 1652.52, ["y"] = 2564.31, ["z"] = 45.56, ["state"] = true },
		[9] = { ["x"] = 1718.47, ["y"] = 2527.82, ["z"] = 45.56, ["state"] = true },
		[10] = { ["x"] = 1760.60, ["y"] = 2519.02, ["z"] = 45.56, ["state"] = true },
		[11] = { ["x"] = 1737.34, ["y"] = 2504.71, ["z"] = 45.56, ["state"] = true },
		[12] = { ["x"] = 1706.94, ["y"] = 2481.14, ["z"] = 45.56, ["state"] = true },
		[13] = { ["x"] = 1700.05, ["y"] = 2474.98, ["z"] = 45.56, ["state"] = true },
		[14] = { ["x"] = 1679.68, ["y"] = 2480.41, ["z"] = 45.56, ["state"] = true },
		[15] = { ["x"] = 1664.90, ["y"] = 2501.53, ["z"] = 45.56, ["state"] = true }
	}
}

Config.Teleports = {
	["Prison Work"] = { 
		["x"] = 992.51770019531, 
		["y"] = -3097.8413085938, 
		["z"] = -38.995861053467, 
		["h"] = 81.15771484375, 
		["goal"] = { 
			"Jail" 
		} 
	},

	["Boiling Broke"] = { 
		["x"] = 1845.6022949219, 
		["y"] = 2585.8029785156, 
		["z"] = 45.672061920166, 
		["h"] = 92.469093322754, 
		["goal"] = { 
			"Security" 
		} 
	},

	["Jail"] = { 
		["x"] = 1800.6979980469, 
		["y"] = 2483.0979003906, 
		["z"] = -122.68814849854, 
		["h"] = 271.75274658203, 
		["goal"] = { 
			"Prison Work", 
			"Security", 
			"Visitor" 
		} 
	},

	["Security"] = { 
		["x"] = 1706.7625732422,
		["y"] = 2581.0793457031, 
		["z"] = -69.407371520996, 
		["h"] = 267.72802734375, 
		["goal"] = { 
			"Jail",
			"Boiling Broke"
		} 
	},

	["Visitor"] = {
		["x"] = 1699.7196044922, 
		["y"] = 2574.5314941406, 
		["z"] = -69.403930664063, 
		["h"] = 169.65020751953, 
		["goal"] = { 
			"Jail" 
		} 
	}
}