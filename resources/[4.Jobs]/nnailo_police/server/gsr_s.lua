gsrData = {}
RegisterCommand("gsr", function(source, args, user)
    local Source = source
    local xPlayer = ESX.GetPlayerFromId(Source)
    local number = tonumber(args[1])
    if args[1] ~= nil then 
		if xPlayer.job.name == 'police' and type(number) == "number" then
        	CancelEvent()
        	local identifier = GetPlayerIdentifiers(number)[1]
        	if identifier ~= nil then
            	gsrcheck(source, identifier)
        	end
    	else
            TriggerClientEvent('esx:showNotification', Source, 'Tu doit etre un policier pour utiliser le test gsr!')
    	end
	else
        TriggerClientEvent('esx:showNotification', Source, 'Utilise correctement: /gsr (joueur id)')
	end
end, true)

AddEventHandler('esx:playerDropped', function(source)
    local Source = source
    local identifier = GetPlayerIdentifiers(Source)[1]
    if gsrData[identifier] ~= nil then
        gsrData[identifier] = nil
    end
end)

RegisterNetEvent("GSR:Remove")
AddEventHandler("GSR:Remove", function()
    local Source = source
    local identifier = GetPlayerIdentifiers(Source)[1]
    if gsrData[identifier] ~= nil then
        gsrData[identifier] = nil
    end
end)

RegisterServerEvent('GSR:SetGSR')
AddEventHandler('GSR:SetGSR', function()
    local Source = source
    local identifier = GetPlayerIdentifiers(Source)[1]
    gsrData[identifier] = os.time(os.date("!*t")) + Config.gsrTime
end)

function getIdentity(identifier)
    local identifier = identifier
    local result = MySQL.Sync.fetchAll("SELECT firstname, lastname FROM users WHERE identifier = @identifier", {
        ['@identifier'] = identifier
    })
  if result[1] ~= nil then
    local identity = result[1]

    return {
      firstname   = identity['firstname'],
      lastname  = identity['lastname']
    }
  else
    return {
      firstname   = '',
      lastname  = ''
    }
    end
end

function gsrcheck(source, identifier)
    local Source = source
    local identifier = identifier
	if Config.UseCharName then
		local nameData = getIdentity(identifier)
		Wait(100)
		local fullName = string.format("%s %s", nameData.firstname, nameData.lastname)
		if gsrData[identifier] ~= nil then
            TriggerClientEvent('esx:showNotification', Source, 'Verification pour '..fullName..' est positive (A Tirer)')
    	else
            TriggerClientEvent('esx:showNotification', Source, 'Verification pour '..fullName..' est negatif (Pas Tirer)')
    	end
	else
    	if gsrData[identifier] ~= nil then
            TriggerClientEvent('esx:showNotification', Source, 'est positive (A Tirer)')
    	else
            TriggerClientEvent('esx:showNotification', Source, 'est negatif (Pas Tirer)')
    	end
	end
end

RegisterServerEvent('GSR:Status2')
AddEventHandler('GSR:Status2', function(playerid)
    local Source = source
    local identifier = GetPlayerIdentifiers(playerid)[1]
    if Config.UseCharName then
		local nameData = getIdentity(identifier)
		Wait(100)
		local fullName = string.format("%s %s", nameData.firstname, nameData.lastname)
		if gsrData[identifier] ~= nil then
            TriggerClientEvent('esx:showNotification', Source, 'Verification pour '..fullName..' est positive (A Tirer)')
    	else
            TriggerClientEvent('esx:showNotification', Source, 'Verification pour '..fullName..' est negatif (Pas Tirer)')
    	end
	else
    	if gsrData[identifier] ~= nil then
            TriggerClientEvent('esx:showNotification', Source, 'est positive (A Tirer)')
    	else
            TriggerClientEvent('esx:showNotification', Source, 'est negatif (Pas Tirer)')
    	end
	end
end)

ESX.RegisterServerCallback('GSR:Status', function(source, cb)
    local Source = source
    local identifier = GetPlayerIdentifiers(Source)[1]
    if gsrData[identifier] ~= nil then
        cb(true)
    else
        cb(false)
    end
end)

function removeGSR()
    for k, v in pairs(gsrData) do
        if v <= os.time(os.date("!*t")) then
            gsrData[k] = nil
        end
    end
end

function gsrTimer()
    removeGSR()
    SetTimeout(Config.gsrAutoRemove, gsrTimer)
end

gsrTimer()
