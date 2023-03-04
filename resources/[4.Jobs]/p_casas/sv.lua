ESX = nil 
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
casas = {}
reqsync = {}

-- ENTRAR AL SALIR

MySQL.ready(function()
    --reloadhouses()
    local awa = MySQL.Sync.fetchAll('SELECT * FROM p_houses')
    casas = {}
    for _,v in pairs(awa) do
        local poses = {}

        for k,v in pairs(json.decode(v.positions)) do
            poses[k] = vector3(v.x,v.y,v.z)
        end

        casas[v.id] = {
            id = v.id,
            owner = v.owner,
            interior = v.interior,
            positions = poses,
            furnish = json.decode(v.furnish),
            pinside = {},
            data = json.decode(v.data),
            pingar = {},
            garage = json.decode(v.garage)
        }

        for k,o in pairs(casas[v.id].garage) do
            if type(o) == "table" and o.x ~= nil and o.y ~= nil and o.z ~= nil then
                casas[v.id].garage[k] = vector3(o.x , o.y , o.z)
            end
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)

        local count = 0
        for k in pairs(reqsync) do
            count = count + 1
            local tsh = casas[k]
            if tsh ~= nil then
                MySQL.Async.execute('UPDATE p_houses SET positions = @positions, furnish = @furnish, data = @data, garage = @garage WHERE id = @id',{
                    ["@id"] = tsh.id,
                    ["@furnish"] = json.encode(tsh.furnish),
                    ["@positions"] = json.encode(tsh.positions),
                    ["@data"] = json.encode(tsh.data),
                    ["@garage"] = json.encode(tsh.garage),
                })
            end
            reqsync[k] = nil
        end

        if count > 0 then
            print("[^2P_HOUSES^0] Sicronizado propiedades: "..count)
        end
    end
end)

