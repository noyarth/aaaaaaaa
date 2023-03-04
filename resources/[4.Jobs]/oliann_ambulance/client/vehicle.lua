local Options = {}

exports.qtarget:AddBoxZone("ambulancegarage", vector3(293.724060, -599.965271, 43.151375), 1, 1, {  
	name="ambulancegarage",
	heading=0,
	debugPoly=false,
	minZ=25.699833,
	maxZ=28.0,
	}, {
		options = {
			{
				event = "oliann_ambulance:opengarageambulance",
				icon = "fa-solid fa-warehouse",
				label = "Ouvrir le Garage",
				job = "ambulance",
			},
		},
		distance = 2.5
})

for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_ambulance:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'oliann_ambulance:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengarageambulance',
        title = _U('title_menu'),
        options = Options,
    })



RegisterNetEvent('oliann_ambulance:opengarageambulance')
AddEventHandler('oliann_ambulance:opengarageambulance',function()
	lib.showContext('opengarageambulance')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.Ambulance.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('oliann_ambulance:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('oliann_ambulance:delCar')
AddEventHandler('oliann_ambulance:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

-------- veh done
