Selldrugs = Selldrugs or {}
Selldrugs.OnSellDrugs = false 

Selldrugs.Key = 51

Selldrugs.Items = {
	{item = "weedemballage", label = "Weed", props = "prop_weed_block_01", anim = {"mp_common", "givetake2_a"}, minmoney = 25, maxmoney = 50},
	{item = "coke", label = "Coke", props = "prop_coke_block_half_b", anim = {"mp_common", "givetake2_a"}, minmoney = 50, maxmoney = 75},
	{item = "methemballage", label = "Meth", props = "p_meth_bag_01_s", anim = {"mp_common", "givetake2_a"}, minmoney = 75, maxmoney = 100},
}

ESX = nil
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function Selldrugs:Haveitems(item, count)
    local bool = false
    ESX.TriggerServerCallback("cDrugs:getPlayerInventory", function(data)
        items = {}
        inventory = data.inventory

        if inventory ~= nil then
            for key, value in pairs(inventory) do
                if inventory[key].name == item then 
                    if inventory[key].count >= count then
                        bool = true   
                    else
                        bool = false 
                    end
                end
            end
        end

    end, GetPlayerServerId(PlayerId()) )
    Wait(170)
    return bool
end

RegisterCommand("drugs", function()
    TriggerEvent("cDrugs:ActivDrugsSell")
end)

RegisterNetEvent("cDrugs:ActivDrugsSell")
AddEventHandler('cDrugs:ActivDrugsSell', function()
    local player = PlayerPedId()
    local found = false 
    for k,v in pairs(Selldrugs.Items) do 
        if Selldrugs:Haveitems(v.item, 1) then 
            found = true 
            break 
        else
            found = false 
        end
    end
    if not found then return ESX.ShowNotification("~r~Vous devez avoir de la drogue sur vous.") end
    if not Selldrugs.OnSellDrugs then 
        ESX.ShowNotification("Vous avez ~b~activé~s~ la vente de drogues.")
        Selldrugs.OnSellDrugs = true 
    elseif Selldrugs.OnSellDrugs then 
        ESX.ShowNotification("Vous avez ~r~désactivé~s~ la vente de drogues.")
        Selldrugs.OnSellDrugs = false 
    end
end)

function Selldrugs:CanSellToPed(ped)
	if not IsPedAPlayer(ped) and not IsEntityAMissionEntity(ped) and not IsPedInAnyVehicle(ped, false) and not IsEntityDead(ped) and IsPedHuman(ped) and GetEntityModel(ped) ~= GetHashKey("s_m_y_cop_01") and GetEntityModel(ped) ~= GetHashKey("s_m_y_dealer_01") and GetEntityModel(ped) ~= GetHashKey("mp_m_shopkeep_01") and ped ~= PlayerPedId() then 
		return true
	end
	return false
end

function RequestAndWaitDict(dictName) -- Request une animation (dict)
	if dictName and DoesAnimDictExist(dictName) and not HasAnimDictLoaded(dictName) then
		RequestAnimDict(dictName)
		while not HasAnimDictLoaded(dictName) do Citizen.Wait(100) end
	end
end
function RequestAndWaitModel(modelName) -- Request un modèle de véhicule
	if modelName and IsModelInCdimage(modelName) and not HasModelLoaded(modelName) then
		RequestModel(modelName)
		while not HasModelLoaded(modelName) do Citizen.Wait(100) end
	end
end

