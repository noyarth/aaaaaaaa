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

exports.qtarget:AddBoxZone("BallasBoss", vector3(78.540658, -1966.654908, 21.124512), 2.4, 1, {
	name="BallasBoss",
	heading=25,
	--debugPoly=true,
	minZ=29.73,
	maxZ=31.73
	  }, {
		  options = {
			  {
				  event = "ballasbossactions", 
				  icon = "far fa-circle",
				  label = "Menu OG",
				  faction = "ballas",
			  },
		  },
		  distance = 3.5
  })
  
  RegisterNetEvent('ballasbossactions')
  AddEventHandler('ballasbossactions', function()
	  OpenBallasBoss()
  end)
  
  function OpenBallasBoss()
	  TriggerEvent('esx_society:openBossMenu', 'ballas', function(data, menu)
		  menu.close()
		  end, { wash = false })
  end
