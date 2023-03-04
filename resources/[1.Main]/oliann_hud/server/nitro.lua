nitro = {}

if Config.EnableNitro then

    Citizen.CreateThread(function()
        while frameworkObject == nil do
            Citizen.Wait(0)
        end
    
        if Config.Framework == "esx" then
            frameworkObject.RegisterUsableItem(Config.NitroItem, function(source)
                TriggerClientEvent('codem-blvckhudv2:SetupNitro', source)
            end)
        else
            frameworkObject.Functions.CreateUseableItem(Config.NitroItem, function(source)
                TriggerClientEvent('codem-blvckhudv2:SetupNitro', source)
            end)
        end
    end)
    
    
    function GetNitroData()
        local json_data = LoadResourceFile(GetCurrentResourceName(),  './nitro.json')
        if(json_data == '')then
            json_data = {}
        else
            json_data = json.decode(json_data)
        end
        return json_data
    end
    
    function SaveToNitroData(data)
        SaveResourceFile(GetCurrentResourceName(),'nitro.json', json.encode(data), -1)
    end
    
    Citizen.CreateThread(function()
        Citizen.Wait(100)
        nitro = GetNitroData()
    
    end)
    RegisterServerEvent('codem-blvckhudv2:InstallNitro')
    AddEventHandler('codem-blvckhudv2:InstallNitro', function(plate)
        local src = source
        if plate then
            nitro[plate] = 100
            SaveToNitroData(nitro)
            TriggerClientEvent('codem-blvckhudv2:UpdateNitroData', -1, nitro)
        end
    end)
    
    RegisterServerEvent('codem-blvckhudv2:UpdateNitro')
    AddEventHandler('codem-blvckhudv2:UpdateNitro', function(plate, val)
        local src = source
        if plate then
            if nitro[plate] then
                nitro[plate] = val
                SaveToNitroData(nitro)
                TriggerClientEvent('codem-blvckhudv2:UpdateNitroData', -1, nitro)
            end
        end
    end)
end
