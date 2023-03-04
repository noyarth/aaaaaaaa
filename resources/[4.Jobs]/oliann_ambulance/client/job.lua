local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local isBusy, deadPlayers, deadPlayerBlips, isOnDuty = false, {}, {}, false
isInShopMenu = false
--- Menu Patron 
exports.qtarget:AddBoxZone("EMSBoss", vector3(335.5858, -594.3289, 43.21335), 2, 3, {
  name="EMSBoss",
  heading=269.850,
  --debugPoly=true,
  minZ=42.90,
  maxZ=43.50
	}, {
		options = {
			{
			    event = "emslikeabossing", 
			    icon = "far fa-circle",
			    label = "Menu Patron",
				job = "ambulance",
			},
		},
		distance = 3.5
})

RegisterNetEvent('emslikeabossing')
AddEventHandler('emslikeabossing', function()
	OpenMoEMSBoss()
end)

function OpenMoEMSBoss()
	TriggerEvent('esx_society:openBossMenu', 'ambulance', function(data, menu)
		menu.close()
		end, { wash = false })
end

exports.qtarget:AddBoxZone("AmbulanceActions", vector3(302.2757, -598.3661, 43.7841), 2.0, 1, {
  name="AmbulanceActions",
  heading=66.3505,
  --debugPoly=true,
  minZ=41.50,
  maxZ=44.40
	}, {
		options = {
			{
			    event = "EMSACTIONS", 
			    icon = "far fa-circle",
			    label = "Actions Ambulance",
				job = "ambulance",
			},
		},
		distance = 3.5
})
--- Vetement OX_LIB
RegisterNetEvent('EMSACTIONS')
AddEventHandler('EMSACTIONS', function()
	lib.registerContext({
		id = 'EMSACTIONS',
		title = 'Actions Ambulancier',
		onExit = function()
		end,
		options = {
			{
				title = 'Coffre',
				description = 'Ouvrir le coffre ems',
				onSelect = function(args)
					OpenCoffreEMS()
				end,
			},
			{
				title = 'Vos Vetement',
				description = 'Prendre vos propre vetement',
				onSelect = function(args)
					TriggerServerEvent('oliann_ambulance:citizen_wear')	
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						TriggerEvent('skinchanger:loadSkin', skin)
							isOnDuty = false
				
						for playerId,v in pairs(deadPlayerBlips) do
							RemoveBlip(v)
							deadPlayerBlips[playerId] = nil
						end
					end)
				end,
			},
			{
				title = 'Vetement Ambulance',
				description = 'Prendre votre tenue de travail',
				onSelect = function(args)
					TriggerServerEvent('oliann_ambulance:ambulance_wear')
					ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
						if skin.sex == 0 then
							TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
						else
							TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
						end
					end)
				end,
			},
		},
	})
	lib.showContext('EMSACTIONS')
end)

function OpenCoffreEMS()
	if Config.OxInventory then
		exports.ox_inventory:openInventory('stash', {id = 'society_ambulance'})
	end
end

RegisterNetEvent('ems:med')
AddEventHandler('ems:med', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 3.0 then
        ESX.ShowNotification('Personne proche')
    else 
		TriggerServerEvent('medSystem:getplayer', GetPlayerServerId(closestPlayer))		
	end
end)

RegisterNetEvent('oliann_ambulance:sendbill')
AddEventHandler('oliann_ambulance:sendbill', function()
      local input = lib.inputDialog('FACTURE AMBULANCE', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_ambulance', 'Facture Ambulance', amount)
			end
		end
    end
end)


RegisterNetEvent('oliann_ambulance:treatplayer')
AddEventHandler('oliann_ambulance:treatplayer', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer == -1 or closestDistance > 3.0 then
        ESX.ShowNotification('Personne Proche')
    else 
		ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
			if quantity > 0 then
				local closestPlayerPed = GetPlayerPed(closestPlayer)
				local health = GetEntityHealth(closestPlayerPed)

				if health > 0 then
					local playerPed = PlayerPedId()

					IsBusy = true
					ESX.ShowNotification('info', _U('heal_inprogress'))
					TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
					Citizen.Wait(10000)
					ClearPedTasks(playerPed)

					TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
					TriggerServerEvent('esx_ambulancejob:heal', GetPlayerServerId(closestPlayer), 'big')
					ESX.ShowNotification('info', _U('heal_complete', GetPlayerName(closestPlayer)))
					IsBusy = false
				else
					--exports['Xyyy_Notifications']:showNotify ('info', _U('player_not_conscious'))
					ESX.ShowNotification('La personne n\'est pas concious', 'info', 7500)
				end
			else
				--exports['Xyyy_Notifications']:showNotify ('info', _U('not_enough_medikit'))
				ESX.ShowNotification('Tu n\'a pas de medikit', 'error', 7500)
			end
		end, 'medikit')
	end

end)

