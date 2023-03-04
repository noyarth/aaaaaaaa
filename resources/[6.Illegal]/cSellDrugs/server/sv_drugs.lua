ESX = nil
TriggerEvent('esx:getSharedObject', function(a)
	ESX = a 
end)

RegisterServerEvent("cDrugs:SellDrugs")
AddEventHandler("cDrugs:SellDrugs", function(item, label, money, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    if item ~= nil then 
        xPlayer.removeInventoryItem(item, count)
        xPlayer.addMoney(money)

        TriggerClientEvent("esx:showNotification", source, "Vous avez vendu ~b~x("..count..") "..label.."~s~ pour ~g~"..money.."$~s~.")
    end
end)

ESX.RegisterServerCallback("cDrugs:getPlayerInventory", function(source, cb, target)
	local targetXPlayer = ESX.GetPlayerFromId(target)

	if targetXPlayer ~= nil then
		cb({inventory = targetXPlayer.inventory})
	else
		cb(nil)
	end
end)