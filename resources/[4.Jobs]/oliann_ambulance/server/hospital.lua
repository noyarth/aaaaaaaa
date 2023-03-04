
ESX 				= nil
local defaultsecs   = 180
local maxsecs 		= 1200

-----------------------------

--ESX base
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

local xPlayers 		= ESX.GetPlayers()

AddEventHandler('chatMessage', function(source, n, message)
cm = stringsplit(message, " ")
local xPlayer 		= ESX.GetPlayerFromId(source)

----------------------------------------------------------------------------
----------------------------- RELEASE COMMAND -------------------------------
-----------------------------------------------------------------------------
if cm[1] == "/rel" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    if GetPlayerName(tPID) ~= nil then
      print("Released: ".. GetPlayerName(tPID).. " by ".. GetPlayerName(source))
      TriggerClientEvent("UnHB", tPID)
    end
    TriggerEvent('HRelease', tPID)
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------
  ----------------------------- PILLBOX -----------------------------
  -------------------------------------------------------------------
  ----------------------------- BED 1 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB1", tPID, hT)
      -- TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 1!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------
  ----------------------------- BED 2 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB2", tPID, hT)
      -- TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 2!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------
  ----------------------------- BED 3 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed3" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB3",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB3", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 3!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------
  ----------------------------- BED 4 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed4" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB4",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB4", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 4!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------
  ----------------------------- BED 5 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed5" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB5",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB5", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 5!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
  -------------------------------------------------------------------
  ----------------------------- BED 6 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed6" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB6",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB6", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 6!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
   -------------------------------------------------------------------
  ----------------------------- BED 7 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed7" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB7",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB7", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 7!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
  -------------------------------------------------------------------
  ----------------------------- BED 8 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed8" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB8",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB8", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 8!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------
  ----------------------------- BED 9 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed9" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB9",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB9", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 9!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
   -------------------------------------------------------------------
  ----------------------------- BED 10 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed10" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB10",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB10", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 10!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
   -------------------------------------------------------------------
  ----------------------------- BED 11 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed11" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB11",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB11", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 11!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
  
   -------------------------------------------------------------------
  ----------------------------- BED 12 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed12" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB12",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB12", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 12!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
  -------------------------------------------------------------------
  ----------------------------- BED 13 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed13" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB13",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB13", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 13!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
   -------------------------------------------------------------------
  ----------------------------- BED 14 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed14" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB14",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB14", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to bed 14!', 'success', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  
   -------------------------------------------------------------------
  ----------------------------- BED 15 -------------------------------
  -------------------------------------------------------------------
elseif cm[1] == "/bed15" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "HB15",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("HB15", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 15!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 1 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/op1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "OP1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("OP1", tPID, hT)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You are Placed on Operation Bed 1!', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 2 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/op2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "OP2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("OP2", tPID, hT)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You are Placed on Operation Bed 2!', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 3 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/op3" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "OP3",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("OP3", tPID, hT)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You are Placed on Operation Bed 3!', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  ----------------------------------------------------------------------
  ----------------------------- MRI ROOM -------------------------------
  ----------------------------------------------------------------------
elseif cm[1] == "/mri" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for MRI")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "MRI",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("MRI", tPID, hT)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You are Placed on MRI Bed!', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  ------------------------------------------------------------------------
  ----------------------------- XRAY ROOM  -------------------------------
  ------------------------------------------------------------------------
elseif cm[1] == "/xry" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for XRay")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "XRY",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("XRY", tPID, hT)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You are Placed on XRay Bed!', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------------------
  ----------------------------- SPECIAL ROOM BED 1 -------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/pbed1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PHB1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PHB1", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to privated room bed 1', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------------------
  ----------------------------- SPECIAL ROOM BED 2 -------------------------------
  --------------------------------------------------------------------------------
elseif cm[1] == "/pbed2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PHB2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PHB2", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to privated room bed 2', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------------------
  ----------------------------- SPECIAL ROOM BED 3 -------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/pbed3" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PHB3",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PHB3", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to privated room bed 3', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------------------
  ----------------------------- SPECIAL ROOM BED 4 -------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/pbed4" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PHB4",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PHB4", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to privated room bed 4', 'info', 3000)
    end
  else
    TriggerCientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------------------
  ----------------------------- SPECIAL ROOM BED 5 -------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/pbed5" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PHB5",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PHB5", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to privated room bed 5', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  -------------------------------------------------------------------------------
  ----------------------------- SPECIAL ROOM BED 6 -------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/pbed6" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PHB6",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PHB6", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
 TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been admitted to privated room bed 6', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  ------------------------------------------------------------------------------
  ----------------------------- MORGUE -----------------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/dead" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Transferred: ".. GetPlayerName(tPID).. " to Morgue")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
	  local xPlayer = ESX.GetPlayerFromId(tPID)
	  local DATE = os.date(" %m.%d.%y | %H:%M ")
	  
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "DD1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("DD1", tPID, hT)
	  
	  -- TriggerClientEvent('chatMessage', -1, ' MEDICAL HOSPITAL', {255, 0, 0}, "^0  Condolence to ^2" ..xPlayer.name)
	  -- TriggerClientEvent('chatMessage', -1, ' TIME OF DEATH', {255, 0, 0}, "^0  "..DATE)

    TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.3vw;  margin: 0.2vw; background-color: rgba(245, 40, 145, 0.8);"><i class="fas fa-comment-slash"style="font-size:15px;color:black"></i> <b><font color="#000000">⚰️ MEDICAL HOSPITAL<b><font color="black">: &ensp;<font color="black">Condolence to '..xPlayer.name..'</font></div>'
     })
     TriggerClientEvent('chat:addMessage', -1, {
      template = '<div style="padding: 0.3vw;  margin: 0.2vw; background-color: rgba(245, 40, 145, 0.8);"><i class="fas fa-comment-slash"style="font-size:15px;color:black"></i> <b><font color="#000000">⚰️ TIME OF DEATH<b><font color="black">: &ensp;<font color="black">'..DATE..'</font></div>'
     })
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You have been transfered to morgue', 'info', 3000)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'You are Placed on Morgue Bed', 'info', 3000)
      TriggerClientEvent('idolo_notifications:showNotification', tPID, 'Wait the Coroner to <b style="color:orange">Release</b> You', 'info', 3000)
    end
  else
    TriggerClientEvent('idolo_notifications:showNotification', source, 'You are not allowed to do that!', 'error', 3000)
  end
  --------------------------
