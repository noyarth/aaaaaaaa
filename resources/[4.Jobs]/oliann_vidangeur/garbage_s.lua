ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('oliann_garbage:pay')
AddEventHandler('oliann_garbage:pay', function(jobStatus)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if jobStatus then
        if xPlayer ~= nil then
            local randomMoney = math.random(110,640)
            xPlayer.addMoney(randomMoney)
        end
    else
        print("Probably a cheater: ",xPlayer.getName())
    end
end)


RegisterNetEvent('oliann_garbage:reward')
AddEventHandler('oliann_garbage:reward', function(item,rewardStatus)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if rewardStatus then
        if xPlayer ~= nil then
            			
            if xPlayer.canCarryItem(item , 1) then

                xPlayer.addInventoryItem(item , math.random(1, 2))
                
                TriggerClientEvent('esx:showNotification', source, 'Tu a trouver ' ..item)

            else
                TriggerClientEvent('esx:showNotification', source, 'Ton sac a ete jeter!')
            end


        end
    else
        print("Surement un cheater: ",xPlayer.getName())
    end
end)