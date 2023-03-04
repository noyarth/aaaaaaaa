ESX = nil
local PlayerData = {}
local trans = {}
local societyTrans = {}
local societyIdent, societyDays
local didAction = false
local isBankOpened = false
local canAccessSociety = false
local society = ''
local societyInfo
local closestATM, atmPos

local playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney
local functional = true

RegisterNetEvent('bank:closeBanks')
AddEventHandler('bank:closeBanks', function(state)
  functional = state
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

Citizen.CreateThread(function()
	if Config.ShowBankBlips then
		Citizen.Wait(2000)
		for k,v in ipairs(Config.BankLocations)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite (blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, v.blipScale)
			SetBlipColour (blip, v.blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipText)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

function NearATM()
    local ped = GetPlayerPed(-1)
    local pos = GetEntityCoords(ped)
    
    for i = 1, #Config.ATM do
        local atm = GetClosestObjectOfType(pos.x, pos.y, pos.z, Config.ATMDistance + 5, Config.ATM[i].model, false, false, false)
        if DoesEntityExist(atm) then
        	if atm ~= closestATM then
        		closestATM = atm
	        	atmPos = GetEntityCoords(atm)
	        end
	        local dist = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, atmPos.x, atmPos.y, atmPos.z, true)
	        
	        if dist <= Config.ATMDistance then
	            return true
	        elseif dist <= Config.ATMDistance + 5 then
	        	return "update"
	        end
	    end
    end
end

function NearBank()
    local pos = GetEntityCoords(GetPlayerPed(-1))

    for k, v in pairs(Config.BankLocations) do
        local dist = GetDistanceBetweenCoords(v.x, v.y, v.z, pos.x, pos.y, pos.z, true)

        if dist <= v.BankDistance then
            return true
        elseif dist <= v.BankDistance + 5 then
        	return "update"
        end
    end
end

Citizen.CreateThread(function()
	local inRange = false
	local shown = false

    while true do
    	inRange = false
        Citizen.Wait(0)
        if NearBank() and not isBankOpened and NearBank() ~= "update" then
        	if not Config.okokTextUI then
				lib.showTextUI('[E] - To access Bank')
            else
            	inRange = true
				lib.showTextUI('[E] - To access Bank')
            end

            if IsControlJustReleased(0, 38) then
				if functional then
                SetNuiFocus(true, true)
				SendNUIMessage({
					action = 'loading_data',
				})
				Citizen.Wait(500)
				openBank()
			else
				ESX.ShowNotification('Banks and ATMs are currently closed due to the on-going bank robbery.')
			end
            end
        elseif NearBank() == "update" then
        	Citizen.Wait(300)
        else
        	Citizen.Wait(1000)
        end

        if inRange and not shown then
        	shown = true
			lib.showTextUI('[E] - To access Bank')
        elseif not inRange and shown then
        	shown = false
			lib.hideTextUI()
        end
    end
end)

exports.qtarget:AddBoxZone("BoilingAtm", vector3(1766.4230, 2577.6804, 45.4177), 0.5, 1, {
	name="BoilingAtm",
	heading=175.2991,
	debugPoly=false,
	minZ=44.90,
	maxZ=45.70,
	}, {
		options = {
			{
			event = "open:atm",
			icon = "fas fa-wallet",
			label = "ATM",
		--	job = "all"
			},
		},
		distance = 2
})

exports.qtarget:AddTargetModel({506770882, -870868698, -1126237515, -1364697528}, {
	options = {
		{
			event = "open:atm",
			icon = "fas fa-wallet",
			label = "ATM",
		--	job = "all"
		},
	},
	distance = 2
})

RegisterNetEvent('open:atm')
AddEventHandler('open:atm', function()
      TriggerEvent('atm:open')
end)

RegisterNetEvent("atm:open")
AddEventHandler("atm:open", function(msg)
local ped = GetPlayerPed(-1)
local dict = 'anim@amb@prop_human_atm@interior@male@enter'
local anim = 'enter'
	
  if not functional then
	ESX.ShowNotification('Banks and ATMs are currently closed due to the on-going bank robbery.')
    return
  end

    if NearATM() and not isBankOpened and NearATM() ~= "update" then
    ESX.TriggerServerCallback("oliann_banking:GetPIN", function(pin)
        if pin then
            if not isBankOpened then
	            	isBankOpened = true
					RequestAnimDict(dict)

					while not HasAnimDictLoaded(dict) do
					   Citizen.Wait(7)
					end

					TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
					Citizen.Wait(Config.AnimTime)
					ClearPedTasks(ped)

			        SetNuiFocus(true, true)
					SendNUIMessage({
					action = 'atm',
					pin = pin,
				 })
				end
			else
			   ESX.ShowNotification('[BANK]: Head up to a bank to set a PIN code.')
			end
		end)
    end
end)

RegisterNetEvent('atm:forvip')
AddEventHandler("atm:forvip", function(msg)
local ped = GetPlayerPed(-1)
local anim = 'enter'
	
  if not functional then
	ESX.ShowNotification('[BANK]: Banks and ATMs are currently closed due to the on-going bank robbery.')
    return
  end

    if not isBankOpened and "update" then
    ESX.TriggerServerCallback("oliann_banking:GetPIN", function(pin)
        if pin then
            if not isBankOpened then
	            	isBankOpened = true

			        SetNuiFocus(true, true)
					SendNUIMessage({
					action = 'atm',
					pin = pin,
				 })
				end
			else
			   ESX.ShowNotification('[BANK]: Head up to a bank to set a PIN code.')
			end
		end)
    end
end)

function openBank()
	local hasJob = false
	local playeJob = ESX.GetPlayerData().job
	local playerJobName = ''
	local playerJobGrade = ''
	local jobLabel = ''
	isBankOpened = true

	canAccessSociety = false

	if playeJob ~= nil then
		hasJob = true
		playerJobName = playeJob.name
		playerJobGrade = playeJob.grade_name
		jobLabel = playeJob.label
		society = 'society_'..playerJobName
	end

	ESX.TriggerServerCallback("oliann_banking:GetPlayerInfo", function(data)
		ESX.TriggerServerCallback("oliann_banking:GetOverviewTransactions", function(cb, identifier, allDays)
			for k,v in pairs(Config.Societies) do
				if playerJobName == v then
					if json.encode(Config.SocietyAccessRanks) ~= '[]' then
						for k2,v2 in pairs(Config.SocietyAccessRanks) do
							if playerJobGrade == v2 then
								canAccessSociety = true
							end
						end
					else
						canAccessSociety = true
					end
				end
			end

			if canAccessSociety then
				ESX.TriggerServerCallback("oliann_banking:SocietyInfo", function(cb)
					if cb ~= nil then
						societyInfo = cb
					else
						local societyIban = Config.IBANPrefix..jobLabel
						TriggerServerEvent("oliann_banking:CreateSocietyAccount", society, jobLabel, 0, societyIban)
						Citizen.Wait(200)
						ESX.TriggerServerCallback("oliann_banking:SocietyInfo", function(cb)
							societyInfo = cb
						end, society)
					end
				end, society)
			end

			isBankOpened = true
			trans = cb
			playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney = data.playerName, data.playerBankMoney, data.playerIBAN, identifier, allDays, data.walletMoney
			ESX.TriggerServerCallback("oliann_banking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
				societyIdent = societyID
				societyDays = societyAllDays
				societyTrans = societyTranscb
				if data.playerIBAN ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'bankmenu',
						playerName = data.playerName,
						playerSex = data.sex,
						playerBankMoney = data.playerBankMoney,
						walletMoney = walletMoney,
						playerIBAN = data.playerIBAN,
						db = trans,
						identifier = trsIdentifier,
						graphDays = allDaysValues,
						isInSociety = canAccessSociety,
					})
				else
					GenerateIBAN()
					Citizen.Wait(1000)
					ESX.TriggerServerCallback("oliann_banking:GetPlayerInfo", function(data)
						SetNuiFocus(true, true)
						SendNUIMessage({
							action = 'bankmenu',
							playerName = data.playerName,
							playerSex = data.sex,
							playerBankMoney = data.playerBankMoney,
							walletMoney = walletMoney,
							playerIBAN = data.playerIBAN,
							db = trans,
							identifier = trsIdentifier,
							graphDays = allDaysValues,
							isInSociety = canAccessSociety,
						})
					end)
				end
			end, society)
		end)
	end)
