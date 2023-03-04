local Options = {}
local vehicle = {}

exports.qtarget:AddBoxZone("vagosgarage", vector3(337.028564, -2035.239502, 21.343628), 1, 1, {  
	name="vagosgarage",
	heading=0,
	debugPoly=false,
	minZ=25.699833,
	maxZ=28.0,
	}, {
		options = {
			{
				event = "oliann_vagos:opengaragevagos",
				icon = "fa-solid fa-warehouse",
				label = "Ouvrir le Garage",
				faction = "vagos",
			},
		},
		distance = 2.5
})

for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_vagos:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_vagos:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengaragevagos',
        title = _U('title_menu'),
        options = Options,
    })



RegisterNetEvent('oliann_vagos:opengaragevagos')
AddEventHandler('oliann_vagos:opengaragevagos',function()
	lib.showContext('opengaragevagos')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.vagos.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('oliann_vagos:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('oliann_vagos:delCar')
AddEventHandler('oliann_vagos:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

-------- veh done
