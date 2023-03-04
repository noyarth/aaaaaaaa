local Options = {}
local vehicle = {}

exports.qtarget:AddBoxZone("ballasgarage", vector3(84.481117, -1967.454346, 20.747446), 1, 1, {  
	name="ballasgarage",
	heading=0,
	debugPoly=false,
	minZ=25.699833,
	maxZ=28.0,
	}, {
		options = {
			{
				event = "oliann_ballas:opengarageballas",
				icon = "fa-solid fa-warehouse",
				label = "Ouvrir le Garage",
				faction = "ballas",
			},
		},
		distance = 2.5
})

for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_ballas:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_ballas:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengarageballas',
        title = _U('title_menu'),
        options = Options,
    })



RegisterNetEvent('oliann_ballas:opengarageballas')
AddEventHandler('oliann_ballas:opengarageballas',function()
	lib.showContext('opengarageballas')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.Ballas.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('oliann_ballas:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('oliann_ballas:delCar')
AddEventHandler('oliann_ballas:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

-------- veh done
