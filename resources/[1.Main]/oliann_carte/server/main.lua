ESX = nil

ESX = exports['es_extended']:getSharedObject() -- Si vous utilisez esx legacy la nouvelle version


RegisterServerEvent('esx:oliann')
AddEventHandler('esx:oliann', function(item, price, amount)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)
	
TriggerEvent('esx_addonaccount:getSharedAccount', 'society_ambulance', function(account)
		account.addMoney(price)
		end)
		if xPlayer.getMoney() >= price then
			
			xPlayer.removeMoney(price)
			xPlayer.addInventoryItem(item, amount)
			TriggerClientEvent('esx:showNotification', _source, "Merci de avoir acheter ici" )
		else
			TriggerClientEvent('esx:showNotification', _source, "Tu as pas asser d'argent sur toi")

		end
end)
