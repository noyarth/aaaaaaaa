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

RegisterNetEvent('tacobilling')
AddEventHandler('tacobilling', function()
      local input = lib.inputDialog('FACTURE TACO', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_taco', 'Facture Taco', amount)
			end
		end
    end
end)

exports.qtarget:AddBoxZone("TacoBill", vector3(13.9688, -1601.6935, 29.8751), 2.2, 1, {
	name="TacoBill",
	heading=41.99,
	debugPoly=false,
	minZ=29.10,
	maxZ=30.16,
	}, {
		options = {
			{
				event = "tacobilling",
				icon = "fas fa-cube",
				label = "Menu Facture",
				job = "tacoshop",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("TacoBoss", vector3(11.1049, -1598.4312, 28.8762), 1.4, 1, {
	name="TacoBoss",
	heading=45,
	debugPoly=false,
	minZ=28.47,
	maxZ=29.07,
	}, {
		options = {
			{
				event = "tacoboss",
				icon = "fas fa-cube",
				label = "Menu Patron",
				job = "tacoshop",
			},
		},
		distance = 2.5
})

RegisterNetEvent('tacoboss')
AddEventHandler('tacoboss', function()
	if ESX.PlayerData.job.name == 'tacoshop' and ESX.PlayerData.job.grade_name == 'boss' then
	TriggerEvent('esx_society:openBossMenu', 'tacoshop', function(data, menu)
		menu.close()
		end, { wash = false })
	else 
		ESX.ShowNotification('[TACO] You are not authorize to open this menu!')
	end
end)

exports.qtarget:AddBoxZone("TacoDrinks", vector3(16.63688, -1599.168, 29.39709), 1.6, 1, {
	name="TacoDrinks",
	heading=315,
	debugPoly=false,
	minZ=28.77,
	maxZ=29.97,
	}, {
		options = {
			{
				event = "taco:drinkmenu",
				icon = "fas fa-cube",
				label = "Menu Boisson",
				job = "tacoshop",
			},
		},
		distance = 2.5
})

RegisterNetEvent('taco:drinkmenu')
AddEventHandler('taco:drinkmenu', function()
	lib.registerContext({
		id = 'taco:drinkmenu',
		title = 'Actions Boisson',
		onExit = function()
		end,
		options = {
			{
				title = 'Boisson 1',
				description = 'Faire une boisson sport',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(6500, math.random(3, 5))
						if finished <= 0 then
							 ESX.ShowNotification('[TACO] You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_tacos:add', 'item', 2, 'sports_drink')
					ESX.ShowNotification('[TACO] Success.')
					TriggerEvent('oliann_tacos:drinkmenu')
				end,
			},
			{
				title = 'Boisson 2',
				description = 'Faire un cocacola',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(7500, math.random(3, 5))
						if finished <= 0 then
							 ESX.ShowNotification('[TACO] You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_tacos:add', 'item', 5, 'cola')
					ESX.ShowNotification('[TACO] Success.')
					TriggerEvent('oliann_tacos:drinkmenu')
				end,
			},
		},
	})
	lib.showContext('taco:drinkmenu')
end)

exports.qtarget:AddBoxZone("TacoCloakroom", vector3(6.553349, -1604.296, 29.50532), 1.6, 1, {
	name="TacoCloakroom",
	heading=315,
	debugPoly=false,
	minZ=29.10,
	maxZ=30.0,
	}, {
		options = {
			{
				event = "Tacoclothes",
				icon = "fas fa-cube",
				label = "Menu Vetements",
				job = "tacoshop",
			},
		},
		distance = 3.5
})

RegisterNetEvent('Tacoclothes')
AddEventHandler('Tacoclothes', function()
	lib.registerContext({
		id = 'Tacoclothes',
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
				title = 'Burgershot vetement',
				description = 'Vetement de travail',
				onSelect = function(args)
				  local playerPed = PlayerPedId()
				  setUniform('tacoshop_wear', playerPed)
				end,
			},
		},
	})
	lib.showContext('Tacoclothes')
end)

exports.qtarget:AddBoxZone("TacoOrder", vector3(12.91923, -1600.28, 29.40504), 1, 1, {
	name="TacoOrder",
	heading=45,
	debugPoly=false,
	minZ=28.77,
	maxZ=30.27,
	}, {
		options = {
			{
				event = "tacoorderstash",
				icon = "fas fa-cube",
				label = "Menu Commandes",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("TacoCook", vector3(14.8074, -1596.9202, 29.8778), 1.6, 1, {
	name="TacoCook",
	heading=315,
	debugPoly=false,
	minZ=29.17,
	maxZ=30.27,
	}, {
		options = {
			{
				event = "tacocook",
				icon = "fas fa-cube",
				label = "Menu Cuisson",
				job = "tacoshop",
			},
		},
		distance = 1.5
})

RegisterNetEvent('tacocook')
AddEventHandler('tacocook', function()
	lib.registerContext({
		id = 'tacocook',
		title = 'Actions Cuisson',
		onExit = function()
		end,
		options = {
			{
				title = 'Cuisson 1',
				description = 'Faire un taco',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(7500, math.random(7, 11))
						if finished <= 0 then
							 ESX.ShowNotification('[TACO] You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_tacos:add', 'item', 5, 'taco')
					ESX.ShowNotification('[TACO] Success.')
					TriggerEvent('oliann_tacos:tacocook')
				end,
			},
			{
				title = 'Cuisson 2',
				description = 'Faire un burrito',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(7500, math.random(4, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[TACO] You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_tacos:add', 'item', 2, 'burrito')
					ESX.ShowNotification('[TACO] Success.')
					TriggerEvent('oliann_tacos:tacocook')
				end,
			},
			{
				title = 'Cuisson 3',
				description = 'Faire un quesadilla',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(7500, math.random(4, 8))
						if finished <= 0 then
							 ESX.ShowNotification('[TACO] You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_tacos:add', 'item', 1, 'quesadilla')
					ESX.ShowNotification('[TACO] Success.')
					TriggerEvent('oliann_tacos:tacocook')
				end,
			},
		},
	})
	lib.showContext('tacocook')
end)

exports.qtarget:AddBoxZone("TacoBusinessStash", vector3(13.4055, -1596.1443, 29.8777), 1.6, 1, {
	name="TacoBusinessStash",
	heading=45,
	debugPoly=false,
	minZ=29.48,
	maxZ=30.08,
	}, {
		options = {
			{
				event = "tacobusinessstash",
				icon = "fas fa-cube",
				label = "Coffre Employer",
				job = "tacoshop",
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
  
  function setClipset(playerPed, clip)
    RequestAnimSet(clip)
    while not HasAnimSetLoaded(clip) do
      Citizen.Wait(0)
    end
    SetPedMovementClipset(playerPed, clip, true)
  end

function setUniform(job, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'tacoshop_wear' then
                SetPedArmour(playerPed, 100)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'tacoshop_wear' then
                SetPedArmour(playerPed, 100)
            end
        end
    end)
end

local reward = math.random(Config.Reward.Min, Config.Reward.Max)

local times = 3

RegisterNetEvent('tacobusinessstash')
AddEventHandler('tacobusinessstash', function()
	TriggerEvent('OpenTacoStash')
end)

RegisterNetEvent('OpenTacoStash')
AddEventHandler('OpenTacoStash', function()
	exports.ox_inventory:openInventory('stash', {id='TacoEmployeeshop', owner= false})
end)

RegisterNetEvent('tacoorderstash')
AddEventHandler('tacoorderstash', function()
	OpenOrderStash()
end)

function OpenOrderStash()
	exports.ox_inventory:openInventory('stash', {id='TacoOrderStash', owner= false})
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

Citizen.CreateThread(function()

    local blipMarker = Config.Blips.Tacoshop
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Taco")
    EndTextCommandSetBlipName(blipCoord)


end)