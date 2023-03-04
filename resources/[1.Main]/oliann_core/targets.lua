ESX                           = nil

local PlayerData = {}

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('search:Player') ---- TODO Mettre progbar and notif
AddEventHandler('search:Player', function()
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    if closestPlayer then
        if closestPlayer ~= -1 and closestDistance <= 1.0 then
            exports.ox_inventory:openInventory('player', GetPlayerServerId(closestPlayer))
        end
    end
end)

----- Rich Presence
Citizen.CreateThread(function()
	while true do
	    local player = GetPlayerPed(-1)
		--SetDiscordAppId(--IDDDDDDDDD)
		
		SetRichPresence("Joueur Connecter: [" .. #GetActivePlayers() .. "/64] | "..GetPlayerName(PlayerId()))
		SetDiscordRichPresenceAsset('')
        SetDiscordRichPresenceAssetText(' | https://discord.gg/olianndev')
        SetDiscordRichPresenceAssetSmall('')
        SetDiscordRichPresenceAssetSmallText("Health: "..(GetEntityHealth(player)-100)) 
		SetDiscordRichPresenceAction(0, "", "https://discord.gg/olianndev")

        -- It updates every minute just in case.
		Citizen.Wait(60000)
	end
end)