ESX                = nil

ESX = exports['es_extended']:getSharedObject()

RegisterCommand("jail", function(src, args, raw)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = args[1]
		local jailTime = tonumber(args[2])
		local jailReason = args[3]

		if GetPlayerName(jailPlayer) ~= nil then

			if jailTime ~= nil then
				JailPlayer(jailPlayer, jailTime)

				TriggerClientEvent("esx:showNotification", src, GetPlayerName(jailPlayer) .. " Prison pour " .. jailTime .. " minutes!")
				
				if args[3] ~= nil then
					GetRPName(jailPlayer, function(Firstname, Lastname)
						TriggerClientEvent('chat:addMessage', -1, { args = { "JUDGE",  Firstname .. " " .. Lastname .. " est en prison pour: " .. args[3] }, color = { 249, 166, 0 } })
					end)
				end
			else
				TriggerClientEvent("esx:showNotification", src, "Ceci est invalide!")
			end
		else
			TriggerClientEvent("esx:showNotification", src, "Ce ID est invalide!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Tu n'est pas policier!")
	end
end)

RegisterCommand("unjail", function(src, args)

	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then

		local jailPlayer = args[1]

		if GetPlayerName(jailPlayer) ~= nil then
			UnJail(jailPlayer)
		else
			TriggerClientEvent("esx:showNotification", src, "Ce ID est pas en ligne!")
		end
	else
		TriggerClientEvent("esx:showNotification", src, "Tu est pas un policier!")
	end
end)

RegisterCommand("unjailall", function(src, args, raw)
	local xPlayer = ESX.GetPlayerFromId(src)

	if xPlayer["job"]["name"] == "police" then
		TriggerEvent("esx-qalle-jail:breakout")
		TriggerClientEvent('esx:showNotification', src, 'Sortir prison tous!')
	else
		TriggerClientEvent('esx:showNotification', src, 'Tu n\'est pas un policier!')
	end
end)

RegisterServerEvent("esx-qalle-jail:jailPlayer")
AddEventHandler("esx-qalle-jail:jailPlayer", function(targetSrc, jailTime, jailReason)
	local src = source
	local targetSrc = tonumber(targetSrc)
	
	JailPlayer(targetSrc, jailTime)

	GetRPName(targetSrc, function(Firstname, Lastname)
		TriggerClientEvent('chat:addMessage', -1, { args = { "JUDGE",  Firstname .. " " .. Lastname .. " est maintenant en prison pour la raison: " .. jailReason }, color = { 249, 166, 0 } })
	end)
	TriggerClientEvent("esx:showNotification", src, GetPlayerName(targetSrc) .. " En prison pour " .. jailTime .. " minutes!")
end)

RegisterServerEvent("esx-qalle-jail:unJailPlayer")
AddEventHandler("esx-qalle-jail:unJailPlayer", function(targetIdentifier)
	local src = source
	local xPlayer = ESX.GetPlayerFromIdentifier(targetIdentifier)

	if xPlayer ~= nil then
		UnJail(xPlayer.source)
	else
		MySQL.Async.execute(
			"UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
			{
				['@identifier'] = targetIdentifier,
				['@newJailTime'] = 0
			}
		)
	end

	TriggerClientEvent("esx:showNotification", src, xPlayer.name .. " De-Prison!")
end)

RegisterServerEvent("esx-qalle-jail:updateJailTime")
AddEventHandler("esx-qalle-jail:updateJailTime", function(newJailTime)
	local src = source

	EditJailTime(src, newJailTime)
end)

RegisterServerEvent("esx-qalle-jail:breakout")
AddEventHandler("esx-qalle-jail:breakout", function(newJailTime)
	local xPlayers	= ESX.GetPlayers()

	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		breakout(xPlayers[i])
		EditJailTime(xPlayers[i], 0)
	end
end)

RegisterServerEvent("esx-qalle-jail:prisonWorkReward")
AddEventHandler("esx-qalle-jail:prisonWorkReward", function()
	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)

	xPlayer.addMoney(math.random(13, 21))

	TriggerClientEvent("esx:showNotification", src, "Merci, Tu a quelque argent pour du manger!")
end)

function JailPlayer(jailPlayer, jailTime)
	GetRPName(jailPlayer, function(Firstname, Lastname)
		local name = Firstname.. ' ' ..Lastname
		local date = os.date("%Y-%m-%d")
		TriggerClientEvent("esx-qalle-jail:jailPlayer", jailPlayer, jailTime, name, date)
	end)


	EditJailTime(jailPlayer, jailTime)
end

