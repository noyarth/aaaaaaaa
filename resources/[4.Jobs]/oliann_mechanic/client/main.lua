local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false

Options = {}

exports.qtarget:AddBoxZone("MechanicHarvest", vector3(914.8106, -2127.099, 30.25215), 3.2, 1, {
	name="MechanicHarvest",
	heading=280.0,
	debugPoly=false,
	minZ=29.9,
	maxZ=30.5,
	}, {
		options = {
			{
				event = "harvestmenu",
				icon = "fas fa-sign-in-alt",
				label = "Hervest Menu",
				job = "mechanic",
			},
		},
		distance = 3.5
})

RegisterNetEvent('harvestmenu')
AddEventHandler('harvestmenu', function()
	lib.registerContext({
		id = 'harvestmenu',
		title = 'Hervest Menu',
		onExit = function()
		end,
		options = {
			{
				title = 'Kit De Reparation',
				description = '',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(6500, math.random(3, 5))
						if finished <= 0 then
							 ESX.ShowNotification('Tu a fail')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_mechanic:add', 'item', 1, 'fixkit')
					ESX.ShowNotification('Success.')
					TriggerEvent('oliann_mechanic:harvestmenu')
		        end,
			},
			{
				title = 'Kit De Lavage',
				description = '',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(6500, math.random(3, 5))
						if finished <= 0 then
							 ESX.ShowNotification('Tu a fail')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_mechanic:add', 'item', 1, 'ragkit')
					ESX.ShowNotification('Success.')
					TriggerEvent('oliann_mechanic:harvestmenu')
				end,
			},
			{
				title = 'Kit De Hijack',
				description = '',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports['oliann_skillbar']:taskBar(6500, math.random(3, 5))
						if finished <= 0 then
							 ESX.ShowNotification('Tu a fail')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_mechanic:add', 'item', 1, 'blowpipe')
					ESX.ShowNotification('Success.')
					TriggerEvent('oliann_mechanic:harvestmenu')
				end,
			},
		},
	})
	lib.showContext('harvestmenu')
end)

RegisterNetEvent('esx_mechanicjob:placeBomb')
AddEventHandler('esx_mechanicjob:placeBomb', function(ped, coords, veh)
	local dict
	local model = 'prop_carjack'
	local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
	local headin = GetEntityHeading(ped)
	FreezeEntityPosition(veh, true)
	local vehpos = GetEntityCoords(veh)
	dict = 'mp_car_bomb'
	RequestAnimDict(dict)
	RequestModel(model)
	while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
		Citizen.Wait(1)
	end
	local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
	exports['oliann_core']:startUI(20000,"Repare le vehicule")
	ESX.ShowNotification('Lift le vehicule')
	AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	dict = 'move_crawl'
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
	SetEntityCollision(veh, false, false)
	TaskPedSlideToCoord(ped, offset, headin, 1000)
	Citizen.Wait(1000)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(100)
	end
	ESX.ShowNotification('Repare le vehicule')
	TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
	dict = 'amb@world_human_vehicle_mechanic@male@base'
	Citizen.Wait(3000)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 5000, 1, 0, false, false, false)
	dict = 'move_crawl'
	Citizen.Wait(5000)
	local coords2 = GetEntityCoords(ped)
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
	Citizen.Wait(3000)
	dict = 'mp_car_bomb'
	RequestAnimDict(dict)
	while not HasAnimDictLoaded(dict) do
		Citizen.Wait(1)
	end
	exports['oliann_core']:startUI(9000,"Descend le vehicule")
	ESX.ShowNotification('Descend le vehicule')
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
	Citizen.Wait(1250)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	dict = 'move_crawl'
	Citizen.Wait(1000)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
	TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
	SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
	FreezeEntityPosition(veh, false)
	DeleteObject(vehjack)
	SetEntityCollision(veh, true, true)
	TriggerServerEvent('esx_carBomb:storeCars', veh)
end)

ObjectInFront = function(ped, pos)
	local entityWorld = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.5, 0.0)
	local car = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, ped, 0)
	local _, _, _, _, result = GetRaycastResult(car)
	return result
end


exports.qtarget:AddBoxZone("MechanicBoss", vector3(887.7839, -2099.808, 34.82159), 2.2, 1, {
  name="MechanicBoss",
  heading=5,
  --debugPoly=true,
  minZ=33.90,
  maxZ=34.90
	}, {
		options = {
			{
			    event = "mechanicboss", 
			    icon = "far fa-circle",
			    label = "Menu Patron",
				job = "mechanic",
			},
		},
		distance = 3.5
})

RegisterNetEvent('mechanicboss')
AddEventHandler('mechanicboss', function()
	TriggerEvent('esx_society:openBossMenu', 'mechanic', function(data, menu)
		menu.close()
		end, { wash = false })
end)

