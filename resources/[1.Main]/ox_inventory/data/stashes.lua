---wip types

---@class OxStash
---@field name string
---@field label string
---@field owner? boolean | string | number
---@field slots number
---@field weight number
---@field groups? string | string[] | { [string]: number }
---@field blip? { id: number, colour: number, scale: number }
---@field coords? vector3
---@field target? { loc: vector3, length: number, width: number, heading: number, minZ: number, maxZ: number, distance: number, debug?: boolean, drawSprite?: boolean }

return {
	{
		coords = vec3(452.3, -991.4, 30.7),
		target = {
			loc = vec3(451.25, -994.28, 30.69),
			length = 1.2,
			width = 5.6,
			heading = 0,
			minZ = 29.49,
			maxZ = 32.09,
			label = 'Open personal locker'
		},
		name = 'policelocker',
		label = 'Personal locker',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = shared.police
	},

	{
		coords = vec3(0,0,0),
		target = {
			loc = vec3(0,0,0),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Ouvrir le coffre'
		},
		name = 'emslocker',
		label = 'Coffre',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = {['ambulance'] = 0}
	},
	{
		coords = vec3(0,0,0),
		target = {
			loc = vec3(0,0,0),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Ouvrir le coffre'
		},
		name = 'vignelocker',
		label = 'Coffre',
		owner = true,
		slots = 70,
		weight = 70000,
		groups = {['vigne'] = 0}
	},
	{
		coords = vec3(0,0,0),
		target = {
			loc = vec3(82.641762, -1963.028564, 17.822022),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Ouvrir le coffre'
		},
		name = 'ballaslocker',
		label = 'Coffre',
		owner = false,
		slots = 70,
		weight = 70000,
		faction = {['ballas'] = 0}
	},
	{
		coords = vec3(0,0,0),
		target = {
			loc = vec3(330.895081, -2015.866211, 22.394943),
			length = 0.6,
			width = 1.8,
			heading = 139.979660,
			minZ = 25.39,
			maxZ = 27.39,
			label = 'Ouvrir le coffre'
		},
		name = 'vagoslocker',
		label = 'Coffre',
		owner = false,
		slots = 70,
		weight = 70000,
		faction = {['vagos'] = 0}
	},
	{
		coords = vec3(0,0,0),
		target = {
			loc = vec3(0,0,0),
			length = 0.6,
			width = 1.8,
			heading = 340,
			minZ = 43.34,
			maxZ = 44.74,
			label = 'Ouvrir le coffre'
		},
		name = 'familocker',
		label = 'Coffre',
		owner = false,
		slots = 70,
		weight = 70000,
		faction = {['families'] = 0}
	},
}
