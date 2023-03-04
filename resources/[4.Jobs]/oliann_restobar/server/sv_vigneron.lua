ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'vigne', 'vigne', 'society_vigne', 'society_vigne', 'society_vigne', {type = 'public'})

local employeestash = {
    id = 'Vigneron',
    label = 'Coffre Employer',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(employeestash.id, employeestash.label, employeestash.slots, employeestash.weight, employeestash.owner)
    end
end)


RegisterServerEvent('oliann_vigneron:add')
AddEventHandler('oliann_vigneron:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', source, 'Tu a recu $'..amount)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)
