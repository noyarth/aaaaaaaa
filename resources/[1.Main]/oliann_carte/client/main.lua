Citizen.CreateThread(function()
	exports['qtarget']:AddBoxZone("PrendreID", vector3(237.157715, -1076.289917, 29.294273), 1, 1, {
		name="PrendreID",
		heading=30,
		--debugPoly=true,
        minZ=28.10,
        maxZ=29.80
}, {
  options = {
	  {
		  event = "takemeid", 
		  icon = "far fa-circle",
		  label = "Prendre vos carte",
	  },
  },
  job = {"all"},
  distance = 2.5
})

end)

RegisterNetEvent('takemeid')
AddEventHandler('takemeid', function()
lib.registerContext({
	id = 'takemeid',
	title = 'Carte',
	onExit = function()
	end,
	options = {
		{
			title = 'Carte Identiter',
			description = 'Prendre ta carte identiter',
			onSelect = function(args)
				TriggerServerEvent('esx:oliann', 'id_card', 450)
				TriggerServerEvent('esx_license:addLicense', 'identity')
			end,
		},
		{
			title = 'Permis d\'arme',
			description = 'Prendre ton permis d\'arme',
			onSelect = function(args)
				TriggerServerEvent('esx:oliann', 'firearms_license', 450)
				TriggerServerEvent('esx_license:addLicense', 'weapon')
			end,
		},
		{
			title = 'Permis de conduire',
			description = 'Passe ton permis avant',
			onSelect = function(args)
				ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
					if hasDriversLicense then
						TriggerServerEvent('esx:oliann', 'driver_license', 300)
					else
						ESX.ShowNotification('Tu as besoin de passer ton permis de conduire avant')
					end	
				end, GetPlayerServerId(PlayerId()), 'drive')
			end,
		},
	},
})
lib.showContext('takemeid')
end)

------LICENSE CARD-----

-- Permis d'armes
RegisterNetEvent('card:wid')
AddEventHandler('card:wid', function(source)
	TriggerServerEvent('esx:oliann', 'firearms_license', 450)
	TriggerServerEvent('esx_license:addLicense', 'weapon')
end)

-- Permis de conduire
RegisterNetEvent('card:did')
AddEventHandler('card:did', function()
	ESX.TriggerServerCallback('esx_license:checkLicense', function(hasDriversLicense)
		if hasDriversLicense then
			TriggerServerEvent('esx:oliann', 'driver_license', 300)
		else
			ESX.ShowNotification('Tu as besoin de passer ton permis de conduire avant')
		end	
	end, GetPlayerServerId(PlayerId()), 'drive')
end)

-- Carte personelle
RegisterNetEvent('card:id')
AddEventHandler('card:id', function(source)
	TriggerServerEvent('esx:oliann', 'id_card', 450)
	TriggerServerEvent('esx_license:addLicense', 'identity')
end)