end

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
	elseif data.action == "deposit" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				if data.window == 'bankmenu' then
					TriggerServerEvent('oliann_banking:DepositMoney', tonumber(data.value))
				elseif data.window == 'societies' then
					TriggerServerEvent('oliann_banking:DepositMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name)
				end
			else
				ESX.ShowNotification('[BANK]: Invalid amount.')
			end
		else
			ESX.ShowNotification('[BANK]: Invalid Input.')
		end
	elseif data.action == "withdraw" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				if data.window == 'bankmenu' then
					TriggerServerEvent('oliann_banking:WithdrawMoney', tonumber(data.value))
				elseif data.window == 'societies' then
					TriggerServerEvent('oliann_banking:WithdrawMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name, societyInfo.value)
				end
			else
				ESX.ShowNotification('[BANK]: Invalid amount.')
			end
		else
			ESX.ShowNotification('[BANK]: Invalid Input.')
		end
	elseif data.action == "transfer" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				ESX.TriggerServerCallback("oliann_banking:IsIBanUsed", function(isUsed, isPlayer)
					if isUsed ~= nil then
						if data.window == 'bankmenu' then
							if isPlayer then
								TriggerServerEvent('oliann_banking:TransferMoney', tonumber(data.value), data.iban:upper(), isUsed.identifier, isUsed.accounts, isUsed.name)
							elseif not isPlayer then
								TriggerServerEvent('oliann_banking:TransferMoneyToSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society)
							end
						elseif data.window == 'societies' then
							local toMyself = false
							if data.iban:upper() == playerIBAN then
								toMyself = true
							end

							if isPlayer then
								TriggerServerEvent('oliann_banking:TransferMoneyToPlayerFromSociety', tonumber(data.value), data.iban:upper(), isUsed.identifier, isUsed.accounts, isUsed.name, societyInfo.society, societyInfo.society_name, societyInfo.value, toMyself)
							elseif not isPlayer then
								TriggerServerEvent('oliann_banking:TransferMoneyToSocietyFromSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society, societyInfo.society, societyInfo.society_name, societyInfo.value)
							end
						end
					elseif isUsed == nil then
						ESX.ShowNotification('[BANK]: This IBAN does not exist.')
					end
				end, data.iban:upper())
			else
				ESX.ShowNotification('[BANK]: Invalid amount.')
			end
		else
			ESX.ShowNotification('[BANK]: Invalid Input.')
		end
	elseif data.action == "overview_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'overview_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			playerIBAN = playerIBAN,
			db = trans,
			identifier = trsIdentifier,
			graphDays = allDaysValues,
			isInSociety = canAccessSociety,
		})
	elseif data.action == "transactions_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'transactions_page',
			db = trans,
			identifier = trsIdentifier,
			graph_values = allDaysValues,
			isInSociety = canAccessSociety,
		})
	elseif data.action == "society_transactions" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_transactions',
			db = societyTrans,
			identifier = societyIdent,
			graph_values = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "society_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			playerIBAN = playerIBAN,
			db = societyTrans,
			identifier = societyIdent,
			graphDays = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "settings_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'settings_page',
			isInSociety = canAccessSociety,
			ibanCost = Config.IBANChangeCost,
			ibanPrefix = Config.IBANPrefix,
			ibanCharNum = Config.CustomIBANMaxChars,
			pinCost = Config.PINChangeCost,
			pinCharNum = 4,
		})
	elseif data.action == "atm" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Citizen.Wait(500)
		openBank()
	elseif data.action == "change_iban" then
		if Config.CustomIBANAllowLetters then
			local iban = Config.IBANPrefix..data.iban:upper()
			
			ESX.TriggerServerCallback("oliann_banking:IsIBanUsed", function(isUsed, isPlayer)

				if isUsed == nil then
					TriggerServerEvent('oliann_banking:UpdateIbanDB', iban, Config.IBANChangeCost)
				elseif isUsed ~= nil then
					ESX.ShowNotification('[BANK]: This IBAN is already in use.')
				end
			end, iban)
		elseif not Config.CustomIBANAllowLetters then
			if tonumber(data.iban) ~= nil then
				local iban = Config.IBANPrefix..data.iban:upper()
				
				ESX.TriggerServerCallback("oliann_banking:IsIBanUsed", function(isUsed, isPlayer)

					if isUsed == nil then
						TriggerServerEvent('oliann_banking:UpdateIbanDB', iban, Config.IBANChangeCost)
					elseif isUsed ~= nil then
						ESX.ShowNotification('[BANK]: This IBAN is already in use.')
					end
				end, iban)
			else
				ESX.ShowNotification('[BANK]: You can only use numbers on your IBAN.')
			end
		end
	elseif data.action == "change_pin" then
		if tonumber(data.pin) ~= nil then
			if string.len(data.pin) == 4 then
				TriggerServerEvent('oliann_banking:UpdatePINDB', data.pin, Config.PINChangeCost)
			else
				ESX.ShowNotification('[BANK]: Your PIN needs to be 4 digits long.')
			end
		else
			ESX.ShowNotification('[BANK]: You can only use numbers.')
		end
	end