exports.qtarget:AddBoxZone("MechanicCloak", vector3(882.89, -2100.03, 30.46), 2.0, 1, {
  name="MechanicCloak",
  heading=2.97,
  --debugPoly=true,
  minZ=29.90,
  maxZ=30.91
	}, {
		options = {
			{
			    event = "mechanicloakroom", 
			    icon = "far fa-circle",
			    label = "Menu Vetement",
				job = "mechanic",
			},
		},
		distance = 3.5
})


RegisterNetEvent('mechanicloakroom')
AddEventHandler('mechanicloakroom', function()
	lib.registerContext({
		id = 'mechanicloakroom',
		title = 'Vetement Mecanicien',
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
				title = 'Vetement Mecano',
				description = 'Prendre votre tenue de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('boss', playerPed)
				end,
			},
		},
	})
	lib.showContext('mechanicloakroom')
end)

RegisterNetEvent('mechanicdef')
AddEventHandler('mechanicdef', function()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0

        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
            end)
        end)

    end)
end)

RegisterNetEvent('mechanicchangeclothes')
AddEventHandler('mechanicchangeclothes', function()
    local playerPed = PlayerPedId()
    setUniform('boss', playerPed)
end)

function setUniform(uniform, playerPed)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject

		if skin.sex == 0 then
			uniformObject = Config.Uniforms[uniform].male
		else
			uniformObject = Config.Uniforms[uniform].female
		end

		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		else
			ESX.ShowNotification(_U('no_outfit'))
		end
	end)
end

-- veh start
exports.qtarget:AddBoxZone("MechanicLaptop", vector3(871.269653, -2116.109619, 30.459583), 0.6, 1, {
	name="MechanicLaptop",
	heading=0,
	--debugPoly=false,
	minZ=33.91,
	maxZ=34.90,
	}, {
		options = {
			{
				event = "oliann_mechanic:opengaragemech",
				icon = "fas fa-sign-in-alt",
				label = "Garage Mecano",
				job = "mechanic",
			},
		},
		distance = 3.5
})

for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_mechanic:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_mechanic:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengaragemech',
        title = _U('title_menu'),
        options = Options,
    })

