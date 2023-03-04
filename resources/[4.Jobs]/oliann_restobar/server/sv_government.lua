ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

TriggerEvent('esx_society:registerSociety', 'government', 'government', 'society_government', 'society_government', 'society_government', {type = 'public'})

--START OF BURGER--
local governmentstash = {
    id = 'Government',
    label = 'Gouvernement Oliann',
    slots = 90,
    weight = 100000,
    owner = 'steam:'
}

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        Wait(0)
        exports.ox_inventory:RegisterStash(governmentstash.id, governmentstash.label, governmentstash.slots, governmentstash.weight, governmentstash.owner)
    end
end)
