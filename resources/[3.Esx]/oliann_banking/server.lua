ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local CurrentBankState = true

RegisterCommand('togglebanks', function(source, args)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	if xPlayer.job.name == 'police' then
	--if xPlayer.job.name == 'police' and (xPlayer.job.grade == 3 or xPlayer.job.grade == 8) then
		CurrentBankState = not CurrentBankState
		local state = (CurrentBankState == false) and "DISABLED" or "ENABLED"
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Bank has been '.. state)
		TriggerClientEvent('bank:closeBanks', -1, CurrentBankState)
	end
end)

ESX.RegisterServerCallback("oliann_banking:GetPlayerInfo", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	MySQL.Async.fetchAll('SELECT * FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local db = result[1]
		local data = {
			playerName = xPlayer.getName(),
			playerBankMoney = xPlayer.getAccount('bank').money,
			playerIBAN = db.iban,
			walletMoney = xPlayer.getMoney(),
			sex = db.sex,
		}

		cb(data)
	end)
end)

ESX.RegisterServerCallback("oliann_banking:IsIBanUsed", function(source, cb, iban)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT * FROM users WHERE iban = @iban', {
		['@iban'] = iban
	}, function(result)
		local db = result[1]
		if db ~= nil then
			
			cb(db, true)
		else
			MySQL.Async.fetchAll('SELECT * FROM oliann_banking_societies WHERE iban = @iban', {
				['@iban'] = iban
			}, function(result2)
				local db2 = result2[1]
				
				cb(db2, false)
			end)
		end
	end)
end)

ESX.RegisterServerCallback("oliann_banking:GetPIN", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	
	MySQL.Async.fetchAll('SELECT pincode FROM users WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
	}, function(result)
		local pin = result[1]

		cb(pin.pincode)
	end)
end)

ESX.RegisterServerCallback("oliann_banking:SocietyInfo", function(source, cb, society)
	MySQL.Async.fetchAll('SELECT * FROM oliann_banking_societies WHERE society = @society', {
		['@society'] = society
	}, function(result)
		local db = result[1]
		cb(db)
	end)
end)

