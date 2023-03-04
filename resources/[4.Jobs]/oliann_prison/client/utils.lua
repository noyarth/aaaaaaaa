RegisterCommand("jailmenu", function(source, args)

	if PlayerData.job.name == "police" then
		OpenJailMenu()
	else
		ESX.ShowNotification("Tu es pas policier!")
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

local PrisonSpawns = {
    { x = 1762.602, y = 2565.073, z = 45.55676, h = 136.063 },
    { x = 1751.934, y = 2560.009, z = 45.55676, h = 201.2598 },
    { x = 1753.846, y = 2554.22, z = 45.55676, h = 263.6221 },
}

local inCutScene = false

function Cutscene(months, name, date)

	if inCutScene then
        return
    end

	inCutScene = true

    DoScreenFadeOut(10)
    FreezeEntityPosition(PlayerPedId(), true)

    Citizen.Wait(1000)

	local timer = 0
    while timer ~= -1 do
        timer = timer + 1
        Citizen.Wait(1)

        SetEntityCoords(PlayerPedId(), 1679.815, 2589.112, 44.91064)
        if IsInteriorReady(GetInteriorAtCoords(1679.815, 2589.112, 44.91064)) or timer > 1000 then
            timer = -1
        end
    end



    SetEntityCoords(PlayerPedId(),1679.815, 2589.112, 44.91064)
    SetEntityHeading(PlayerPedId(), 277.7953)
    Citizen.Wait(1500) 
    DoScreenFadeIn(500)
    TriggerEvent('esx-qalle-jail:AttachPrisonProp', months, name, date)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(5000) 
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)     
    SetEntityHeading(PlayerPedId(), 186.77) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)  
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)         
    SetEntityHeading(PlayerPedId(), 358.51) 

    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000) 
    TriggerEvent('InteractSound_CL:PlayOnOne', 'photo', 0.4)
    Citizen.Wait(3000)       

    SetEntityHeading(PlayerPedId(), 277.7953)

    Citizen.Wait(2000)
    DoScreenFadeOut(250)
    Citizen.Wait(2000)
    DoScreenFadeIn(250)
	local rnd = math.random(1, #PrisonSpawns)

    SetEntityCoords(PlayerPedId(), PrisonSpawns[rnd].x, PrisonSpawns[rnd].y, PrisonSpawns[rnd].z)
    SetEntityHeading(PlayerPedId(), PrisonSpawns[rnd].h)
    TriggerEvent('InteractSound_CL:PlayOnOne', 'cell', 0.4)    
    FreezeEntityPosition(PlayerPedId(), false)
	InJail()
	inCutScene = false
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function TeleportPlayer(pos)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Choisir position",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]

			if action == "Boiling Broke" or action == "Security" then

				if PlayerData.job.name ~= "police" then
					ESX.ShowNotification("Tu a pas de cles pour aller la!")
					return
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Citizen.Wait(250)

			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Citizen.Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]

		DoScreenFadeOut(100)

		Citizen.Wait(250)

		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

		Citizen.Wait(250)

		DoScreenFadeIn(100)
	end
end

Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Teleports["Boiling Broke"]["x"], Config.Teleports["Boiling Broke"]["y"], Config.Teleports["Boiling Broke"]["z"])

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.85)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Prison')
    EndTextCommandSetBlipName(blip)
end)

---- PRISON CUTSCENE
function runAnimation()
    RequestAnimDict("mp_character_creation@lineup@male_a")
    while not HasAnimDictLoaded("mp_character_creation@lineup@male_a") do
    Citizen.Wait(0)
    end
    if not IsEntityPlayingAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "loop_raised", 3) then
        TaskPlayAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "loop_raised", 8.0, -8, -1, 49, 0, 0, 0, 0)
    end
end

local prisonProp = 0
local count = 0

function RemovePrisonProp()
    DeleteEntity(prisonProp)
    prisonProp = 0
end


RegisterNetEvent('esx-qalle-jail:AttachPrisonProp')
AddEventHandler('esx-qalle-jail:AttachPrisonProp', function(months, name, date)
	runAnimation()
	RemovePrisonProp()

	ClearPedProp(PlayerPedId(), 0)
	SetPedComponentVariation(PlayerPedId(), 1, -1, -1 ,false)
	TriggerEvent('esx-qalle-jail:DrawMugShot', months, name, date)
    attachModel = GetHashKey("prop_police_id_board")
    SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
    local bone = GetPedBoneIndex(PlayerPedId(), 28422)
    --local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    RequestModel(attachModel)
    while not HasModelLoaded(attachModel) do
        Citizen.Wait(100)
    end
    prisonProp = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)

    AttachEntityToEntity(prisonProp, PlayerPedId(), bone, 0.0, 0.0, 0.1, 0.0, 0.0, 0.0, 1, 1, 0, 0, 2, 1)
    exit = false
    local plyCoords = GetEntityCoords(PlayerPedId())
    while not exit do
        
        Citizen.Wait(1)
        plyCoords2 = GetEntityCoords(PlayerPedId())
        if not IsEntityPlayingAnim(PlayerPedId(), "mp_character_creation@lineup@male_a", "loop_raised", 3) then
            exit = true
        end
        if (#(plyCoords2 - plyCoords) > 1.5) then
            exit = true
        end
    end
    ClearPedTasksImmediately(PlayerPedId())
    RemovePrisonProp()
end)


RegisterNetEvent('esx-qalle-jail:DrawMugShot')
AddEventHandler('esx-qalle-jail:DrawMugShot', function(months, name ,date)

    Citizen.Wait(1000)
    if (#(GetEntityCoords(PlayerPedId()) - vector3(1679.22, 2589.13, 44.91)) < 10.0) then
        if count > 0 then
            count = 0
        end
        Citizen.Wait(1)
        local scaleform = RequestScaleformMovie("mugshot_board_01")
        while not HasScaleformMovieLoaded(scaleform) do
          Wait(1)
        end
        count = 10000
        while count > 0 do
            count = count - 1
            local objFound = GetClosestObjectOfType(GetEntityCoords(PlayerPedId()), 10.0, `prop_police_id_board`, 0, 0, 0)
            if objFound then
                scaleformPaste(scaleform,objFound,name,months,date)
            end
            Citizen.Wait(1)
        end
    end
end)

function scaleformPaste(scaleform,obj,name, months, date)
    local position = GetOffsetFromEntityInWorldCoords(obj, -0.2, -0.0132 - (GetEntitySpeed(PlayerPedId()) / 50), 0.105)
    local scale = vector3(0.41, 0.23, 1.0)
    local push = GetEntityRotation(obj, 2)

    Citizen.InvokeNative(0x87D51D72255D4E78, scaleform, position, 180.0 + push["x"], 0.0 - GetEntityRoll(obj),GetEntityHeading(obj), 1.0, 0.8, 4.0, scale, 0)

    if not date then
        date = "Mugshot Board"
    end

    if not months then
        months = 0
    end

    if not name then
        name = "No Name"
    end

    PushScaleformMovieFunction(scaleform, "SET_BOARD")
    PushScaleformMovieFunctionParameterString("LOS SANTOS POLICE DEPARTEMENT")
    PushScaleformMovieFunctionParameterString(date)
    PushScaleformMovieFunctionParameterString("Prison " .. months .. " Mois")
    PushScaleformMovieFunctionParameterString(name)
    PushScaleformMovieFunctionParameterFloat(0.0)
    PopScaleformMovieFunctionVoid()
end