-----------------------------------------------------
  ----------------------------- SANDY SHORES ------------------------------------
  -------------------------------------------------------------------------------
  ----------------------------- BED 1 -------------------------------------------
  -------------------------------------------------------------------------------

elseif cm[1] == "/sbed1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SB1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SB1", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 1!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 2 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/sbed2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SB2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SB2", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 2!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 3 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/sbed3" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SB3",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SB3", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 3!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 4 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/sbed4" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SB4",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SB4", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 4!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 5 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/sbed5" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SB5",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SB5", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 5!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 6 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/sbed6" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SB6",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SB6", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 6!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 1 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/sp1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SP1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SP1", tPID, hT)
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You are Placed on Operation Bed 1!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 2 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/sp2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SP2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SP2", tPID, hT)
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You are Placed on Operation Bed 2!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 3 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/sp3" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "SP3",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("SP3", tPID, hT)
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You are Placed on Operation Bed 3!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- PALETO BAY ------------------------------------
  -------------------------------------------------------------------------------
  ----------------------------- BED 1 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/plbed1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PB1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PB1", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 1!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 2 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/plbed2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PB2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PB2", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 2!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 3 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/plbed3" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PB3",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PB3", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 3!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 4 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/plbed4" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PB4",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PB4", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 4!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  -------------------------------------------------------------------------------
  ----------------------------- BED 5 -------------------------------------------
  -------------------------------------------------------------------------------
