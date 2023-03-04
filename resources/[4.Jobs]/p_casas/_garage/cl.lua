function Garage(gid)
    ESX.TriggerServerCallback("p_house:g:reqgarage", function(data) 
        local elms = {}
        local thisgarage = houses[gid].garage
        local garageid = gid

        if #data == 0 then
            ESX.ShowNotification(Translation.emptygarage)
            return 
        end 

        for k,v in pairs(data) do
            table.insert(elms, {label = GetDisplayNameFromVehicleModel(v.model).." - "..v.plate, props = v})
        end	
        
        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu_pers_gar', {
            title    = Translation.GarageTitle,
            align    = 'bottom-right',
            elements = elms
        }, function(data, menu)
            local c = data.current
            ESX.Game.SpawnVehicle(c.props.model, thisgarage.enter, thisgarage.hdg, function(callback_vehicle)
                ESX.Game.SetVehicleProperties(callback_vehicle, c.props)
                TriggerServerEvent("p_house:garage:s:removeslot", c.props.slot, garageid)
--                DecorSetFloat(callback_vehicle, "_FUEL_LEVEL", c.props.fuelLevel)
                TaskWarpPedIntoVehicle(PlayerPedId(), callback_vehicle, -1)
            end)
            menu.close()
        end, function(data, menu)
            menu.close()
        end)
    end, gid)
end
