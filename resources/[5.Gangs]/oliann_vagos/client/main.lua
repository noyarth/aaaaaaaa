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

exports.qtarget:AddBoxZone("vagosBoss", vector3(361.582428, -2031.032958, 25.589722), 2.4, 1, {
	name="vagosBoss",
	heading=150,
	--debugPoly=true,
	minZ=29.73,
	maxZ=31.73
	  }, {
		  options = {
			  {
				  event = "vagosbossactions", 
				  icon = "far fa-circle",
				  label = "Menu OG",
				  faction = "vagos",
			  },
		  },
		  distance = 3.5
  })
  
  RegisterNetEvent('vagosbossactions')
  AddEventHandler('vagosbossactions', function()
	  OpenvagosBoss()
  end)
  
  function OpenvagosBoss()
	  TriggerEvent('esx_society:openBossMenu', 'vagos', function(data, menu)
		  menu.close()
		  end, { wash = false })
  end

