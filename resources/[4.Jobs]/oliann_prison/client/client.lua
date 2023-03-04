local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil

PlayerData = {}

local jailTime = 0
local onSearch = false

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent("esx:playerLoaded")
AddEventHandler("esx:playerLoaded", function(newData)
	PlayerData = newData

	Citizen.Wait(25000)

	ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailTime", function(inJail, newJailTime)
		if inJail then

			jailTime = newJailTime

			JailLogin()
		end
	end)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent("esx-qalle-jail:openJailMenu")
AddEventHandler("esx-qalle-jail:openJailMenu", function()
	OpenJailMenu()
end)

RegisterNetEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(newJailTime, name, date)
	jailTime = newJailTime
	TriggerServerEvent("jail:saveItems")
	RemoveAllPedWeapons(PlayerPedId())
	Cutscene(jailTime, name, date)
end)

RegisterNetEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function()
	jailTime = 0

	UnJail()
end)

RegisterNetEvent("esx-qalle-jail:jailbreak")
AddEventHandler("esx-qalle-jail:jailbreak", function()
	jailTime = 0
end)

function JailLogin()
	--local JailPosition = Config.JailPositions["Cell"]
	--SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	--ESX.ShowNotification("Last time you went to sleep you were jailed, because of that you are now put back!")

	InJail()
end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Boiling Broke"])

	ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
		TriggerEvent('skinchanger:loadSkin', skin)
	end)

	ESX.ShowNotification("Tu est libérer reste calme!")
end

function ResetPackages()

	for k, v in pairs(Config.PrisonWork["Packages"]) do
		v.state = true
	end

end

function ResetWelding()

	for k, v in pairs(Config.PrisonWork["Welding"]) do
		v.state = true
	end

end



RegisterCommand("jailtime", function(src, args, raw)
	ESX.ShowNotification('[SYSTEM] Tu a '..jailTime.. ' restant en mois.')
end)

function InJail()

	ResetPackages()
	ResetWelding()
	RemoveAllPedWeapons(PlayerPedId())
	--Jail Timer--

	Citizen.CreateThread(function()

		while jailTime > 0 do

			jailTime = jailTime - 1

			--ESX.ShowNotification("You have " .. jailTime .. " minutes left in jail!")
			TriggerEvent('chat:addMessage', {
		        template = "<div class='chat-message advert'><div class='chat-message-header'>[^1SYSTEM^0] You have ^3{0} ^0months left.</div></div>", 
		        args = { jailTime }
		    })

			TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)

			if jailTime == 0 then
				UnJail()

				TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
			end

			Citizen.Wait(60000)
		end

	end)
	
	---ANTI GLITCH
	Citizen.CreateThread(function()
		while jailTime > 0 do
			Citizen.Wait(1)

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)
			local PrisonDistance = GetDistanceBetweenCoords(PedCoords, 1713.30, 2520.62, 45.56, true)

			if PrisonDistance > 500 and jailTime > 0 then	
				local JailPosition = Config.JailPositions["Cell"]
				SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"])   	
				jailTime = jailTime + 50
				TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)		
				ESX.ShowNotification('[SYSTEM] Abuse pas les bugs, ou tu seras ban.')
			end
			Citizen.Wait(100)		
		end
	end)
	--Jail Timer--

	--Prison Work--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]
			local Welding = Config.PrisonWork["Welding"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Pack"

					if not v["state"] then
						PackageText = "Deja pris"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) and jailTime >= 3 then

							if v["state"] then
								PackPackage(posId)
							else							
								ESX.ShowNotification('[SYSTEM] Tu a deja pris cette boite.')
							end
						elseif IsControlJustPressed(0, 38) and jailTime <= 2 then
							ESX.ShowNotification('[SYSTEM] Tu a que quelque mois en cours, vous ne pouvez plus faire de travail en prison')
						end

					end

				end
			end

			for fixID, k in pairs(Welding) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, k["x"], k["y"], k["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local WeldingText = "Fix"

					if not k["state"] then
						WeldingText = "Deja Reparer"
					end

					--ESX.Game.Utils.DrawText3D(k, "[E] " .. WeldingText, 0.6)
					DrawText3D(k,  "[E] " .. WeldingText, 0.6)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) and jailTime >= 6 then

							if k["state"] then
								FixWirings(fixID)
							else
								ESX.ShowNotification('[SYSTEM] Tu a deja reparer ceci.')
							end

						elseif IsControlJustPressed(0, 38) and jailTime <= 5 then						
							ESX.ShowNotification('[SYSTEM] Tu a deja quelque mois restant, Vous ne pouvez plus travailler en prison')
						end

					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)

	--Misc--
	Citizen.CreateThread(function()
		while jailTime > 0 do
			Citizen.Wait(1)

			local playerPed = PlayerPedId()
			local closestMisc = nil
			local tooClose = false

			for k, v in pairs(Config.PrisonMisc) do
				local pedCoords = GetEntityCoords(playerPed)
				local dist = GetDistanceBetweenCoords(pedCoords, v.pos.x, v.pos.y, v.pos.z, 1)

				if dist <= 4.0 and not v.done then
					closestMisc = k

					if dist <= 2.0 then
						tooClose = true
					end
				end
			end


			if closestMisc ~= nil then
				if not onScreen then 
					Draw3DText(Config.PrisonMisc[closestMisc].pos.x, Config.PrisonMisc[closestMisc].pos.y, Config.PrisonMisc[closestMisc].pos.z, Config.PrisonMisc[closestMisc].text)

					if tooClose and IsControlJustReleased(0, 38) then

						if Config.PrisonMisc[closestMisc].func == 'searchFood' then
							SearchForFood()
						end

						if Config.PrisonMisc[closestMisc].func == 'searchRand' then
							SearchRandomItem(closestMisc)
						end

					end
				end
			else
				Citizen.Wait(2000)
			end
		end
	end)		