function TaskPlayAnimToPlayer(a,b,c,d,e)if type(a)~="table"then a={a}end;d,c=d or GetPlayerPed(-1),c and tonumber(c)or false;if not a or not a[1]or string.len(a[1])<1 then return end;if IsEntityPlayingAnim(d,a[1],a[2],3)or IsPedActiveInScenario(d)then ClearPedTasks(d)return end;Citizen.CreateThread(function()TaskForceAnimPlayer(a,c,{ped=d,time=b,pos=e})end)end;local f={"WORLD_HUMAN_MUSICIAN","WORLD_HUMAN_CLIPBOARD"}local g={["WORLD_HUMAN_BUM_WASH"]={"amb@world_human_bum_wash@male@high@idle_a","idle_a"},["WORLD_HUMAN_SIT_UPS"]={"amb@world_human_sit_ups@male@idle_a","idle_a"},["WORLD_HUMAN_PUSH_UPS"]={"amb@world_human_push_ups@male@base","base"},["WORLD_HUMAN_BUM_FREEWAY"]={"amb@world_human_bum_freeway@male@base","base"},["WORLD_HUMAN_CLIPBOARD"]={"amb@world_human_clipboard@male@base","base"},["WORLD_HUMAN_VEHICLE_MECHANIC"]={"amb@world_human_vehicle_mechanic@male@base","base"}}function TaskForceAnimPlayer(a,c,h)c,h=c and tonumber(c)or false,h or{}local d,b,i,j,k,l=h.ped or GetPlayerPed(-1),h.time,h.clearTasks,h.pos,h.ang;if IsPedInAnyVehicle(d)and(not c or c<40)then return end;if not i then ClearPedTasks(d)end;if not a[2]and g[a[1]]and GetEntityModel(d)==-1667301416 then a=g[a[1]]end;if a[2]and not HasAnimDictLoaded(a[1])then if not DoesAnimDictExist(a[1])then return end;RequestAnimDict(a[1])while not HasAnimDictLoaded(a[1])do Citizen.Wait(10)end end;if not a[2]then ClearAreaOfObjects(GetEntityCoords(d),1.0)TaskStartScenarioInPlace(d,a[1],-1,not TableHasValue(f,a[1]))else if not j then TaskPlayAnim(d,a[1],a[2],8.0,-8.0,-1,c or 44,1,0,0,0,0)else TaskPlayAnimAdvanced(d,a[1],a[2],j.x,j.y,j.z,k.x,k.y,k.z,8.0,-8.0,-1,1,1,0,0,0)end end;if b and type(b)=="number"then Citizen.Wait(b)ClearPedTasks(d)end;if not h.dict then RemoveAnimDict(a[1])end end;function TableHasValue(m,n,o)if not m or not n or type(m)~="table"then return end;for p,q in pairs(m)do if o and q[o]==n or q==n then return true,p end end end
function AttachObjectToHandsPeds(ped, hash, timer, rot, bone, dynamic) -- Attach un props sur la main d'un ped
    if props and DoesEntityExist(props)then 
        DeleteEntity(props)
    end
    props = CreateObject(GetHashKey(hash), GetEntityCoords(ped), not dynamic)
    AttachEntityToEntity(props, ped, GetPedBoneIndex(ped, bone and 60309 or 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, not rot)
    if timer then 
        Citizen.Wait(timer)
        if props and DoesEntityExist(props)then 
            DeleteEntity(props)
        end
    	ClearPedTasks(ped)
    end
    return props
end

function TableGetValue(tbl, value, k) -- Si une table a une value précise
	if not tbl or not value or type(tbl) ~= "table" then return end
	for _,v in pairs(tbl) do
		if k and v[k] == value or v == value then return true, _ end
	end
end

function Selldrugs:MakeEntityFaceEntity(entity1, entity2)
    local p1 = GetEntityCoords(entity1, true)
    local p2 = GetEntityCoords(entity2, true)

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y

    local heading = GetHeadingFromVector_2d(dx, dy)
    SetEntityHeading( entity1, heading )
end

Citizen.CreateThread(function()

    while true do 
        local wait = 1000
        local pPed = PlayerPedId()
        local pPos = GetEntityCoords(pPed)

        if Selldrugs.OnSellDrugs and not IsPedInAnyVehicle(pPed) then 
            wait = 250
            local retval, outEntity = FindFirstPed()
            local succesPed = nil 

            repeat 
                pPed = PlayerPedId()
                pPos = GetEntityCoords(pPed)
                succesPed, outEntity = FindNextPed(retval)
                local cPos = GetEntityCoords(outEntity)
                local dist = Vdist(pPos, cPos)

                if dist <= 5.0 and Selldrugs:CanSellToPed(outEntity) then 
                    wait = 5
                    SetBlockingOfNonTemporaryEvents(outEntity, true)
					PlayAmbientSpeech2(outEntity, "GENERIC_HI", "SPEECH_PARAMS_FORCE")
					SetPedCanRagdollFromPlayerImpact(outEntity, false)

                    if dist <= 2.5 then 
                        ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~b~vendre votre drogue~s~.")

                        if IsControlJustPressed(0, Selldrugs.Key) then 

                            PlayAmbientSpeech1(outEntity, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
                            PlaceObjectOnGroundProperly(outEntity)
                            ClearPedTasksImmediately(outEntity)
                            Selldrugs:MakeEntityFaceEntity(pPed, outEntity)
                            Selldrugs:MakeEntityFaceEntity(outEntity, pPed)

                            local item, props, anim, minmoney, maxmoney, label = nil, nil, nil, nil, nil, nil

                            for k,v in pairs(Selldrugs.Items) do 
                                if Selldrugs:Haveitems(v.item, 1) then 
                                    item, props, anim, minmoney, maxmoney, label = v.item, v.props, v.anim, v.minmoney, v.maxmoney, v.label
                                    break 
                                end
                            end

                            if not minmoney and not maxmoney then 
                                ESX.ShowNotification("~r~Vous n'avez plus de drogues.")
                                Selldrugs.OnSellDrugs = false 
                            else
                                RequestAndWaitDict("mp_common")
                                RequestAndWaitModel(props)
                                RequestAndWaitModel('hei_prop_heist_cash_pile')
    
                                SetPedTalk(outEntity)
                                PlayAmbientSpeech1(outEntity, 'GENERIC_HI', 'SPEECH_PARAMS_STANDARD')
    
                                local cCreate = CreateObject(GetHashKey(props), 0, 0, 0, true)
                                AttachEntityToEntity(cCreate, pPed, GetPedBoneIndex(pPed, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                                local oCreate = CreateObject(GetHashKey('hei_prop_heist_cash_pile'), 0, 0, 0, true)
                                AttachEntityToEntity(oCreate, outEntity, GetPedBoneIndex(outEntity, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)

                                TaskPlayAnim(pPed, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 1, false, false, false)
                                TaskPlayAnim(outEntity, 'mp_common', 'givetake1_a', 8.0, 8.0, -1, 0, 1, false, false, false)

                                Wait(1000)
                                AttachEntityToEntity(oCreate, pPed, GetPedBoneIndex(pPed, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                                AttachEntityToEntity(cCreate, outEntity, GetPedBoneIndex(outEntity, 57005), 0.13, 0.02, 0.0, -90.0, 0, 0, 1, 1, 0, 1, 0, 1)
                                Wait(1000)
    
                                PlaySoundFrontend(-1, "Bomb_Disarmed", "GTAO_Speed_Convoy_Soundset", 0)
    
                                ClearPedTasks(outEntity)
                                ClearPedTasks(pPed)
    
                                if cCreate then 
                                    DeleteEntity(cCreate)
                                end
                                if oCreate then 
                                    DeleteEntity(oCreate)
                                end
    
                                local chance = math.random(0, 100)
                                if chance >= 0 and chance <= 28 then
                                    ESX.ShowNotification("~r~La personne ne veut pas de votre marchandise.")
                                    TriggerServerEvent("call:makeCall", "police", pPos)
                                else
                                    if minmoney and maxmoney then 
                                        TriggerServerEvent('cDrugs:SellDrugs', item, label, math.random(minmoney, maxmoney), 1)
                                    else
                                        ESX.ShowNotification("~r~Vous n'avez plus de drogues.")
                                        Selldrugs.OnSellDrugs = false 
                                    end
                                end
    
                                Citizen.Wait(500)
                                TaskWanderStandard(outEntity, 10.0, 10)
                                PlayAmbientSpeech1(outEntity, 'GENERIC_THANKS', 'SPEECH_PARAMS_STANDARD')
    
                                SetEntityAsMissionEntity(outEntity, true, true)
                                SetPedCanRagdollFromPlayerImpact(outEntity, true)
                            end
                        end
                    end
                end

            until not succesPed
            EndFindPed(retval)

        end

        Wait(wait)
    end
end)