RegisterNetEvent('oliann_mechanic:opengaragemech')
AddEventHandler('oliann_mechanic:opengaragemech',function()
	lib.showContext('opengaragemech')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.Mech.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('oliann_mechanic:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('oliann_mechanic:delCar')
AddEventHandler('oliann_mechanic:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

--- veh done 

RegisterNetEvent('mech:openstash')
AddEventHandler('mech:openstash', function()
    exports.ox_inventory:openInventory('stash', 'society_mechanic') 
end)

RegisterNetEvent('mech:roadcone')
AddEventHandler('mech:roadcone', function()
	local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
	local objectCoords = (coords + forward * 1.0)
	local obj = 'prop_roadcone02a'

	ESX.Game.SpawnObject(obj, objectCoords)
	SetEntityHeading(obj, GetEntityHeading(playerPed))
	PlaceObjectOnGroundProperly(obj)
end)

RegisterNetEvent('mech:toolchest')
AddEventHandler('mech:toolchest', function()
	local playerPed = PlayerPedId()
	local coords, forward = GetEntityCoords(playerPed), GetEntityForwardVector(playerPed)
	local objectCoords = (coords + forward * 1.0)
	local obj = 'prop_toolchest_01'

	ESX.Game.SpawnObject(obj, objectCoords)
	SetEntityHeading(obj, GetEntityHeading(playerPed))
	PlaceObjectOnGroundProperly(obj)
end)

RegisterNetEvent('mech:sendbill')
AddEventHandler('mech:sendbill', function()
      local input = lib.inputDialog('FACTURE MECANO', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification(('Montant Invalide!'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification(('Personne Proche!'))
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mechanic', 'Facture Mecano', amount)
			end
		end
    end
end)

RegisterNetEvent('mech:fixvehicle')
AddEventHandler('mech:fixvehicle', function()
		local playerPed = PlayerPedId()
		local vehicle   = ESX.Game.GetVehicleInDirection()
	    local coords    = GetEntityCoords(playerPed)
		local ped = PlayerPedId()
		local coords = GetEntityCoords(ped)
		local veh = ObjectInFront(ped, coords)

		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end

		if DoesEntityExist(vehicle) then
			isBusy = true
			TriggerServerEvent('esx_mechanicjob:triggerBomb', ped, coords, veh)
			Citizen.CreateThread(function()
			Citizen.Wait(20000)

			SetVehicleFixed(vehicle)
			SetVehicleDeformationFixed(vehicle)
			SetVehicleUndriveable(vehicle, false)
			SetVehicleEngineOn(vehicle, true, true)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification('Vehicule reparer')   
			TriggerServerEvent('esx_mechanicjob:testingkolangnaman')
			isBusy = false
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)

RegisterNetEvent('mech:cleanvehicle')
AddEventHandler('mech:cleanvehicle', function()
		local playerPed = PlayerPedId()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = GetEntityCoords(playerPed)

		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end

		if DoesEntityExist(vehicle) then
			isBusy = true
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
			CreateThread(function()
			Wait(10000)

			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification(_U('vehicle_cleaned'))
			isBusy = false
		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)

RegisterNetEvent('mech:deleteveh')
AddEventHandler('mech:deleteveh', function()
	local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

		if GetPedInVehicleSeat(vehicle, -1) == playerPed then
			ESX.ShowNotification(_U('vehicle_impounded'))
			ESX.Game.DeleteVehicle(vehicle)
		else
			ESX.ShowNotification(_U('must_seat_driver'))
		end
		else
			local vehicle = ESX.Game.GetVehicleInDirection()

		if DoesEntityExist(vehicle) then
			ESX.ShowNotification(_U('vehicle_impounded'))
			ESX.Game.DeleteVehicle(vehicle)
		else
			ESX.ShowNotification(_U('must_near'))
		end
	end
end)

RegisterNetEvent('mech:flatbedveh')
AddEventHandler('mech:flatbedveh', function()
		local playerPed = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(playerPed, true)

		local towmodel = GetHashKey("flatbed")
		local isVehicleTow = IsVehicleModel(vehicle, towmodel)

		if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()

		if CurrentlyTowedVehicle == nil then
			  if targetVehicle ~= 0 then
				  if not IsPedInAnyVehicle(playerPed, true) then
					  if vehicle ~= targetVehicle then
						AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
						CurrentlyTowedVehicle = targetVehicle
						ESX.ShowNotification(_U('vehicle_success_attached'))
					else
						ESX.ShowNotification(_U('cant_attach_own_tt'))
					end
				end
			else
				ESX.ShowNotification(_U('no_veh_att'))
			end
		else
			AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
			DetachEntity(CurrentlyTowedVehicle, true, true)

			CurrentlyTowedVehicle = nil
			ESX.ShowNotification(_U('veh_det_succ'))
		end
	else
		ESX.ShowNotification(_U('imp_flatbed'))
	end
end)

RegisterNetEvent('esx_mechanicjob:onHijack')
AddEventHandler('esx_mechanicjob:onHijack', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			CreateThread(function()
				Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent("mechanic:clean")
AddEventHandler("mechanic:clean", function()
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local coords    = GetEntityCoords(playerPed)

	if IsPedSittingInAnyVehicle(playerPed) then
		ESX.ShowNotification('Tu ne peut pas faire ceci dedans le vehicule')
		return
	end

	if DoesEntityExist(vehicle) then
		isBusy = true
		
		TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
		local finished = exports["oliann_skillbar"]:taskBar(20000, math.random(1, 2))
		if finished <= 0 then
			ESX.ShowNotification('Fail!')
			ClearPedTasks(PlayerPedId())
			isBusy = false
			return
		end

		local finished = exports["oliann_skillbar"]:taskBar(20000, math.random(1, 2))
		if finished <= 0 then
			ESX.ShowNotification('Fail!')
			ClearPedTasks(PlayerPedId())
			isBusy = false
			return
		end	

		local finished = exports["oliann_skillbar"]:taskBar(20000, math.random(1, 2))
		if finished <= 0 then
			ESX.ShowNotification('Fail!')
			ClearPedTasks(PlayerPedId())
			isBusy = false
			return
		end		

		Citizen.CreateThread(function()
			SetVehicleDirtLevel(vehicle, 0)
			ClearPedTasksImmediately(playerPed)

			ESX.ShowNotification('Le vehicule est bien nettoyer!')
			isBusy = false
		end)

		ClearPedTasks(PlayerPedId())

	else
	ESX.ShowNotification('Il a pas de vehicule proche!')
	end	
end)

RegisterNetEvent('esx_mechanicjob:onCarokit')
AddEventHandler('esx_mechanicjob:onCarokit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			CreateThread(function()
				Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx_mechanicjob:onFixkit')
AddEventHandler('esx_mechanicjob:onFixkit', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			CreateThread(function()
				Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
	ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

-- Create Blips
CreateThread(function()
	local blip = AddBlipForCoord(870.791199, -2112.870361, 30.526733)

	SetBlipSprite (blip, 446)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 0.9)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName(_U('mechanic'))
	EndTextCommandSetBlipName(blip)
end)

CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_toolchest_01'
	}

	while true do
		Wait(500)

		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = #(coords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('esx_mechanicjob:hasEnteredEntityZone', closestEntity)
				LastEntity = closestEntity
			end
		else
			if LastEntity then
				TriggerEvent('esx_mechanicjob:hasExitedEntityZone', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

RegisterCommand('removemechprops', function(source)
    if ESX.PlayerData.job.name ~= 'mechanic' then
	ESX.ShowNotification('Only mechanic can use this command.')
        return
    end

    DeleteEntity(CurrentActionData.entity)
end)

AddEventHandler('esx:onPlayerDeath', function(data) isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function(spawn) isDead = false end)


AddEventHandler('esx_mechanicjob:hasEnteredEntityZone', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mechanic' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionData = {entity = entity}
	end
end)

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end
