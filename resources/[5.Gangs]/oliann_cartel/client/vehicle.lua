local Options = {}
local vehicle = {}

exports.qtarget:AddBoxZone("cartelgarage", vector3(1405.173585, 1113.006592, 112.826416), 1, 1, {  
	name="cartelgarage",
	heading=0,
	debugPoly=false,
	minZ=25.699833,
	maxZ=28.0,
	}, {
		options = {
			{
				event = "oliann_cartel:opengaragecartel",
				icon = "fa-solid fa-warehouse",
				label = "Ouvrir le Garage",
				faction = "cartel",
			},
		},
		distance = 2.5
})

for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_cartel:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_cartel:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengaragecartel',
        title = _U('title_menu'),
        options = Options,
    })



RegisterNetEvent('oliann_cartel:opengaragecartel')
AddEventHandler('oliann_cartel:opengaragecartel',function()
	lib.showContext('opengaragecartel')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.Cartel.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('oliann_cartel:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('oliann_cartel:delCar')
AddEventHandler('oliann_cartel:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

-------- veh done