elseif cm[1] == "/plbed5" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Admitted: ".. GetPlayerName(tPID).. " for ".. hT / 60 .." Days")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PB5",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PB5", tPID, hT)
 --TriggerClientEvent('chatMessage', -1, 'Admitted', { 255, 0, 0 }, GetPlayerName(tPID) ..' for '.. hT / 60 ..' Days')
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You have been admitted to bed 5!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 1 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/pp1" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PP1",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PP1", tPID, hT)
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You are Placed on Operation Bed 1!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  ------------------------------------------------------------------------------
  ----------------------------- OPERATING ROOM 2 -------------------------------
  ------------------------------------------------------------------------------
elseif cm[1] == "/pp2" then
  if xPlayer.job.name == 'ambulance' then
    CancelEvent()
    local tPID = tonumber(cm[2])
    local hT = defaultsecs
    if cm[3] ~= nil then
      hT = tonumber(cm[3]) * 60
    end
    local reason = tostring(cm[4])
    if hT > maxsecs then
      hT = maxsecs
    end
    if GetPlayerName(tPID) ~= nil then
      print("Placed: ".. GetPlayerName(tPID).. " for Operation")
      local identifier = GetPlayerIdentifiers(tPID)[1]
      local name = GetPlayerName(source)
      local id = GetPlayerIdentifiers(source)[1]
      MySQL.Async.execute("INSERT INTO hospital (identifier, H_Time, H_Bed, Medic, Medic_ID, reason) VALUES (@identifier, @H_Time, @H_Bed, @MEDIC, @MID, @reason)",
      {['@identifier'] = identifier,
      ['@H_Time'] = hT,
      ['@H_Bed'] = "PP2",
      ['@MEDIC'] = name,
      ['@MID'] = id,
      ['@reason'] = reason})
      TriggerClientEvent("PP2", tPID, hT)
      TriggerClientEvent('Xyyy_Notifications:client:SendAlert', tPID, {
        type = 'inform',
        text = 'You are Placed on Operation Bed 2!',
        length = 4000,
        style = { }
      })
    end
  else
    TriggerClientEvent('Xyyy_Notifications:client:SendAlert', source, {
      type = 'error',
      text = 'You are not allowed to do that!',
      length = 2500,
      style = { }
    })
  end
  --- END CONFIG
end
end)
RegisterServerEvent("HospitalCheck")
AddEventHandler("HospitalCheck", function()
local player = source
local identifier = GetPlayerIdentifiers(source)[1]
MySQL.Async.fetchAll('SELECT * FROM hospital WHERE identifier=@id', {['@id'] = identifier}, function(gotInfo)
if gotInfo[1] ~= nil then
  if gotInfo[1].identifier == GetPlayerIdentifiers(player)[1] then
    TriggerClientEvent(gotInfo[1].H_Bed, player, gotInfo[1].H_Time)
  end
else
end
end)
end)
RegisterServerEvent("HospitalUpdate")
AddEventHandler("HospitalUpdate", function(newTime)
local player = source
local identifier = GetPlayerIdentifiers(player)[1]
MySQL.Async.execute("UPDATE hospital SET H_Time=@TIME WHERE identifier=@identifier", {["@TIME"] = newTime, ['@identifier'] = identifier})
if newTime == 0 then
  local player = source
  local identifier = GetPlayerIdentifiers(player)[1]
  MySQL.Async.execute("DELETE FROM hospital WHERE identifier=@identifier", {['@identifier'] = identifier})
end
end)

RegisterServerEvent("HRelease")
AddEventHandler("HRelease", function(source)
local player = source
local identifier = GetPlayerIdentifiers(player)[1]
MySQL.Async.execute("DELETE FROM hospital WHERE identifier=@identifier", {['@identifier'] = identifier})
end)

function stringsplit(inputstr, sep)
  if sep == nil then
    sep = "%s"
  end
  local t={} ; i=1
  for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
    t[i] = str
    i = i + 1
  end
  return t
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end