end)

RegisterNetEvent("oliann_banking:updateTransactions")
AddEventHandler("oliann_banking:updateTransactions", function(money, wallet)
	Citizen.Wait(100)
	if isBankOpened then
		ESX.TriggerServerCallback("oliann_banking:GetOverviewTransactions", function(cb, id, allDays)
			trans = cb
			allDaysValues = allDays
			SetNuiFocus(true, true)
			SendNUIMessage({
				action = 'overview_page',
				playerBankMoney = playerBankMoney,
				walletMoney = walletMoney,
				playerIBAN = playerIBAN,
				db = trans,
				identifier = trsIdentifier,
				graphDays = allDaysValues,
				isInSociety = canAccessSociety,
			})
			TriggerEvent('oliann_banking:updateMoney', money, wallet)
		end)
	end
end)

RegisterNetEvent("oliann_banking:updateMoney")
AddEventHandler("oliann_banking:updateMoney", function(money, wallet)
	if isBankOpened then
		playerBankMoney = money
		walletMoney = wallet
		SendNUIMessage({
			action = 'updatevalue',
			playerBankMoney = money,
			walletMoney = wallet,
		})
	end
end)

RegisterNetEvent("oliann_banking:updateIban")
AddEventHandler("oliann_banking:updateIban", function(iban)
	playerIBAN = iban
	SendNUIMessage({
		action = 'updateiban',
		iban = playerIBAN,
	})
end)