function UnJail(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:unJailPlayer", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function breakout(jailPlayer)
	TriggerClientEvent("esx-qalle-jail:jailbreak", jailPlayer)

	EditJailTime(jailPlayer, 0)
end

function EditJailTime(source, jailTime)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier
	xPlayer.setJob('unemployed', 0)

	MySQL.Async.execute(
       "UPDATE users SET jail = @newJailTime WHERE identifier = @identifier",
        {
			['@identifier'] = Identifier,
			['@newJailTime'] = tonumber(jailTime)
		}
	)
end

function GetRPName(playerId, data)
	local Identifier = ESX.GetPlayerFromId(playerId).identifier

	MySQL.Async.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		data(result[1].firstname, result[1].lastname)

	end)
end

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailedPlayers", function(source, cb)
	
	local jailedPersons = {}

	MySQL.Async.fetchAll("SELECT firstname, lastname, jail, identifier FROM users WHERE jail > @jail", { ["@jail"] = 0 }, function(result)

		for i = 1, #result, 1 do
			table.insert(jailedPersons, { name = result[i].firstname .. " " .. result[i].lastname, jailTime = result[i].jail, identifier = result[i].identifier })
		end

		cb(jailedPersons)
	end)
end)

ESX.RegisterServerCallback("esx-qalle-jail:retrieveJailTime", function(source, cb)

	local src = source

	local xPlayer = ESX.GetPlayerFromId(src)
	local Identifier = xPlayer.identifier


	MySQL.Async.fetchAll("SELECT jail FROM users WHERE identifier = @identifier", { ["@identifier"] = Identifier }, function(result)

		local JailTime = tonumber(result[1].jail)

		if JailTime > 0 then

			cb(true, JailTime)
		else
			cb(false, 0)
		end

	end)
end)

RegisterServerEvent("jail:saveItems")
AddEventHandler("jail:saveItems", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)
    local data = { inventory = {}, loadout = {} }

    for k,v in pairs(xPlayer.inventory) do
        if v.count > 0 then
            xPlayer.setInventoryItem(v.name, 0)
            table.insert(data.inventory, { name = v.name, amount = v.count })
        end
    end

    for k,v in pairs(xPlayer.loadout) do
        xPlayer.removeWeapon(v.name)
        table.insert(data.loadout, v.name)
    end

    MySQL.Async.execute("UPDATE `users` SET `jailitems` = '" .. json.encode(data) .. "' WHERE `identifier` = '" .. xPlayer["identifier"] .. "'")
end)

RegisterServerEvent("jail:reclaimPossessions")
AddEventHandler("jail:reclaimPossessions", function()
    local src = source
    local xPlayer = ESX.GetPlayerFromId(src)

    MySQL.Async.fetchAll("SELECT `jailitems` FROM `users` WHERE identifier = '" .. xPlayer["identifier"] .. "'", {}, function(result)
        if result[1] and result[1].jailitems then
            local jailitems = json.decode(result[1].jailitems)

            for k,v in pairs(jailitems.inventory) do
                local oldItem = xPlayer.getInventoryItem(v.name)
                if oldItem and oldItem["count"] > 0 then
                    xPlayer.removeInventoryItem(oldItem["name"], oldItem["count"])
                end

                xPlayer.addInventoryItem(v.name, v.amount)
            end
        
            for k,v in pairs(jailitems.loadout) do
                xPlayer.addWeapon(v)
            end

            MySQL.Async.execute("UPDATE `users` SET `jailitems` = '" .. json.encode({}) .. "' WHERE `identifier` = '" .. xPlayer["identifier"] .. "'") 
        end
    end)
end)

RegisterServerEvent("jail:giveMisc")
AddEventHandler("jail:giveMisc", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local chance = math.random(1, 50)
	print(chance)
	print(chance)
	print(chance)
	
	if chance <= 10 then
		xPlayer.addInventoryItem("phone", 1)
        TriggerClientEvent('esx:showNotification', src, 'Tu a un telephone!')
	elseif chance <= 20 then
		xPlayer.addInventoryItem("WEAPON_BAT")
		TriggerClientEvent('esx:showNotification', src, 'Tu a un bat!')
	elseif chance <= 30 then
		xPlayer.addInventoryItem("WEAPON_SWITCHBLADE")
		TriggerClientEvent('esx:showNotification', src, 'Tu a un switchblade!')
	elseif chance <= 40 then
		xPlayer.addInventoryItem("WEAPON_KNIFE")
		TriggerClientEvent('esx:showNotification', src, 'Tu a un couteau!')
	end
end)

RegisterServerEvent("jail:giveFood")
AddEventHandler("jail:giveFood", function()
	local src = source
	local xPlayer = ESX.GetPlayerFromId(src)
	local chance = math.random(1, 50)

	if chance <= 10 then
		xPlayer.addInventoryItem("bread", 1)
		TriggerClientEvent('esx:showNotification', src, 'Tu a un pain!')
	elseif chance <= 30 then
		xPlayer.addInventoryItem("water", 1)
		TriggerClientEvent('esx:showNotification', src, 'Tu a de l\'eau!')
	end
end)