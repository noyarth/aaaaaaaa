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

exports.qtarget:AddBoxZone("McdoBilling", vector3(90.6438, 287.8600, 110.30), 2.2, 1, {
	name="McdoBilling",
	heading=229.7436,
	debugPoly=false,
	minZ=110.10,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "Mcdo:bill",
				icon = "fas fa-cube",
				label = "Menu Facture",
				job = "mcdo",
			},
		},
		distance = 2.5
})

RegisterNetEvent('Mcdo:bill')
AddEventHandler('Mcdo:bill', function()
      local input = lib.inputDialog('FACTURE MCDO', {'Amount'})

           if input then
                local amount = tonumber(input[1])
			
				if amount == nil or amount < 0 then
					ESX.ShowNotification('Montant Invalide')
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 4.0 then
					ESX.ShowNotification('Personne proche!')
				else
				TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(closestPlayer), 'society_mcdo', 'Facture McDonald', amount)
			end
		end
    end
end)

exports.qtarget:AddBoxZone("McdoBoss", vector3(82.463310, 294.420715, 110.207367), 2.2, 1, {
	name="McdoBoss",
	heading=323.297974,
	debugPoly=false,
	minZ=110.3,
	maxZ=111.0,
	}, {
		options = {
			{
				event = "mcdo:boss",
				icon = "fas fa-cube",
				label = "Menu Patron",
				job = "mcdo",
			},
		},
		distance = 2.5
})

RegisterNetEvent('mcdo:boss')
AddEventHandler('mcdo:boss', function()
	TriggerEvent('esx_society:openBossMenu', 'mcdo', function(data, menu)
		menu.close()
		end, { wash = false })
end)

