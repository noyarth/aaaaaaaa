local PlayerDate, setFaction
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		ESX = exports['es_extended']:getSharedObject()
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('esx:setFaction')
AddEventHandler('esx:setFaction', function(faction)
	PlayerData = faction
end)

exports.qtarget:AddBoxZone("mafiaBoss", vector3(84.053688, -1958.065430, 21.121698), 2.4, 1, {
	name="mafiaBoss",
	heading=90,
	--debugPoly=true,
	minZ=29.73,
	maxZ=31.73
	  }, {
		  options = {
			  {
				  event = "mafiabossactions", 
				  icon = "far fa-circle",
				  label = "Menu OG",
				  faction = "mafia",
			  },
		  },
		  distance = 3.5
  })
  
  RegisterNetEvent('mafiabossactions')
  AddEventHandler('mafiabossactions', function()
	  OpenmafiaBoss()
  end)
  
  function OpenmafiaBoss()
	  TriggerEvent('esx_society:openBossMenu', 'mafia', function(data, menu)
		  menu.close()
		  end, { wash = false })
  end