RegisterNetEvent("oliann_banking:updateIbanPinChange")
AddEventHandler("oliann_banking:updateIbanPinChange", function()
	Citizen.Wait(100)
	ESX.TriggerServerCallback("oliann_banking:GetOverviewTransactions", function(cbs, ids, allDays)
		trans = cbs
	end)
end)

RegisterNetEvent("oliann_banking:updateTransactionsSociety")
AddEventHandler("oliann_banking:updateTransactionsSociety", function(wallet)
	Citizen.Wait(100)
	ESX.TriggerServerCallback("oliann_banking:SocietyInfo", function(cb)
		ESX.TriggerServerCallback("oliann_banking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
			ESX.TriggerServerCallback("oliann_banking:GetOverviewTransactions", function(cbs, ids, allDays)
				trans = cbs
				walletMoney = wallet
				societyDays = societyAllDays
				societyIdent = societyID
				societyTrans = societyTranscb
				societyInfo = cb
				if cb ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'society_page',
						walletMoney = wallet,
						db = societyTrans,
						graphDays = societyDays,
						isInSociety = canAccessSociety,
						societyInfo = societyInfo,
					})
				else

				end
			end)
		end, society)
	end, society)
end)

function GenerateIBAN()
	math.randomseed(GetGameTimer())
	local stringFormat = "%0"..Config.IBANNumbers.."d"
	local number = math.random(0, 10^Config.IBANNumbers-1)
	number = string.format(stringFormat, number)
	local iban = Config.IBANPrefix..number:upper()
	local isIBanUsed = true
	local hasChecked = false

	while true do
		Citizen.Wait(10)
		if isIBanUsed and not hasChecked then
			isIBanUsed = false
			ESX.TriggerServerCallback("oliann_banking:IsIBanUsed", function(isUsed)
				if isUsed ~= nil then
					isIBanUsed = true
					number = math.random(0, 10^Config.IBANNumbers-1)
					number = string.format("%03d", number)
					iban = Config.IBANPrefix..number:upper()
				elseif isUsed == nil then
					hasChecked = true
					isIBanUsed = false
				end
				canLoop = true
			end, iban)
		elseif not isIBanUsed and hasChecked then
			break
		end
	end
	TriggerServerEvent('oliann_banking:SetIBAN', iban)
end