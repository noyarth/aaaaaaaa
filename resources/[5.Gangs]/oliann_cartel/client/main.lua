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

exports.qtarget:AddBoxZone("CartelBoss", vector3(1393.292358, 1159.951660, 114.120922), 2.4, 1, {
	name="CartelBoss",
	heading=40,
	--debugPoly=true,
	minZ=29.73,
	maxZ=31.73
	  }, {
		  options = {
			  {
				  event = "cartelbossactions", 
				  icon = "far fa-circle",
				  label = "Menu Chef",
				  faction = "cartel",
			  },
		  },
		  distance = 3.5
  })
  
  RegisterNetEvent('cartelbossactions')
  AddEventHandler('cartelbossactions', function()
	  OpenCartekBoss()
  end)
  
  function OpenCartelBoss()
	  TriggerEvent('esx_society:openBossMenu', 'cartel', function(data, menu)
		  menu.close()
		  end, { wash = false })
  end