end


local lastSearchFood = 0

function SearchForFood()
	if ( GetGameTimer() - lastSearchFood ) < 30000 then 
		ESX.ShowNotification('[SYSTEM] SVP attendez avant de prendre d\'autre manger.')
		return
	end

	playAnim("amb@prop_human_bum_bin@base", "base", -1)
	local finished = exports["oliann_skillbar"]:taskBar(23500, math.random(5, 7))
	if finished <= 0 then
		ESX.ShowNotification('[SYSTEM] Fail')
		ClearPedTasksImmediately(PlayerPedId())
		return
	end 
									
	local finished = exports["oliann_skillbar"]:taskBar(1500, math.random(5, 7))
	if finished <= 0 then
		ESX.ShowNotification('[SYSTEM] Fail.')
		ClearPedTasksImmediately(PlayerPedId())
		return
	end 
	ClearPedTasksImmediately(PlayerPedId())
	TriggerServerEvent('jail:giveFood')
	lastSearchFood = GetGameTimer()

end

function SearchRandomItem(k)
	playAnim("amb@prop_human_bum_bin@base", "base", -1)
	local finished = exports["oliann_skillbar"]:taskBar(23500, math.random(5, 7))
	if finished <= 0 then
		ESX.ShowNotification('[SYSTEM] Fail.')
		ClearPedTasksImmediately(PlayerPedId())
		return
	end 
									
	local finished = exports["oliann_skillbar"]:taskBar(1500, math.random(5, 7))
	if finished <= 0 then
		ESX.ShowNotification('[SYSTEM] Fail.')
		ClearPedTasksImmediately(PlayerPedId())
		return
	end 
	ClearPedTasksImmediately(PlayerPedId())
	TriggerServerEvent('jail:giveMisc')
	Config.PrisonMisc[k].done = true

end

function playAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
    RemoveAnimDict(animDict)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			--ESX.ShowNotification("Canceled!")
			TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)
			--Packaging = false
		end

		if IsControlJustPressed(0, Keys['X']) then
			Packaging = false
			ClearPedTasksImmediately(PlayerPedId())
			ESX.ShowNotification('[SYSTEM] Canceller.')
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Boitier... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function FixWirings(fixingID)
	local Welding = Config.PrisonWork["Welding"][fixingID]


	TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_WELDING", 0, false)


	local Fixing = true
	local StartTime = GetGameTimer()
	local success = true

	for i = 1, 7, 1 do
	    local finished =  exports["oliann_skillbar"]:taskBar(25000, math.random(3, 5))
	    if finished <= 0 then
			ESX.ShowNotification('[SYSTEM] Failed.', 'normal', 7500)
	    	success = false
	    	ClearPedTasks(PlayerPedId())
	    	break
	    end  	
	end

	if success then
		local reducedTime = math.random(2,5)
		ClearPedTasks(PlayerPedId())
		jailTime = tonumber(jailTime) - reducedTime

		TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)
		ESX.ShowNotification("Ton temps a decendu de " .. reducedTime .. " minutes!")

		if jailTime <= 0 then
			UnJail()
			TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
		end

		Welding["state"] = false
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Quitter la boite", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false
					jailTime = tonumber(jailTime) - 1
					TriggerServerEvent("esx-qalle-jail:updateJailTime", jailTime)
					ESX.ShowNotification('[SYSTEM] Ton temps a decendu a ' .. jailTime .. ' mois')
				
					if jailTime <= 0 then
						UnJail()
						TriggerServerEvent("esx-qalle-jail:updateJailTime", 0)
					end	
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Prison Menu",
			align    = 'center',
			elements = {
				{ label = "Jail Closest Person", value = "jail_closest_player" },
				{ label = "Unjail Person", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Temps Prison (minutes)"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("Le temps doit etre en minutes!")
            	else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("Personne proche!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Prison Raison"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("Tu doit mettre quelque chose ici!")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("Personne proche!")
								else
								  	TriggerServerEvent("esx-qalle-jail:jailPlayer", GetPlayerServerId(closestPlayer), jailTime, reason)
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("Ton prison est vide!")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Prisonnier: " .. playerArray[i].name .. " | Temps prison: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Sortir prison joueur",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent("esx-qalle-jail:unJailPlayer", action)

					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

function GetJailTime()
	return jailTime
end

exports("GetJailTime", GetJailTime);

Citizen.CreateThread(function()
	while true do
		Wait(0)

		SetVehicleModelIsSuppressed(GetHashKey("pbus"), true) -- pbus
		SetVehicleModelIsSuppressed(GetHashKey("police"), true) -- police
		SetVehicleModelIsSuppressed(GetHashKey("police2"), true) -- police2
		SetVehicleModelIsSuppressed(GetHashKey("police3"), true) -- police3
		SetVehicleModelIsSuppressed(GetHashKey("police4"), true) -- police4
		SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)  -- blimp			
	end
end)

function DrawText3D(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)

    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function DrawText3D(coords, text, size)
    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

	SetTextScale(0.35, 0.35)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	local factor = (string.len(text)) / 370
	DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

function Draw3DText(x,y,z, text) -- some useful function, use it if you want!
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end

Citizen.CreateThread(function()
	while true do
		local playerCoords = GetEntityCoords(PlayerPedId())
        local waitCheck = #(playerCoords - vector3(Config.Locations["reclaim_items"]["x"], Config.Locations["reclaim_items"]["y"], Config.Locations["reclaim_items"]["z"]))
        if waitCheck < 3 then
            Draw3DText(Config.Locations["reclaim_items"]["x"], Config.Locations["reclaim_items"]["y"], Config.Locations["reclaim_items"]["z"]+1, '[E] Pour reprendre ta possesion.')
        end
        if waitCheck < 1.5 then
            if IsControlJustPressed(0,46) then
				TriggerServerEvent("jail:reclaimPossessions")
				ESX.ShowNotification('[SYSTEM] Tu a reclamer ta possesion')
                Wait(15000)
            end
        end
        waitCheck = (waitCheck < 5 and 1 or waitCheck)
        Wait(math.ceil(waitCheck))
    end
end)