AddEventHandler('esx:playerLoaded', function(source)
    Citizen.Wait(4000)
    local xPlayer = ESX.GetPlayerFromId(source)

    local data = MySQL.Sync.fetchAll('SELECT UltimaCasa FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})

    if data[1] ~= nil and data[1].UltimaCasa ~= nil and casas[data[1].UltimaCasa] ~= nil then
        TriggerClientEvent("p_houses:c:join",source,casas[data[1].UltimaCasa])
    end
end)

RegisterServerEvent('p_h:s:reqall')
AddEventHandler('p_h:s:reqall', function()
    TriggerClientEvent("p_h:c:updateall", source, casas)
end)

AddEventHandler('playerDropped', function()
    local _src = source
	for _,v in pairs(casas) do
        for k,p in pairs(v.pinside) do
            if p == _src then
                v.pinside[k] = nil
            end
        end

        for k,p in pairs(v.pingar) do
            if p == _src then
                v.pingar[k] = nil
            end
        end
    end
end)

RegisterServerEvent('p_houses:s:leave')
AddEventHandler('p_houses:s:leave', function(id)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)

    MySQL.Async.execute('UPDATE users SET UltimaCasa = NULL WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	})
    --xPlayer.setData("lasthouse", nil)

    for k,p in pairs(casas[id].pinside) do
        if p == _src then
            casas[id].pinside[k] = nil
        end
    end
end)

RegisterServerEvent('p_houses:s:join')
AddEventHandler('p_houses:s:join', function(id)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    if casas[id] then
        table.insert(casas[id].pinside, _src)
        --xPlayer.setData("lasthouse", id)

        MySQL.Async.execute('UPDATE users SET UltimaCasa = @last_property WHERE identifier = @identifier', {
            ['@last_property'] = id,
            ['@identifier']    = xPlayer.identifier
        })

        TriggerClientEvent("p_houses:c:join", _src, casas[id])
    end
end)

RegisterServerEvent('p_houses:s:updatefurnish')
AddEventHandler('p_houses:s:updatefurnish', function(id,fur)
    casas[id].furnish = fur
    reqsync[id] = true

    for _,v in pairs(casas[id].pinside) do
        TriggerClientEvent("p_houses:c:updatef", v, fur)
    end
end)

RegisterServerEvent('p_houses:s:updatelock')
AddEventHandler('p_houses:s:updatelock', function(id,bol)
    casas[id].data.lock = bol
    reqsync[id] = true
    for _,v in pairs(casas[id].pinside) do
        TriggerClientEvent("p_houses:c:updatehouse", v, id, casas[id])
    end
end)

RegisterServerEvent('p_houses:s:createhouse')
AddEventHandler('p_houses:s:createhouse', function(data)
    local thisid = gid(5)
    while casas[thisid] ~= nil do
        thisid = gid(5)
    end

    casas[thisid] = {
        id = thisid,
        interior = data.Interior,
        positions = {
            enter = data.Entrada
        },
        furnish = {},
        pinside = {},
        data = {
            lock = true,
            pack = true,
            keys = {}
        },
        pingar = {},
        garage = {}
    }

    if data["Entrada_Garage"] ~= nil then
        casas[thisid].garage.pos = data["Entrada_Garage"]
        casas[thisid].garage.enter = data["Salida_Garage"]
        casas[thisid].garage.hdg = data["rot"]
    end

    if data["prc"] ~= nil then
        casas[thisid].data.price = data["prc"]
    end

    MySQL.Async.execute('INSERT INTO p_houses (id,interior,positions,data,garage,inventory) VALUES (@id,@interior,@positions,@data,@garage,@inventory)',{
        ["@id"] = thisid,
        ["@interior"] = casas[thisid].interior,
        ["@positions"] = json.encode(casas[thisid].positions),
        ["@data"] = json.encode(casas[thisid].data),
        ["@garage"] = json.encode(casas[thisid].garage),
        ['@inventory'] = json.encode({items = {}, weapons = {}, money = 0, black_money = 0})
    })

    TriggerClientEvent("p_h:c:updateall", -1, casas)
end)

ESX.RegisterServerCallback('p_houses:getInventory', function(source, cb, inv)
    MySQL.Async.fetchAll('SELECT * FROM p_houses WHERE id = @id', {['@id'] = inv}, function(result)
        cb(result[1].inventory)
    end)
end)

RegisterServerEvent('p_houses:setInventory')
AddEventHandler('p_houses:setInventory', function(type, id, table)
    if type == 'items' then
        MySQL.Async.fetchAll('SELECT * FROM p_houses WHERE id = @id', {['@id'] = id}, function(result)
            local inventory = json.decode(result[1].inventory)
            inventory.items = table
            Citizen.Wait(50)
            MySQL.Async.execute('UPDATE p_houses SET inventory = @inventory WHERE id = @id', {['@id'] = id, ['@inventory'] = json.encode(inventory)})
        end)
    end
end)

RegisterServerEvent('p_houses:deleteItems')
AddEventHandler('p_houses:deleteItems', function(name, count)
    local xPlayer = ESX.GetPlayerFromId()
    xPlayer.removeInventoryItem(name, count)
end)

ESX.RegisterServerCallback('p_houses:getInvPlayer', function(source, cb, id)

	local xPlayer = ESX.GetPlayerFromId(id)
	local items   = xPlayer.inventory

	cb(items)

end)

ESX.RegisterServerCallback('p_houses:gethouseinfo', function(source, cb, id) 
    cb(casas[id])
end)

ESX.RegisterServerCallback("p_houses:getplayername", function(source, cb, ident)
    cb(GetIdentName(ident))
end)

ESX.RegisterServerCallback("p_houses:getplayersnames" ,function(source, cb)
    local n = {}
    for _,v in pairs(ESX.GetPlayers()) do
        local xPlayer = ESX.GetPlayerFromId(v)
        n[v] = xPlayer.getName()
    end
    cb(n)
end)

RegisterServerEvent('p_houses:s:updateowner')
AddEventHandler('p_houses:s:updateowner', function(id,new)
    --print(new,type(new))
    local xPlayer = ESX.GetPlayerFromId(new)
    local ident = xPlayer.getIdentifier()
    casas[id].owner = ident

    MySQL.Async.execute('UPDATE p_houses SET owner = @owner WHERE id = @id',{
        ["@owner"] = ident,
        ["@id"] = id
    })
    
    TriggerClientEvent("p_h:c:updateall", -1, casas)
end)

RegisterServerEvent('p_houese:s:delhouse')
AddEventHandler('p_houese:s:delhouse', function(id)
    for _,v in pairs(casas[id].pinside) do
        TriggerClientEvent("p_houses:c:forceleave", v)
    end
     
    MySQL.Async.execute('DELETE FROM p_houses WHERE id = @id',{
        ["@id"] = id
    })

    casas[id] = nil

    TriggerClientEvent("p_h:c:updateall", -1, casas)
end)

ESX.RegisterServerCallback("p_houses:trytobuy", function(source,cb,price)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getMoney() >= price then
        xPlayer.removeMoney(price)
        xPlayer.showNotification("Pagaste ~g~$"..price.."~w~")
        cb(true)
    elseif xPlayer.getAccount('bank').money >= price then
        xPlayer.removeAccountMoney('bank', price)
        xPlayer.showNotification("Pagaste ~g~$"..price.."~w~ de tu banco.")
        cb(true)
    else
        xPlayer.showNotification("No tenes suficiente dinero!")
        cb(false)
    end
end)

ESX.RegisterServerCallback("p_houses:getkeylist", function(source,cb,houseid)
    local t = casas[houseid]
    local data = {}
    for i=1,5 do
        if t.data.keys[i] ~= nil then
            local id = t.data.keys[i]
            local name = GetIdentName(id)
            table.insert(data,{label = "Llave "..i..": "..name, k = i,val = id})
        else
            table.insert(data,{label = "Llave "..i..": libre", k = i})
        end
    end
    cb(data)
end)

ESX.RegisterServerCallback("p_casas:s:buyhouse", function(source,cb,hid)
    local xPlayer = ESX.GetPlayerFromId(source)
    local ident = xPlayer.getIdentifier()
    
    if casas[hid] then
        local price = casas[hid].data.price
        local can

        if xPlayer.getMoney() >= price then
            xPlayer.removeMoney(price)
            xPlayer.showNotification("Pagaste ~g~$"..price.."~w~")
            can = true
        elseif xPlayer.getAccount('bank').money >= price then
            xPlayer.removeAccountMoney('bank', price)
            xPlayer.showNotification("Pagaste ~g~$"..price.."~w~ de tu banco.")
            can = true
        else
            xPlayer.showNotification("No tenes suficiente dinero!")
            can = false
        end

        if can then
            casas[hid].owner = ident

            MySQL.Async.execute('UPDATE p_houses SET owner = @owner WHERE id = @id',{
                ["@owner"] = ident,
                ["@id"] = hid
            })

            TriggerClientEvent("p_h:c:updateall", -1, casas)

            cb(true)
        else
            cb(false)
        end
    end
end)

function GetIdentName(ident)
    local xPlayer = ESX.GetPlayerFromIdentifier(ident)

    if xPlayer ~= nil then
        return xPlayer.getName()
    else 
        local r = MySQL.Sync.fetchAll('SELECT firstname,lastname FROM users WHERE identifier = @i',{
            ["@i"] = ident
        })
        if r[1] then
            return (r[1].firstname .. " " .. r[1].lastname)
        else
            return "nil"
        end
    end
end

RegisterServerEvent('p_houses:s:givekey')
AddEventHandler('p_houses:s:givekey', function(llave, casa, id)
    local xPlayer = ESX.GetPlayerFromId(id)
    casas[casa].data.keys[llave] = xPlayer.getIdentifier()
    reqsync[casa] = true

    xPlayer.showNotification("Te dieron la llave de la propiedad "..casa)
    xPlayer.triggerEvent("p_houses:c:addkey", casa)
end)

RegisterServerEvent('p_houses:s:removekey')
AddEventHandler('p_houses:s:removekey', function(llave, casa)
    local xPlayer = ESX.GetPlayerFromIdentifier(casas[casa].data.keys[llave])
    casas[casa].data.keys[llave] = nil
    reqsync[casa] = true
    if xPlayer then
        xPlayer.showNotification("Te sacaron la llave de la propiedad "..casa)
        xPlayer.triggerEvent("p_houses:c:removekey", casa)
    end
end)

RegisterServerEvent('p_houses:s:reqkeys')
AddEventHandler('p_houses:s:reqkeys', function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local mykeys = {}
    for ID,v in pairs(casas) do
        for _,m in pairs(v.data.keys) do
            if m and m == xPlayer.identifier then
                mykeys[ID] = true
            end
        end
    end
    TriggerClientEvent("p_houses:c:reckeys",_src,mykeys)
end)

RegisterServerEvent('p_houses:s:openfurnish')
AddEventHandler('p_houses:s:openfurnish', function(inv,we)
    local _src = source
    TriggerEvent("p_invs:shainv", inv, false, function(iv)
        iv.setWeight(we)
    end)
    TriggerClientEvent("p_invs:compartido", _src, inv, {"money","black_money"})
end)

if JobActivo then
    ESX.RegisterCommand("propiedad","user",function(xPlayer,args)
        if xPlayer.getJob().name == JobName then
            TriggerClientEvent("p_houses:c:crearpropiedad", xPlayer.source)
        end
    end)
else
    ESX.RegisterCommand("propiedad","admin",function(xPlayer,args)
        TriggerClientEvent("p_houses:c:crearpropiedad", xPlayer.source)
    end)
end

ESX.RegisterServerCallback('esx_property:getPlayerDressing', function(source, cb)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local count  = store.count('dressing')
		local labels = {}

		for i=1, count, 1 do
			local entry = store.get('dressing', i)
			table.insert(labels, entry.label)
		end

		cb(labels)
	end)
end)

ESX.RegisterServerCallback('esx_property:getPlayerOutfit', function(source, cb, num)
	local xPlayer  = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		local outfit = store.get('dressing', num)
		cb(outfit.skin)
	end)
end)  