exports.qtarget:AddBoxZone("McdoDrinks", vector3(95.46249, 289.1702, 110.0819), 2.4, 1, {
	name="McdoDrinks",
	heading=302,
	debugPoly=false,
	minZ=109.80,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "mcdo:drinks",
				icon = "fas fa-cube",
				label = "Menu Boisson",
				job = "mcdo",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("oliannroom", vector3(80.064835, 294.402771, 110.207443), 2.4, 1, {
	name="oliannroom",
	heading=162.833755,
	debugPoly=false,
	minZ=29.90,
	maxZ=30.50,
	}, {
		options = {
			{
				event = "oliann:clothes",
				icon = "fas fa-cube",
				label = "Menu Vetements",
				job = "mcdo",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("McdoOrder", vector3(89.7979, 285.5285, 110.3074), 2.4, 1, {
	name="McdoOrder",
	heading=302,
	debugPoly=false,
	minZ=109.90,
	maxZ=110.80,
	}, {
		options = {
			{
				event = "mcdo:orderstash",
				icon = "fas fa-cube",
				label = "Menu Commande",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("McdoCook", vector3(94.5, 294.94, 110.21), 1.5, 1.5, {
	name="McdoCook",
	heading=300,
	debugPoly=false,
	minZ = 110.01,
	maxZ = 114.01,
	}, {
		options = {
			{
				event = "mcdo:cookmenu",
				icon = "fas fa-cube",
				label = "Menu Cuisson",
				job = "mcdo",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("oliannFridge", vector3(89.3211, 296.8657, 110.3074), 1.6, 1, {
	name="oliannFridge",
	heading=47.5427,
	debugPoly=false,
	minZ=109.90,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "mcdo:stash",
				icon = "fas fa-cube",
				label = "Menu Frigidaire",
				job = "mcdo",
			},
		},
		distance = 2.5
})

exports.qtarget:AddBoxZone("McdoBossStash", vector3(85.4220, 291.8492, 110.3074), 1.6, 1, {
	name="McdoBossStash",
	heading=47.5427,
	debugPoly=false,
	minZ=109.90,
	maxZ=110.60,
	}, {
		options = {
			{
				event = "mcdo:bossstash",
				icon = "fas fa-cube",
				label = "Coffre Patron",
				job = "mcdo",
			},
		},
		distance = 1.5
})

RegisterNetEvent('mcdo:bossstash')
AddEventHandler('mcdo:bossstash', function()
	if ESX.PlayerData.job.name == 'mcdo' and ESX.PlayerData.job.grade_name == 'boss' then
	OpenBossMcdoStash()
else
    ESX.ShowNotification('Tu a pas access a ce coffre!')
    end
end)


function cleanPlayer(playerPed)
    ClearPedBloodDamage(playerPed)
    ResetPedVisibleDamage(playerPed)
    ClearPedLastWeaponDamage(playerPed)
    ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
    TriggerEvent('skinchanger:getSkin', function(skin)
        if skin.sex == 0 then
            if Config.Uniforms[job].male ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].male)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'mcdo_wear' then
                SetPedArmour(playerPed, 100)
            end
        else
            if Config.Uniforms[job].female ~= nil then
                TriggerEvent('skinchanger:loadClothes', skin, Config.Uniforms[job].female)
            else
                ESX.ShowNotification(('No outfit'))
            end

            if job == 'mcdo_wear' then
                SetPedArmour(playerPed, 100)
            end
        end
    end)
end

local reward = math.random(Config.Reward.Min, Config.Reward.Max)

--EVENTS--

RegisterNetEvent('oliann:clothes')
AddEventHandler('oliann:clothes', function()
	lib.registerContext({
		id = 'oliann:clothes',
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
				title = 'Mcdo vetement',
				description = 'Vetement de travail',
				onSelect = function(args)
					local playerPed = PlayerPedId()
					setUniform('mcdo_wear', playerPed)
				end,
			},
		},
	})
	lib.showContext('oliann:clothes')
end)


local reward = math.random(Config.Reward.Min, Config.Reward.Max)
local times = 3

RegisterNetEvent('mcdo:cookmenu')
AddEventHandler('mcdo:cookmenu', function()
	lib.registerContext({
		id = 'mcdo:cookmenu',
		title = 'Actions Cuisson',
		onExit = function()
		end,
		options = {
			{
				title = 'Cuisson 1',
				description = 'Faire un hamburger',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, times, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[Mcdo] You Failed.')
							-- TriggerServerEvent('oliann_mcdo:remove', 'item', 1, 'fish')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_mcdo:add', 'item', 3, 'cheese')
					ESX.ShowNotification('[Mcdo] Success.')
				end,
			},
			{
				title = 'Cuisson 2',
				description = 'Faire des frites',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, times, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[Mcdo] You Failed.')
						   --  TriggerServerEvent('oliann_mcdo:remove', 'item', 1, 'pmeat')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_mcdo:add', 'item', 3, 'fries')
				--	TriggerServerEvent('oliann_mcdo:remove', 'item', 1, 'potato')
					ESX.ShowNotification('[Mcdo] Success.')
				end,
			},
			{
				title = 'Cuisson 3',
				description = 'Faire un hotdog',
				onSelect = function(args)
					loadDict("anim@amb@business@coc@coc_unpack_cut@")
					TaskPlayAnim(PlayerPedId(), "anim@amb@business@coc@coc_unpack_cut@", "fullcut_cycle_v6_cokecutter",  1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, times, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(7500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('[Mcdo] You Failed.')
							-- TriggerServerEvent('oliann_mcdo:remove', 'item', 1, 'potato')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasksImmediately(PlayerPedId())
					TriggerServerEvent('oliann_mcdo:add', 'item', 3, 'hotdog_sandwich')
				--	TriggerServerEvent('oliann_mcdo:remove', 'item', 1, 'potato')
					ESX.ShowNotification('[Mcdo] Success.')
				end,
			},
		},
	})
	lib.showContext('mcdo:cookmenu')
end)


RegisterNetEvent('mcdo:drinks')
AddEventHandler('mcdo:drinks', function()
	lib.registerContext({
		id = 'mcdo:drinks',
		title = 'Actions Boisson',
		onExit = function()
		end,
		options = {
			{
				title = 'Boisson 1',
				description = 'Faire un cocacola',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(3500, math.random(5, 7))
						if finished <= 0 then
							 ESX.ShowNotification('You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_mcdo:add', 'item', 3, 'cola')
					ESX.ShowNotification('[Mcdo] Success.')
				   -- TriggerServerEvent('oliann_mcdo:add', 'money', reward)
					TriggerEvent('Mcdo:coke')
				end,
			},
			{
				title = 'Boisson 2',
				description = 'Faire une bouteille d\'eau',
				onSelect = function(args)
					loadDict("anim@mp_player_intupperspray_champagne")
					TaskPlayAnim(PlayerPedId(), "anim@mp_player_intupperspray_champagne", "idle_a", 1.0, -1.0, -1, 49, 0, false, false, false)
					for i = 1, 2, 1 do
						local finished = exports["oliann_skillbar"]:taskBar(3500, math.random(5, 7))
						if finished <= 0 then
							ESX.ShowNotification('[Mcdo] You Failed.')
							 ClearPedTasksImmediately(PlayerPedId())
							 return
						end
					end
					ClearPedTasks(PlayerPedId())
					TriggerServerEvent('oliann_mcdo:add', 'item', 3, 'water')
					ESX.ShowNotification('[Mcdo] Success.')
					--TriggerServerEvent('oliann_mcdo:add', 'money', reward)
					TriggerEvent('Mcdo:coke')
				end,
			},
		},
	})
	lib.showContext('mcdo:drinks')
end)

RegisterNetEvent('mcdo:orderstash')
AddEventHandler('mcdo:orderstash', function()
	OpenOrderMcdo()
end)

function OpenOrderMcdo()
	exports.ox_inventory:openInventory('stash', {id='mcdoOrderStash', owner= false})
end

RegisterNetEvent('mcdo:stash')
AddEventHandler('mcdo:stash', function()
	OpenMcdoStash()
end)

function OpenBossMcdoStash()

	exports.ox_inventory:openInventory('stash', {id='McdoBossStash', owner= false})
end

function OpenMcdoStash()
	exports.ox_inventory:openInventory('stash', {id='McdoStash', owner= false, job = mcdo})
end

loadDict = function(dict)
    while not HasAnimDictLoaded(dict) do Wait(0) RequestAnimDict(dict) end
end

Citizen.CreateThread(function()

    local blipMarker = Config.Blips.Mcdo
    local blipCoord = AddBlipForCoord(blipMarker.Pos.x, blipMarker.Pos.y, blipMarker.Pos.z)

    SetBlipSprite (blipCoord, blipMarker.Sprite)
    SetBlipDisplay(blipCoord, blipMarker.Display)
    SetBlipScale  (blipCoord, blipMarker.Scale)
    SetBlipColour (blipCoord, blipMarker.Colour)
    SetBlipAsShortRange(blipCoord, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("McDonald's")
    EndTextCommandSetBlipName(blipCoord)


end)