local Options = {}

exports.qtarget:AddBoxZone("policegarage", vector3(459.751892, -986.697510, 25.699837), 1, 1, {  
	name="policegarage",
	heading=0,
	debugPoly=false,
	minZ=25.699833,
	maxZ=28.0,
	}, {
		options = {
			{
				event = "nnailo_police:opengaragepolice",
				icon = "fa-solid fa-warehouse",
				label = "Ouvrir le Garage",
				job = "police",
			},
		},
		distance = 2.5
})

for i = 1, #Config.cars do
    if i == 1 then
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'nnailo_police:delCar'}
    else
        Options[i] = { title = Config.cars[i].nom, args = Config.cars[i].modele, event = 'nnailo_police:spawnCar'}
    end
end
    lib.registerContext({
        id = 'opengaragepolice',
        title = _U('title_menu'),
        options = Options,
    })



RegisterNetEvent('nnailo_police:opengaragepolice')
AddEventHandler('nnailo_police:opengaragepolice',function()
	lib.showContext('opengaragepolice')
end)

function createCar(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), false))
    local vehicle = CreateVehicle(car, Config.Police.SpawnVeh, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = Config.Plate..math.random(1,9)
    SetVehicleNumberPlateText(vehicle, plaque) 
    SetPedIntoVehicle(PlayerPedId(),vehicle,-1)
end

RegisterNetEvent('nnailo_police:spawnCar', function(data)
    createCar(data)
end)

RegisterNetEvent('nnailo_police:delCar')
AddEventHandler('nnailo_police:delCar',function()
    local veh = ESX.Game.GetClosestVehicle()
    DeleteEntity(veh)
end)

-------- veh done