RegisterNetEvent('oliann_ambulance:searchplayer')
AddEventHandler('oliann_ambulance:searchplayer', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer then
		if closestPlayer ~= -1 and closestDistance <= 1.0 then
			local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
			exports['idolo_progbar']:Progress({
				name = "unique_action_name",
				duration = 1600,
				label = 'Searching Player',
				useWhileDead = true,
				canCancel = true,
				controlDisables = {
					disableMovement = true,
					disableCarMovement = true,
					disableMouse = false,
					disableCombat = true,
				},
				animation = {
					animDict = dict,
					anim = anim,
					flags = 49,
				},
			}, function(cancelled)
				if not cancelled then
					exports['ox_inventory']:openInventory()
				end
			end)
		end
    end
end)

RegisterNetEvent('oliann_ambulance:revive')
AddEventHandler('oliann_ambulance:revive', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestPlayer ~= -1 and closestDistance <= 3.0 then
		revivePlayer(closestPlayer)
	else
		ESX.ShowNotification('Personne Proche!')
	end
end)

function revivePlayer(closestPlayer)
	isBusy = true

	ESX.TriggerServerCallback('esx_ambulancejob:getItemAmount', function(quantity)
		if quantity > 0 then
			local closestPlayerPed = GetPlayerPed(closestPlayer)

			if IsPedDeadOrDying(closestPlayerPed, 1) then
				local playerPed = PlayerPedId()
				local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'
				ESX.ShowNotification(_U('revive_inprogress'))

				for i=1, 15 do
					Citizen.Wait(900)

					ESX.Streaming.RequestAnimDict(lib, function()
						TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0.0, false, false, false)
					end)
				end

				TriggerServerEvent('esx_ambulancejob:removeItem', 'medikit')
				TriggerServerEvent('esx_ambulancejob:revive', GetPlayerServerId(closestPlayer))
			else
				ESX.ShowNotification(_U('player_not_unconscious'))
			end
		else
			ESX.ShowNotification(_U('not_enough_medikit'))
		end
		isBusy = false
	end, 'medikit')
end

RegisterNetEvent('esx_ambulancejob:putInVehicle')
AddEventHandler('esx_ambulancejob:putInVehicle', function()
	local playerPed = PlayerPedId()
	local vehicle, distance = ESX.Game.GetClosestVehicle()

	if vehicle and distance < 5 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
		end
	end
end)

RegisterNetEvent('oliann_ambulance:citizen_wear')
AddEventHandler('oliann_ambulance:citizen_wear', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
		TriggerEvent('skinchanger:loadSkin', skin)
			isOnDuty = false

		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end
	end)
end)

RegisterNetEvent('oliann_ambulance:ambulance_wear')
AddEventHandler('oliann_ambulance:ambulance_wear', function()
	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
	if skin.sex == 0 then
		TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_male)
	else
		TriggerEvent('skinchanger:loadClothes', skin, jobSkin.skin_female)
	end
		isOnDuty = true
		TriggerEvent('esx_ambulancejob:setDeadPlayers', deadPlayers)
	end)
end)

RegisterNetEvent('esx_ambulancejob:heal')
AddEventHandler('esx_ambulancejob:heal', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	if isOnDuty and job ~= 'ambulance' then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		isOnDuty = false
	end
end)

RegisterNetEvent('esx_ambulancejob:setDeadPlayers')
AddEventHandler('esx_ambulancejob:setDeadPlayers', function(_deadPlayers)
	deadPlayers = _deadPlayers

	if isOnDuty then
		for playerId,v in pairs(deadPlayerBlips) do
			RemoveBlip(v)
			deadPlayerBlips[playerId] = nil
		end

		for playerId,status in pairs(deadPlayers) do
			if status == 'distress' then
				local player = GetPlayerFromServerId(playerId)
				local playerPed = GetPlayerPed(player)
				local blip = AddBlipForEntity(playerPed)

				SetBlipSprite(blip, 303)
				SetBlipColour(blip, 1)
				SetBlipFlashes(blip, true)
				SetBlipCategory(blip, 7)

				BeginTextCommandSetBlipName('STRING')
				AddTextComponentSubstringPlayerName(_U('blip_dead'))
				EndTextCommandSetBlipName(blip)

				deadPlayerBlips[playerId] = blip
			end
		end
	end
end)