RegisterServerEvent("oliann_banking:CreateSocietyAccount")
AddEventHandler("oliann_banking:CreateSocietyAccount", function(society, society_name, value, iban)
	MySQL.Async.insert('INSERT INTO oliann_banking_societies (society, society_name, value, iban) VALUES (@society, @society_name, @value, @iban)', {
		['@society'] = society,
		['@society_name'] = society_name,
		['@value'] = value,
		['@iban'] = iban:upper(),
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:SetIBAN")
AddEventHandler("oliann_banking:SetIBAN", function(iban)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('UPDATE users SET iban = @iban WHERE identifier = @identifier', {
		['@identifier'] = xPlayer.identifier,
		['@iban'] = iban,
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:DepositMoney")
AddEventHandler("oliann_banking:DepositMoney", function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if amount <= playerMoney then
		xPlayer.removeAccountMoney('money', amount)
		xPlayer.addAccountMoney('bank', amount)

		TriggerEvent('oliann_banking:AddDepositTransaction', amount, source)
		TriggerClientEvent('oliann_banking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
		TriggerClientEvent('esx:showNotification', source, '[BANK]: You have deposited '..amount..'$.')
	else
		TriggerClientEvent('esx:showNotification', source, '[BANK]: You dont have that much money on you.')
	end
end)

RegisterServerEvent("oliann_banking:WithdrawMoney")
AddEventHandler("oliann_banking:WithdrawMoney", function(amount)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getAccount('bank').money

	if amount <= playerMoney then
		xPlayer.removeAccountMoney('bank', amount)
		xPlayer.addAccountMoney('money', amount)
		
		TriggerEvent('oliann_banking:AddWithdrawTransaction', amount, source)
		TriggerClientEvent('oliann_banking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You have withdrawn "..amount.."$")
	else
		TriggerClientEvent('esx:showNotification', source, '[BANK]: You dont have that much money on the bank')
	end
end)

RegisterServerEvent("oliann_banking:TransferMoney")
AddEventHandler("oliann_banking:TransferMoney", function(amount, ibanNumber, targetIdentifier, acc, targetName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
	local xPlayers = ESX.GetPlayers()
	local playerMoney = xPlayer.getAccount('bank').money
	ibanNumber = ibanNumber:upper()
	if xPlayer.identifier ~= targetIdentifier then
		if amount <= playerMoney then
			
			if xTarget ~= nil then
				xPlayer.removeAccountMoney('bank', amount)
				xTarget.addAccountMoney('bank', amount)

				for i=1, #xPlayers, 1 do
				    local xForPlayer = ESX.GetPlayerFromId(xPlayers[i])
				    if xForPlayer.identifier == targetIdentifier then

				    	TriggerClientEvent('oliann_banking:updateTransactions', xPlayers[i], xTarget.getAccount('bank').money, xTarget.getMoney())
						TriggerClientEvent('esx:showNotification', xPlayers[i], "[BANK]: You have received "..amount.."$ from "..xPlayer.getName())
				    end
				end
				TriggerEvent('oliann_banking:AddTransferTransaction', amount, xTarget, source)
				TriggerClientEvent('oliann_banking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
				TriggerClientEvent('esx:showNotification', source, "[BANK]: You have transferred "..amount.."$ to "..xTarget.getName())
			elseif xTarget == nil then
				local playerAccount = json.decode(acc)
				playerAccount.bank = playerAccount.bank + amount
				playerAccount = json.encode(playerAccount)

				xPlayer.removeAccountMoney('bank', amount)

				TriggerEvent('oliann_banking:AddTransferTransaction', amount, xTarget, source, targetName, targetIdentifier)
				TriggerClientEvent('oliann_banking:updateTransactions', source, xPlayer.getAccount('bank').money, xPlayer.getMoney())
				TriggerClientEvent('esx:showNotification', source, "[BANK]: You have transferred "..amount.."$ to "..targetName)

				MySQL.Async.execute('UPDATE users SET accounts = @playerAccount WHERE identifier = @target', {
					['@playerAccount'] = playerAccount,
					['@target'] = targetIdentifier
				}, function(changed)

				end)
			end
		else
			TriggerClientEvent('esx:showNotification', source, "[BANK]: You don't have that much money on the bank")
		end
	else
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You can't send money to yourself")
	end
end)

RegisterServerEvent("oliann_banking:DepositMoneyToSociety")
AddEventHandler("oliann_banking:DepositMoneyToSociety", function(amount, society, societyName)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getMoney()

	if amount <= playerMoney then
		MySQL.Async.execute('UPDATE oliann_banking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
		xPlayer.removeAccountMoney('money', amount)

		TriggerEvent('oliann_banking:AddDepositTransactionToSociety', amount, source, society, societyName)
		TriggerClientEvent('oliann_banking:updateTransactionsSociety', source, xPlayer.getMoney())
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You have deposited "..amount.."$ to "..societyName)
	else
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You don't have that much money on you")
	end
end)

RegisterServerEvent("oliann_banking:WithdrawMoneyToSociety")
AddEventHandler("oliann_banking:WithdrawMoneyToSociety", function(amount, society, societyName, societyMoney)
	local xPlayer = ESX.GetPlayerFromId(source)
	local _source = source
	local db
	local hasChecked = false

	MySQL.Async.fetchAll('SELECT * FROM oliann_banking_societies WHERE society = @society', {
		['@society'] = society
	}, function(result)
		db = result[1]
		hasChecked = true
	end)

	MySQL.Async.execute('UPDATE oliann_banking_societies SET is_withdrawing = 1 WHERE society = @society AND society_name = @society_name', {
		['@value'] = amount,
		['@society'] = society,
		['@society_name'] = societyName,
	}, function(changed)
	end)

	while not hasChecked do 
		Citizen.Wait(100)
	end
	
	if amount <= db.value then
		if db.is_withdrawing == 1 then
			TriggerClientEvent('esx:showNotification', _source, "[BANK]: Someone is already withdrawing")
		else

			MySQL.Async.execute('UPDATE oliann_banking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
				['@value'] = amount,
				['@society'] = society,
				['@society_name'] = societyName,
			}, function(changed)
			end)
			
			xPlayer.addAccountMoney('money', amount)
			--xPlayer.addAccountMoney('bank', amount)
			TriggerEvent('oliann_banking:AddWithdrawTransactionToSociety', amount, _source, society, societyName)
			TriggerClientEvent('oliann_banking:updateTransactionsSociety', _source, xPlayer.getMoney())
			TriggerClientEvent('esx:showNotification', _source, "[BANK]: You have withdrawn "..amount.."$ from "..societyName)
		end
	else
		TriggerClientEvent('esx:showNotification', _source, "[BANK]: Your society doesn't have that much money on the bank")
	end

	MySQL.Async.execute('UPDATE oliann_banking_societies SET is_withdrawing = 0 WHERE society = @society AND society_name = @society_name', {
		['@value'] = amount,
		['@society'] = society,
		['@society_name'] = societyName,
	}, function(changed)
	end)
end)

RegisterServerEvent("oliann_banking:TransferMoneyToSociety")
AddEventHandler("oliann_banking:TransferMoneyToSociety", function(amount, ibanNumber, societyName, society)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerMoney = xPlayer.getAccount('bank').money

		if amount <= playerMoney then
			MySQL.Async.execute('UPDATE oliann_banking_societies SET value = value + @value WHERE iban = @iban', {
				['@value'] = amount,
				['@iban'] = ibanNumber
			}, function(changed)
			end)
			xPlayer.removeAccountMoney('bank', amount)
			TriggerEvent('oliann_banking:AddTransferTransactionToSociety', amount, source, society, societyName)
			TriggerClientEvent('oliann_banking:updateTransactionsSociety', source, xPlayer.getMoney())
			TriggerClientEvent('esx:showNotification', source, "[BANK]: You have transferred "..amount.."$ to "..societyName)
		else
			TriggerClientEvent('esx:showNotification', source, "[BANK]: You don't have that much money on the bank")
		end
end)

RegisterServerEvent("oliann_banking:TransferMoneyToSocietyFromSociety")
AddEventHandler("oliann_banking:TransferMoneyToSocietyFromSociety", function(amount, ibanNumber, societyNameTarget, societyTarget, society, societyName, societyMoney)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
	local xPlayers = ESX.GetPlayers()

	if amount <= societyMoney then
		MySQL.Async.execute('UPDATE oliann_banking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
		MySQL.Async.execute('UPDATE oliann_banking_societies SET value = value + @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = societyTarget,
			['@society_name'] = societyNameTarget,
		}, function(changed)
		end)
		TriggerEvent('oliann_banking:AddTransferTransactionFromSociety', amount, society, societyName, societyTarget, societyNameTarget)
		TriggerClientEvent('oliann_banking:updateTransactionsSociety', source, xPlayer.getMoney())
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You have transferred "..amount.."$ to "..societyNameTarget)
	else
		TriggerClientEvent('esx:showNotification', source, "[BANK]: Your society doesn't have that much money on the bank")
	end
end)

RegisterServerEvent("oliann_banking:TransferMoneyToPlayerFromSociety")
AddEventHandler("oliann_banking:TransferMoneyToPlayerFromSociety", function(amount, ibanNumber, targetIdentifier, acc, targetName, society, societyName, societyMoney, toMyself)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xTarget = ESX.GetPlayerFromIdentifier(targetIdentifier)
	local xPlayers = ESX.GetPlayers()

	if amount <= societyMoney then
		MySQL.Async.execute('UPDATE oliann_banking_societies SET value = value - @value WHERE society = @society AND society_name = @society_name', {
			['@value'] = amount,
			['@society'] = society,
			['@society_name'] = societyName,
		}, function(changed)
		end)
		if xTarget ~= nil then
			xTarget.addAccountMoney('bank', amount)
			if not toMyself then
				for i=1, #xPlayers, 1 do
				    local xForPlayer = ESX.GetPlayerFromId(xPlayers[i])
				    if xForPlayer.identifier == targetIdentifier then
				    	--TriggerClientEvent('oliann_banking:updateMoney', xPlayers[i], xTarget.getAccount('bank').money)
			    	
			    		TriggerClientEvent('oliann_banking:updateTransactions', xPlayers[i], xTarget.getAccount('bank').money, xTarget.getMoney())
						TriggerClientEvent('esx:showNotification', xPlayers[i], "[BANK]: You have received "..amount.."$ from "..xPlayer.getName())
				    end
				end
			end
			TriggerEvent('oliann_banking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			TriggerClientEvent('oliann_banking:updateTransactionsSociety', source, xPlayer.getMoney())
			TriggerClientEvent('esx:showNotification', source, "[BANK]: You have transferred "..amount.."$ to "..xTarget.getName())
		elseif xTarget == nil then
			local playerAccount = json.decode(acc)
			playerAccount.bank = playerAccount.bank + amount
			playerAccount = json.encode(playerAccount)

			--xPlayer.removeAccountMoney('bank', amount)

			--TriggerClientEvent('oliann_banking:updateMoney', source, xPlayer.getAccount('bank').money)
			TriggerEvent('oliann_banking:AddTransferTransactionFromSocietyToP', amount, society, societyName, targetIdentifier, targetName)
			TriggerClientEvent('oliann_banking:updateTransactionsSociety', source, xPlayer.getMoney())
			TriggerClientEvent('esx:showNotification', source, "[BANK]: You have transferred "..amount.."$ to "..targetName)

			MySQL.Async.execute('UPDATE users SET accounts = @playerAccount WHERE identifier = @target', {
				['@playerAccount'] = playerAccount,
				['@target'] = targetIdentifier
			}, function(changed)

			end)
		end
	else
		TriggerClientEvent('esx:showNotification', source, "[BANK]: Your society doesn't have that much money on the bank")
	end
end)

ESX.RegisterServerCallback("oliann_banking:GetOverviewTransactions", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local playerIdentifier = xPlayer.identifier
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.Async.fetchAll('SELECT * FROM oliann_banking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = playerIdentifier
	}, function(result)
		MySQL.Async.fetchAll('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `oliann_banking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY', {

		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)

ESX.RegisterServerCallback("oliann_banking:GetSocietyTransactions", function(source, cb, society)
	local playerIdentifier = society
	local allDays = {}
	local income = 0
	local outcome = 0
	local totalIncome = 0
	local day1_total, day2_total, day3_total, day4_total, day5_total, day6_total, day7_total = 0, 0, 0, 0, 0, 0, 0

	MySQL.Async.fetchAll('SELECT * FROM oliann_banking_transactions WHERE receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
		['@identifier'] = society
	}, function(result)
		MySQL.Async.fetchAll('SELECT *, DATE(date) = CURDATE() AS "day1", DATE(date) = CURDATE() - INTERVAL 1 DAY AS "day2", DATE(date) = CURDATE() - INTERVAL 2 DAY AS "day3", DATE(date) = CURDATE() - INTERVAL 3 DAY AS "day4", DATE(date) = CURDATE() - INTERVAL 4 DAY AS "day5", DATE(date) = CURDATE() - INTERVAL 5 DAY AS "day6", DATE(date) = CURDATE() - INTERVAL 6 DAY AS "day7" FROM `oliann_banking_transactions` WHERE DATE(date) >= CURDATE() - INTERVAL 7 DAY AND receiver_identifier = @identifier OR sender_identifier = @identifier ORDER BY id DESC', {
			['@identifier'] = society
		}, function(result2)
			for k, v in pairs(result2) do
				local type = v.type
				local receiver_identifier = v.receiver_identifier
				local sender_identifier = v.sender_identifier
				local value = tonumber(v.value)

				if v.day1 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day1_total = day1_total + value
							income = income + value
						elseif type == "withdraw" then
							day1_total = day1_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day1_total = day1_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day1_total = day1_total - value
							outcome = outcome - value
						end
					end
					
				elseif v.day2 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day2_total = day2_total + value
							income = income + value
						elseif type == "withdraw" then
							day2_total = day2_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day2_total = day2_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day2_total = day2_total - value
							outcome = outcome - value
						end
					end

				elseif v.day3 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day3_total = day3_total + value
							income = income + value
						elseif type == "withdraw" then
							day3_total = day3_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day3_total = day3_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day3_total = day3_total - value
							outcome = outcome - value
						end
					end

				elseif v.day4 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day4_total = day4_total + value
							income = income + value
						elseif type == "withdraw" then
							day4_total = day4_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day4_total = day4_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day4_total = day4_total - value
							outcome = outcome - value
						end
					end

				elseif v.day5 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day5_total = day5_total + value
							income = income + value
						elseif type == "withdraw" then
							day5_total = day5_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day5_total = day5_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day5_total = day5_total - value
							outcome = outcome - value
						end
					end

				elseif v.day6 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day6_total = day6_total + value
							income = income + value
						elseif type == "withdraw" then
							day6_total = day6_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day6_total = day6_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day6_total = day6_total - value
							outcome = outcome - value
						end
					end

				elseif v.day7 == 1 then
					if value ~= nil then
						if type == "deposit" then
							day7_total = day7_total + value
							income = income + value
						elseif type == "withdraw" then
							day7_total = day7_total - value
							outcome = outcome - value
						elseif type == "transfer" and receiver_identifier == playerIdentifier then
							day7_total = day7_total + value
							income = income + value
						elseif type == "transfer" and sender_identifier == playerIdentifier then
							day7_total = day7_total - value
							outcome = outcome - value
						end
					end

				end
			end

			totalIncome = day1_total + day2_total + day3_total + day4_total + day5_total + day6_total + day7_total

			table.remove(allDays)
			table.insert(allDays, day1_total)
			table.insert(allDays, day2_total)
			table.insert(allDays, day3_total)
			table.insert(allDays, day4_total)
			table.insert(allDays, day5_total)
			table.insert(allDays, day6_total)
			table.insert(allDays, day7_total)
			table.insert(allDays, income)
			table.insert(allDays, outcome)
			table.insert(allDays, totalIncome)

			cb(result, playerIdentifier, allDays)
		end)
	end)
end)


RegisterServerEvent("oliann_banking:AddDepositTransaction")
AddEventHandler("oliann_banking:AddDepositTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = 'bank',
		['@receiver_name'] = 'Bank Account',
		['@sender_identifier'] = tostring(xPlayer.identifier),
		['@sender_name'] = tostring(xPlayer.getName()),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:AddWithdrawTransaction")
AddEventHandler("oliann_banking:AddWithdrawTransaction", function(amount, source_)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.identifier),
		['@receiver_name'] = tostring(xPlayer.getName()),
		['@sender_identifier'] = 'bank',
		['@sender_name'] = 'Bank Account',
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:AddTransferTransaction")
AddEventHandler("oliann_banking:AddTransferTransaction", function(amount, xTarget, source_, targetName, targetIdentifier)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)
	if targetName == nil then
		MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(xTarget.identifier),
			['@receiver_name'] = tostring(xTarget.getName()),
			['@sender_identifier'] = tostring(xPlayer.identifier),
			['@sender_name'] = tostring(xPlayer.getName()),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	elseif targetName ~= nil and targetIdentifier ~= nil then
		MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
			['@receiver_identifier'] = tostring(targetIdentifier),
			['@receiver_name'] = tostring(targetName),
			['@sender_identifier'] = tostring(xPlayer.identifier),
			['@sender_name'] = tostring(xPlayer.getName()),
			['@value'] = tonumber(amount),
			['@type'] = 'transfer'
		}, function (result)
		end)
	end
end)

RegisterServerEvent("oliann_banking:AddTransferTransactionToSociety")
AddEventHandler("oliann_banking:AddTransferTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)
	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.identifier),
		['@sender_name'] = tostring(xPlayer.getName()),
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:AddTransferTransactionFromSocietyToP")
AddEventHandler("oliann_banking:AddTransferTransactionFromSocietyToP", function(amount, society, societyName, identifier, name)

	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = identifier,
		['@receiver_name'] = name,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:AddTransferTransactionFromSociety")
AddEventHandler("oliann_banking:AddTransferTransactionFromSociety", function(amount, society, societyName, societyTarget, societyNameTarget)
	
	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = societyTarget,
		['@receiver_name'] = societyNameTarget,
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'transfer'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:AddDepositTransactionToSociety")
AddEventHandler("oliann_banking:AddDepositTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = society,
		['@receiver_name'] = societyName,
		['@sender_identifier'] = tostring(xPlayer.identifier),
		['@sender_name'] = tostring(xPlayer.getName()),
		['@value'] = tonumber(amount),
		['@type'] = 'deposit'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:AddWithdrawTransactionToSociety")
AddEventHandler("oliann_banking:AddWithdrawTransactionToSociety", function(amount, source_, society, societyName)
	local _source = nil
	if source_ ~= nil then
		_source = source_
	else
		_source = source
	end

	local xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.insert('INSERT INTO oliann_banking_transactions (receiver_identifier, receiver_name, sender_identifier, sender_name, date, value, type) VALUES (@receiver_identifier, @receiver_name, @sender_identifier, @sender_name, CURRENT_TIMESTAMP(), @value, @type)', {
		['@receiver_identifier'] = tostring(xPlayer.identifier),
		['@receiver_name'] = tostring(xPlayer.getName()),
		['@sender_identifier'] = society,
		['@sender_name'] = societyName,
		['@value'] = tonumber(amount),
		['@type'] = 'withdraw'
	}, function (result)
	end)
end)

RegisterServerEvent("oliann_banking:UpdateIbanDB")
AddEventHandler("oliann_banking:UpdateIbanDB", function(iban, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.IBANChangeCost <= xPlayer.getAccount('bank').money then
		MySQL.Async.execute('UPDATE users SET iban = @iban WHERE identifier = @identifier', {
			['@iban'] = iban,
			['@identifier'] = xPlayer.identifier,
		}, function(changed)
		end)

		TriggerEvent('oliann_banking:AddTransferTransactionToSociety', amount, source, "bank", "Bank (IBAN)")
		TriggerClientEvent('oliann_banking:updateIban', source, iban)
		TriggerClientEvent('oliann_banking:updateIbanPinChange', source)
		TriggerClientEvent('esx:showNotification', source, "[BANK]: IBAN successfully changed to "..iban)
	else
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You need to have "..Config.IBANChangeCost.."$ in order to change your IBAN")
	end
end)

RegisterServerEvent("oliann_banking:UpdatePINDB")
AddEventHandler("oliann_banking:UpdatePINDB", function(pin, amount)
	local xPlayer = ESX.GetPlayerFromId(source)

	if Config.PINChangeCost <= xPlayer.getAccount('bank').money then
		MySQL.Async.execute('UPDATE users SET pincode = @pin WHERE identifier = @identifier', {
			['@pin'] = pin,
			['@identifier'] = xPlayer.identifier,
		}, function(changed)
		end)

		TriggerEvent('oliann_banking:AddTransferTransactionToSociety', amount, source, "bank", "Bank (PIN)")
		TriggerClientEvent('oliann_banking:updateIbanPinChange', source)
		TriggerClientEvent('esx:showNotification', source, "[BANK]: PIN successfully changed to "..pin)
		
	else
		TriggerClientEvent('esx:showNotification', source, "[BANK]: You need to have "..Config.PINChangeCost.."$ in order to change your PIN")
	end
end)