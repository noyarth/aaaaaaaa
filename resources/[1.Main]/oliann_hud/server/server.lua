frameworkObject = nil

Citizen.CreateThread(function()
    frameworkObject = GetFrameworkObject()
    if Config.Framework == "esx" then
        frameworkObject.RegisterServerCallback("codem-blvckhudv2:GetMoney", function(source, cb, moneytype)
            local src = source
            local Player = frameworkObject.GetPlayerFromId(src)
            if moneytype == "cash" then
                cb(Player.getMoney())
            else
                cb(Player.getAccount('bank').money)
            end
        end)
    end
end)
preferences = {}

function GetPreferencesData()
    local json_data = LoadResourceFile(GetCurrentResourceName(),  './preferences.json')
    if(json_data == '')then
        json_data = {}
    else
        json_data = json.decode(json_data)
    end
    return json_data
end

function SaveToPreferencesData(data)
    SaveResourceFile(GetCurrentResourceName(),'preferences.json', json.encode(data), -1)
end

RegisterServerEvent('codem-blvckhudv2:RemoveItem')
AddEventHandler('codem-blvckhudv2:RemoveItem', function(item, amount)
    local src = source
    local player = Config.Framework == 'esx' and frameworkObject.GetPlayerFromId(src) or frameworkObject.Functions.GetPlayer(src)
    if Config.Framework == "esx" then
        player.removeInventoryItem(item, amount)
    else
        player.Functions.RemoveItem(item, amount)
    end
end)

Citizen.CreateThread(function()
    while frameworkObject == nil do
        Citizen.Wait(0)
    end
    Citizen.Wait(2000)
    preferences = GetPreferencesData()
    for _,v in pairs(GetPlayers()) do
        local player = nil
        if Config.Framework == 'esx' then
            player = frameworkObject.GetPlayerFromId(tonumber(v))
        else
            player = frameworkObject.Functions.GetPlayer(tonumber(v))
        end
        if player ~= nil then
            local identifier = GetIdentifier(v)
            CheckPreferencesExist(identifier)
            if Config.UseStress then
                if stressData[identifier] == nil then
                    stressData[identifier] = 0
                end
                TriggerClientEvent('hud:client:UpdateStress', v, stressData[identifier])
            end
            TriggerClientEvent('codem-blvckhudv2:client:UpdateSettings', v,  preferences[identifier])
            TriggerClientEvent('codem-blackhudv2:SetForceHide', v, false)
            TriggerClientEvent('codem-blvckhudv2:UpdateNitroData', v, nitro)
            TriggerClientEvent('codem-blvckhudv2:Loaded', v)
        end


    end
    SaveToPreferencesData(preferences)
    SaveToStressData(stressData)

end)

function CheckPreferencesExist(identifier)
    if preferences[identifier] == nil then
        preferences[identifier] = {
            hud = Config.DefaultHud,
            hide = false,
            speedtype = Config.DefaultSpeedUnit,
            maptype = Config.DefaultMap,
            showCompass = true,
            speedometerSize = Config.DefaultSpeedometerSize,
            refreshRate = Config.DefaultRefreshRate,
            showHideBox = true,
            positionsData = {
            },
            hideBoxData = {
                health= 100,
                armor= 100,
                water =  100,
                stress= 100,
                hunger= 100,
                stamina= 100,
            },
        }
    else
        local data = preferences[identifier]
        if data.hud == nil then
            data.hud = Config.DefaultHud
        end
        if data.positionsData == nil then
            data.positionsData = {}
        end
        if data.hideBoxData == nil then
            data.hideBoxData = {
                health= 100,
                armor= 100,
                water =  100,
                stress= 100,
                hunger= 100,
                stamina= 100,
            }
        else
            if data.hideBoxData.health == nil then
                data.hideBoxData.health = 100
            end
            if data.hideBoxData.armor == nil then
                data.hideBoxData.armor = 100
            end
            if data.hideBoxData.water == nil then
                data.hideBoxData.water = 100
            end
            if data.hideBoxData.stress == nil then
                data.hideBoxData.stress = 100
            end
            if data.hideBoxData.hunger == nil then
                data.hideBoxData.hunger = 100
            end
            if data.hideBoxData.stamina == nil then
                data.hideBoxData.stamina = 100
            end
        end
        if data.showHideBox == nil then
            data.showHideBox = true
        end
        if data.hide == nil then
            data.hide = false
        end
        if data.refreshRate == nil then
            data.refreshRate = Config.DefaultRefreshRate
        end
        if data.speedtype == nil then
            data.speedtype = Config.DefaultSpeedUnit
        end
        if data.maptype == nil then
            data.maptype = Config.DefaultMap
        end
        if data.showCompass == nil then
            data.showCompass = true
        end
        if data.speedometerSize == nil then
            data.speedometerSize = Config.DefaultSpeedometerSize
        end
    end
end
if Config.EnableCashAndBankCommands then
    RegisterCommand(Config.CashCommand, function(source)
        if Config.Framework == "esx" then
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))
            local cashamount = xPlayer.getMoney()
            TriggerClientEvent('codemblvckhudv2:ShowAccounts', source, 'cash', cashamount)
        else
            local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
            local cashamount = Player.PlayerData.money.cash
    
            TriggerClientEvent('codemblvckhudv2:ShowAccounts', source, 'cash', cashamount)
    
        end
    end)
    RegisterCommand(Config.BankCommand, function(source)
        if Config.Framework == "esx" then
            local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))
            local bankamount = xPlayer.getAccount('bank')
            if bankamount then
                TriggerClientEvent('codemblvckhudv2:ShowAccounts', source, 'bank', bankamount.money)
            end
        else
            local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
            local bankamount = Player.PlayerData.money.bank
            TriggerClientEvent('codemblvckhudv2:ShowAccounts', source, 'bank', bankamount)
    
        end
    end)
    
end

RegisterServerEvent('seatbelt:server:PlaySound')
AddEventHandler('seatbelt:server:PlaySound', function(action, passengers)
    pass = json.decode(passengers)
    for _, ped in ipairs(pass) do
        local vol = (source == ped and 0.25 or 0.20)
        TriggerClientEvent('seatbelt:client:PlaySound', ped, action, vol)
    end
end)

function GetIdentifier(source)
    if Config.Framework == "esx" then
        local xPlayer = frameworkObject.GetPlayerFromId(tonumber(source))
        if xPlayer then
            return xPlayer.getIdentifier()
        else
            return "0"
        end
    else
        local Player = frameworkObject.Functions.GetPlayer(tonumber(source))
        if Player then
            return Player.PlayerData.citizenid
        else
            return "0"
        end
    end
end


RegisterNetEvent('codem-blvckhudv2:UpdateData')
AddEventHandler("codem-blvckhudv2:UpdateData", function(settingstype, val)
    local src = source
    local identifier = GetIdentifier(src)
    CheckPreferencesExist(identifier)
    if preferences[identifier][settingstype] ~= nil then
        preferences[identifier][settingstype] = val
        TriggerClientEvent('codem-blvckhudv2:client:UpdateSettings', src, preferences[identifier])
        SaveToPreferencesData(preferences)

    end
end)