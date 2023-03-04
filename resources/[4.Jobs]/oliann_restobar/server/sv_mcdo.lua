ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'mcdo', 'mcdo', 'society_mcdo', 'society_mcdo', 'society_mcdo', {type = 'public'})

--START OF BURGER--
local mcdostash = {
    id = 'McdoStash',
    label = 'Coffre Employer',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

local mcdoorderstash = {
    id = 'mcdoOrderStash',
    label = 'Menu Commandes',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

local mcdoboss = {
    id = 'McdoBossStash',
    label = 'Coffre Patron',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(mcdostash.id, mcdostash.label, mcdostash.slots, mcdostash.weight, mcdostash.owner)
		exports.ox_inventory:RegisterStash(mcdoorderstash.id, mcdoorderstash.label, mcdoorderstash.slots, mcdoorderstash.weight, mcdoorderstash.owner)
        exports.ox_inventory:RegisterStash(mcdoboss.id, mcdoboss.label, mcdoboss.slots, mcdoboss.weight, mcdoboss.owner)
    end
end)


RegisterServerEvent('oliann_mcdo:add')
AddEventHandler('oliann_mcdo:add', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)
	if type == 'money' then
		xPlayer.addMoney(amount)
		TriggerClientEvent('esx:showNotification', source, 'You recieved $'..amount, 'warn', 5000)
	elseif type == 'item' then
		xPlayer.addInventoryItem(name, amount)
	end
end)
RegisterServerEvent('oliann_mcdo:remove')
AddEventHandler('oliann_mcdo:remove', function(type, amount, name)
	local xPlayer  = ESX.GetPlayerFromId(source)

	if type == 'money' then
		xPlayer.removeMoney(amount)
	elseif type == 'item' then
		xPlayer.removeInventoryItem(name, amount)
	end
end)