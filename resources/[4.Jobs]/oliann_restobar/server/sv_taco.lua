ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'tacoshop', 'tacoshop', 'society_taco', 'society_taco', 'society_taco', {type = 'public'})

--START OF TACO--
local tacoemployeestash = {
    id = 'TacoEmployeeshop',
    label = 'Taco Employee Stash',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

local tacoorderstash = {
    id = 'TacoOrderStash',
    label = 'Order Stash',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(tacoemployeestash.id, tacoemployeestash.label, tacoemployeestash.slots, tacoemployeestash.weight, tacoemployeestash.owner)
		exports.ox_inventory:RegisterStash(tacoorderstash.id, tacoorderstash.label, tacoorderstash.slots, tacoorderstash.weight, tacoorderstash.owner)
    end
end)

RegisterServerEvent('oliann_tacos:add')
AddEventHandler('oliann_tacos:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('oliann_notifications:showNotification', source, 'You recieved $'..amount, 'warn', 5000)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)