ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'burgershot', 'burgershot', 'society_burger', 'society_burger', 'society_burger', {type = 'public'})

--START OF BURGER--
local employeestash = {
    id = 'Burgershot',
    label = 'Coffre Employer',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

local borderstash = {
    id = 'BurgerOrderStash',
    label = 'Coffre',
    slots = 90,
    weight = 2000000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(employeestash.id, employeestash.label, employeestash.slots, employeestash.weight, employeestash.owner)
		exports.ox_inventory:RegisterStash(borderstash.id, borderstash.label, borderstash.slots, borderstash.weight, borderstash.owner)
    end
end)


RegisterServerEvent('oliann_burger:add')
AddEventHandler('oliann_burger:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', source, 'You recieved $'..amount, 'warn', 5000)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)
