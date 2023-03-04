ESX = nil
local seatsTaken = {}

ESX = exports['es_extended']:getSharedObject()

RegisterNetEvent('JOSHUA_sit:takePlace')
AddEventHandler('JOSHUA_sit:takePlace', function(objectCoords)
	seatsTaken[objectCoords] = true
end)

RegisterNetEvent('JOSHUA_sit:leavePlace')
AddEventHandler('JOSHUA_sit:leavePlace', function(objectCoords)
	if seatsTaken[objectCoords] then
		seatsTaken[objectCoords] = nil
	end
end)

ESX.RegisterServerCallback('JOSHUA_sit:getPlace', function(source, cb, objectCoords)
	cb(seatsTaken[objectCoords])
end)