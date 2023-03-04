ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer 
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
	
	Citizen.Wait(10)
end)

exports.qtarget:AddBoxZone("GovernmentBoss", vector3(243.874268, -1092.452393, 29.294252), 2.2, 1, {
	name="GovernmentBoss",
	heading=332.018707,
	debugPoly=false,
	minZ=37.90,
	maxZ=38.50,
	}, {
		options = {
			{
				event = "government:boss",
				icon = "fas fa-cube",
				label = "Gouvernement Patron",
				job = "government",
			},
		},
		distance = 2.5
})

RegisterNetEvent('government:boss')
AddEventHandler('government:boss', function()
	TriggerEvent('esx_society:openBossMenu', 'government', function(data, menu)
		menu.close()
		end, { wash = false })
end)


exports.qtarget:AddBoxZone("GovernmentStash", vector3(259.208374, -1075.675537, 29.294270), 1.6, 1, {
	name="GovernmentStash",
	heading=269.796539,
	debugPoly=false,
	minZ=37.20,
	maxZ=38.0,
	}, {
		options = {
			{
				event = "government:stash",
				icon = "fas fa-cube",
				label = "Gouvernement Coffre",
				job = "government",
			},
		},
		distance = 2.5
})

RegisterNetEvent('government:stash')
AddEventHandler('government:stash', function()
	OpenGovernmentStash()
end)

function OpenGovernmentStash()
	exports.ox_inventory:openInventory('stash', {id='Government', owner= false, job = government})
end