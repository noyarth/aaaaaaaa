local Vehicles

RegisterServerEvent('esx_lscustom:buyMod')
AddEventHandler('esx_lscustom:buyMod', function(price)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	price = tonumber(price)

	if Config.IsMechanicJobOnly then
		local societyAccount

		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_mechanic', function(account)
			societyAccount = account
		end)

		if price < societyAccount.money then
			TriggerClientEvent('esx_lscustom:installMod', source)
			UserAvatar = ''
		    mensahe = '**'..xPlayer.name..'** has install a mod, Mod Price : **' ..price.. '**$'
		    PerformHttpRequest('https://discord.com/api/webhooks/1007861447696596992/MLyxPjza3TFFv-shKhUtNWGveUXVywWLobJ2CiwLXwE4Q4F4wsrnNvW17m5l6eurTPYB', 
		    function(err, text, headers) end, 'POST', json.encode({username = 'LSCUSTOM | OLIANN LOGS' ,content = mensahe,  avatar_url = UserAvatar}), { ['Content-Type'] = 'application/json' })
			TriggerClientEvent('esx:showNotification', source, _U('purchased'))
			societyAccount.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('not_enough_money'))
		end
	else
		if price < xPlayer.getMoney() then
			TriggerClientEvent('esx_lscustom:installMod', source)
			UserAvatar = ''
		    mensahe = '**'..xPlayer.name..'** has install a mod, Mod Price : **' ..price.. '**$'
		    PerformHttpRequest('https://discord.com/api/webhooks/1007861447696596992/MLyxPjza3TFFv-shKhUtNWGveUXVywWLobJ2CiwLXwE4Q4F4wsrnNvW17m5l6eurTPYB', 
		    function(err, text, headers) end, 'POST', json.encode({username = 'LSCUSTOM | JOSHUA LOGS' ,content = mensahe,  avatar_url = UserAvatar}), { ['Content-Type'] = 'application/json' })
			TriggerClientEvent('esx:showNotification', source, _U('purchased'))
			xPlayer.removeMoney(price)
		else
			TriggerClientEvent('esx_lscustom:cancelInstallMod', source)
			TriggerClientEvent('esx:showNotification', source, _U('not_enough_money'))
		end
	end
end)

RegisterServerEvent('esx_lscustom:refreshOwnedVehicle')
AddEventHandler('esx_lscustom:refreshOwnedVehicle', function(vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.single('SELECT vehicle FROM owned_vehicles WHERE plate = ?', {vehicleProps.plate},
	function(result)
		if result then
			local vehicle = json.decode(result.vehicle)

			if vehicleProps.model == vehicle.model then
				MySQL.update('UPDATE owned_vehicles SET vehicle = ? WHERE plate = ?', {json.encode(vehicleProps), vehicleProps.plate})
			else
				print(('esx_lscustom: %s attempted to upgrade vehicle with mismatching vehicle model!'):format(xPlayer.identifier))
			end
		end
	end)
end)

ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		MySQL.Async.fetchAll('SELECT * FROM vehicles', {}, function(result)
			local vehicles = {}

			for i=1, #result, 1 do
				table.insert(vehicles, {
					model = result[i].model,
					price = result[i].price
				})
			end

			Vehicles = vehicles
			cb(Vehicles)
		end)
	else
		cb(Vehicles)
	end
end)
--[[
ESX.RegisterServerCallback('esx_lscustom:getVehiclesPrices', function(source, cb)
	if not Vehicles then
		Vehicles = MySQL.query.await('SELECT model, price FROM vehicles')
	end
	cb(Vehicles)
end)--]]