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

RegisterNetEvent('oliann_restobar:sendbill')
AddEventHandler('oliann_restobar:sendbill', function()
      local input = lib.inputDialog('FACTURE BURGERSHOT', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_burger', 'Facture Burgershot', amount)
			end
		end
    end
end)

exports.qtarget:AddBoxZone("BurgerBill", vector3(-1195.39, -892.34, 14.10), 1.0 , 1.5, {
	name="BurgerBill",
	heading=35,
	debugPoly=false,
	minZ=14.0,
	maxZ=14.30,
	}, {
		options = {
			{
				event = "oliann_restobar:sendbill",
				icon = "fas fa-cube",
				label = "Facture Burgershot",
				job = "burgershot",
			},
		},
		distance = 2.5
})



exports.qtarget:AddBoxZone("BurgerBoss", vector3(-1178.22, -896.4, 13.98), 2.2, 1, {
	name="BurgerBoss",
	heading=35,
	debugPoly=false,
	minZ=12.98,
	maxZ=14.38,
	}, {
		options = {
			{
				event = "burgerboss",
				icon = "fas fa-cube",
				label = "BurgerShot Patron",
				job = "burgershot",
			},
		},
		distance = 2.5
})

RegisterNetEvent('burgerboss')
AddEventHandler('burgerboss', function()
	TriggerEvent('esx_society:openBossMenu', 'burgershot', function(data, menu)
		menu.close()
		end, { wash = false })
end)

exports.qtarget:AddBoxZone("MakeDrinksTwo", vector3(-1199.192, -896.28, 13.89), 2.2, 1, {
	name="MakeDrinksTwo",
	heading=35,
	debugPoly=false,
	minZ=12.98,
	maxZ=14.98,
	}, {
		options = {
			{
				event = "burgerdrinks",
				icon = "fas fa-cube",
				label = "BurgerShot Boisson",
				job = "burgershot",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("BugerCloakroom", vector3(-1182.02, -900.14, 13.98), 2.4, 1, {
	name="BugerCloakroom",
	heading=305,
	debugPoly=false,
	minZ=12.98,
	maxZ=15.98,
	}, {
		options = {
			{
				event = "burgerclothes",
				icon = "fas fa-cube",
				label = "Vetement Burgershot",
				job = "burgershot",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("BurgerOrder", vector3(-1194.9, -893.04, 13.98), 0.8, 1, {
	name="BurgerOrder",
	heading=35,
	debugPoly=false,
	minZ=12.98,
	maxZ=14.58,
	}, {
		options = {
			{
				event = "burgerorderstash",
				icon = "fas fa-cube",
				label = "Burgershot commande",
			--	job = "all",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("BurgerCook", vector3(-1201.91, -898.35, 13.98), 4.4, 1, {
	name="BurgerCook",
	heading=35,
	debugPoly=false,
	minZ=12.98,
	maxZ=14.98,
	}, {
		options = {
			{
				event = "burgercook",
				icon = "fas fa-cube",
				label = "Burgershot Cuisson",
				job = "burgershot",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("BurgerStash", vector3(-1203.66, -895.91, 13.98), 1.6, 1, {
	name="BurgerStash",
	heading=35,
	debugPoly=false,
	minZ=12.98,
	maxZ=15.38,
	}, {
		options = {
			{
				event = "burgerstash",
				icon = "fas fa-cube",
				label = "Burgershot Coffre",
				job = "burgershot",
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

RegisterNetEvent('burgerclothes')
AddEventHandler('burgerclothes', function()
	lib.registerContext({
		id = 'burgerclothes',
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
					setUniform('burger_wear', playerPed)
				end,
			},
		},
	})
	lib.showContext('burgerclothes')
end)

function setUniform(job, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'burger_wear' then
                SetPedArmour(playerPed, 100)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'burger_wear' then
                SetPedArmour(playerPed, 100)
            end
        end
    end)
end

local reward = math.random(Config.Reward.Min, Config.Reward.Max)

RegisterNetEvent('burgercook')
AddEventHandler('burgercook', function()
	lib.registerContext({
		id = 'burgercook',
		title = 'Actions Cuisson',
		onExit = function()
		end,
		options = {
			{
				title = 'Cuisson 1',
				description = 'Faire un hamburger',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[BURGERSHOT] Fail.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_burger:add', 'item', 2, 'burger')
					ESX.ShowNotification('[BURGERSHOT] Succes.')
					TriggerEvent('burgercook')	
				end,
			},
			{
				title = 'Cuisson 2',
				description = 'Faire un hamburger au poulet',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[BURGERSHOT] Fail.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_burger:add', 'item', 2, 'chickenbg')
					ESX.ShowNotification('[BURGERSHOT] Succes.')
					TriggerEvent('burgercook')	
				end,
			},
			{
				title = 'Cuisson 3',
				description = 'Faire un heart stopper',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[BURGERSHOT] Fail.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_burger:add', 'item', 2, 'heartst')
					ESX.ShowNotification('[BURGERSHOT] Succes.')
					TriggerEvent('burgercook')	
			    end,
			},
		},
	})
	lib.showContext('burgercook')
end)

local reward = math.random(Config.Reward.Min, Config.Reward.Max)
local times = 3

--- debut boisson

RegisterNetEvent('burgerdrinks')
AddEventHandler('burgerdrinks', function()
	lib.registerContext({
		id = 'burgerdrinks',
		title = 'Actions Boisson',
		onExit = function()
		end,
		options = {
			{
				title = 'Boisson 1',
				description = 'Faire une boisson',
				onSelect = function(args)
						loadDict("anim@mp_player_intupperspray_champagne")
						TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
						for i = 1, 2, 1 do
							local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
							if finished <= 0 then
								 ESX.ShowNotification('[BURGERSHOT] fail.')
								 ClearPedTasksImmediately(PlayerPedId())
								 return
							end
						end
						ClearPedTasks(PlayerPedId())
						TriggerServerEvent('oliann_burger:add', 'item', 2, 'sports_drink')
						ESX.ShowNotification('[BURGERSHOT] Succes.')
						TriggerEvent('burger:coke')			
				end,
			},
			{
				title = 'Boisson 2',
				description = 'Faire une boisson',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							ESX.ShowNotification('[BURGERSHOT] Fail.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_burger:add', 'item', 2, 'cola')
					ESX.ShowNotification('[BURGERSHOT] Success.')
					TriggerEvent('burger:coke')
				end,
			},
		},
	})
	lib.showContext('burgerdrinks')
end)

--- fin boisson

RegisterNetEvent('burgerorderstash')
AddEventHandler('burgerorderstash', function()
	OpenOrderStash()
end)

function OpenOrderStash()
	exports.ox_inventory:openInventory('stash', {id='BurgerOrderStash', owner= false})
end

RegisterNetEvent('burgerstash')
AddEventHandler('burgerstash', function()
	OpenBusinessStash()
end)

function OpenBusinessStash()
	exports.ox_inventory:openInventory('stash', {id='Burgershot', owner= false, job = burgershot})
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

Citizen.CreateThread(function()

    local blipMarker = Config.Blips.Burgershot
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("BurgerShot")
    EndTextCommandSetBlipName(blipCoord)


end)