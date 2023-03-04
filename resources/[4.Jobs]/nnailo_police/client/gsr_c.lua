local hasShot = false
local ignoreShooting = false

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(350)
        ped = PlayerPedId()
        if IsPedShooting(ped) then
            local currentWeapon = GetSelectedPedWeapon(ped)
            for _,k in pairs(Config.weaponChecklist) do
                if currentWeapon == k then
                    ignoreShooting = true
                    break
                end
            end
            
            if not ignoreShooting then
                TriggerServerEvent('GSR:SetGSR', timer)
                hasShot = true
                ignoreShooting = false
                Citizen.Wait(Config.gsrUpdate)
            end
			ignoreShooting = false
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(2000)
        if Config.waterClean and hasShot then
            ped = PlayerPedId()
            if IsEntityInWater(ped) then
            --    ESX.ShowNotification('[GSR] Tu lave tes main de poudre a canon... Rester dans l\'eau.') 
            ESX.ShowNotification(_U('gsr_wash'))  
				Wait(100)
                    ESX.Progressbar("Lavement des traces", 15000,{
                        FreezePlayer = false, 
                        animation ={
                            type = "anim",
                            dict = "mini@repair", 
                            lib ="fixing_a_ped" 
                        }, 
                        onFinish = function(status)
                            if not status then
                                if IsEntityInWater(ped) then
                                    hasShot = false
                                    TriggerServerEvent('GSR:Remove')
                                    ESX.ShowNotification(_U('gsr_wash2')) 
                                else
                                    ESX.ShowNotification(_U('gsr_wash3'))  
                                end
                            end
                        end})
                        Citizen.Wait(Config.waterCleanTime)
                    end
                end
            end
        end)


function status()
    if hasShot then
        ESX.TriggerServerCallback('GSR:Status', function(cb)
            if not cb then
                hasShot = false
            end
        end)
    end
end

function updateStatus()
    status()
    SetTimeout(Config.gsrUpdateStatus, updateStatus)
end

updateStatus()
