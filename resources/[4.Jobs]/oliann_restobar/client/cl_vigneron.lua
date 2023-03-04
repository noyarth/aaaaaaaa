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

exports.qtarget:AddBoxZone("VigneronBoss", vector3(-1876.881592, 2059.183350, 145.573730), 2.2, 1, {
	name="VigneronBoss",
	heading=60.612381,
	debugPoly=false,
	minZ=12.98,
	maxZ=14.38,
	}, {
		options = {
			{
				event = "vigneronboss",
				icon = "fas fa-cube",
				label = "Vigneron Patron",
				job = "vigne",
			},
		},
		distance = 2.5
})

RegisterNetEvent('vigneronboss')
AddEventHandler('vigneronboss', function()
	TriggerEvent('esx_society:openBossMenu', 'vigne', function(data, menu)
		menu.close()
		end, { wash = false })
end)


exports.qtarget:AddBoxZone("VigneronClothing", vector3(-1887.562378, 2069.580811, 145.573929), 2.4, 1, {
	name="VigneronClothing",
	heading=151.515366,
	debugPoly=false,
	minZ=12.98,
	maxZ=15.98,
	}, {
		options = {
			{
				event = "vigneronclothes",
				icon = "fas fa-cube",
				label = "Vetement Vigneron",
				job = "vigne",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("RecolteRaisin", vector3(-1880.548706, 2098.549561, 139.831009), 50, 50, {
	name="RecolteRaisin",
	heading=0.310077,
	debugPoly=false,
    minZ = 139.68,
    maxZ = 142.68,
	}, {
		options = {
			{
				event = "recolteraisinvigne",
				icon = "fas fa-cube",
				label = "Recolte Raisin",
				job = "vigne",
			},
		},
		distance = 2.5
})


exports.qtarget:AddBoxZone("RecolteBouteille", vector3(-1934.860962, 2059.515381, 140.837891), 4.4, 1, {
	name="RecolteBouteille",
	heading=252.985382,
	debugPoly=false,
	minZ=140.83,
	maxZ=142.83,
	}, {
		options = {
			{
				event = "bouteillevigne",
				icon = "fas fa-cube",
				label = "Recolte Bouteille",
				job = "vigne",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("VigneronCoffre", vector3(-1203.66, -895.91, 13.98), 1.6, 1, {
	name="VigneronCoffre",
	heading=35,
	debugPoly=false,
	minZ=12.98,
	maxZ=15.38,
	}, {
		options = {
			{
				event = "vigneroncoffre",
				icon = "fas fa-cube",
				label = "Coffre Vigneron",
				job = "vigne",
			},
		},
		distance = 2.5
})


function cleanPlayer(playerPed)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

RegisterNetEvent('vigneronclothes')
AddEventHandler('vigneronclothes', function()
	lib.registerContext({
		id = 'vigneronclothes',
		title = 'Actions Vetements',
		onExit = function()
		end,
		options = {
			{
				title = 'Vos Vetement',
				description = 'Prendre vos propre vetement',
				onSelect = function(args)
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						local isMale = skin.sex == 0
				
						TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
							ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
								TriggerEvent('skinchanger:loadSkin', skin)
								TriggerEvent('esx:restoreLoadout')
							end)
						end)
					end)
				end,
			},
			{
				title = 'Vigneron vetement',
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('vigne_wear', playerPed)
				end,
			},
		},
	})
	lib.showContext('vigneronclothes')
end)

function setUniform(job, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'vigne_wear' then
                SetPedArmour(playerPed, 100)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'vigne_wear' then
                SetPedArmour(playerPed, 100)
            end
        end
    end)
end

local reward = math.random(Config.Reward.Min, Config.Reward.Max)

RegisterNetEvent('recolteraisinvigne')
AddEventHandler('recolteraisinvigne', function()
	lib.registerContext({
		id = 'recolteraisinvigne',
		title = 'Recolte Raisin',
		onExit = function()
		end,
		options = {
			{
				title = 'Recolte Raisin',
				description = '',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('Fail.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_vigneron:add', 'item', 4, 'raisin')
					ESX.ShowNotification('Vous avez recolter')
					TriggerEvent('recolteraisinvigne')	
				end,
			},
		},
	})
	lib.showContext('recolteraisinvigne')
end)

local reward = math.random(Config.Reward.Min, Config.Reward.Max)
local times = 3

--- debut boisson

RegisterNetEvent('bouteillevigne')
AddEventHandler('bouteillevigne', function()
	lib.registerContext({
		id = 'bouteillevigne',
		title = 'Recolte Bouteille',
		onExit = function()
		end,
		options = {
			{
				title = 'Recolte Bouteille Vide',
				description = 'Recoltation Bouteille Vide',
				onSelect = function(args)
						loadDict("anim@mp_player_intupperspray_champagne")
						TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
						for i = 1, 2, 1 do
							local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
							if finished <= 0 then
								 ESX.ShowNotification('Fail.')
								 ClearPedTasksImmediately(PlayerPedId())
								 return
							end
						end
						ClearPedTasks(PlayerPedId())
						TriggerServerEvent('oliann_burger:add', 'item', 2, 'bouteillevide')
						ESX.ShowNotification('Tu a recolter')
						TriggerEvent('bouteillevigne')			
				end,
			},
		},
	})
	lib.showContext('bouteillevigne')
end)

RegisterNetEvent('vignecoffre')
AddEventHandler('vignecoffre', function()
	OpenVigneStash()
end)

function OpenVigneStash()
	exports.ox_inventory:openInventory('stash', {id='Vigneron', owner= false, job = vigne})
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

Citizen.CreateThread(function()

    local blipMarker = Config.Blips.Vigneron
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Vigneron")
    EndTextCommandSetBlipName(blipCoord)
end)