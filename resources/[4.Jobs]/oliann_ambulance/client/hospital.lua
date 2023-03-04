local cJ = false
local eJE = false


--ESX base

Citizen.CreateThread(function()
while ESX == nil do
  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
  Citizen.Wait(0)
end
end)
-------------------------------------------------------------------
----------------------------- BED 1 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB1")
AddEventHandler("HB1", function(hT)
Citizen.Trace('Sent To Hospital Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 309.21, -577.67, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 337.31 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(309.21, -577.67, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 309.21, -577.67, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
      --  exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 309.21, -577.67, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- BED 2 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB2")
AddEventHandler("HB2", function(hT)
Citizen.Trace('Sent To Hospital Bed 2')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 307.82, -581.69, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 157.08 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(307.82, -581.69, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 307.82, -581.69, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 307.82, -581.69, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- BED 3 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB3")
AddEventHandler("HB3", function(hT)
Citizen.Trace('Sent To Hospital Bed 3')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 311.19, -582.83, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 157.08 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(311.19, -582.83, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 311.19, -582.83, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 311.19, -582.83, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- BED 4 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB4")
AddEventHandler("HB4", function(hT)
Citizen.Trace('Sent To Hospital Bed 4')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 313.83, -578.85, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 337.31 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(313.83, -578.85, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 313.83, -578.85, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 313.83, -578.85, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 5 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB5")
AddEventHandler("HB5", function(hT)
Citizen.Trace('Sent To Hospital Bed 5')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 314.51, -584.21, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 155.75 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(314.51, -584.21, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 314.51, -584.21, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 314.51, -584.21, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 6 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB6")
AddEventHandler("HB6", function(hT)
Citizen.Trace('Sent To Hospital Bed 6')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 317.79, -585.28, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 155.75 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(317.79, -585.28, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 317.79, -585.28, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 317.79, -585.28, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 7 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB7")
AddEventHandler("HB7", function(hT)
Citizen.Trace('Sent To Hospital Bed 7')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 319.32, -580.9, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 337.31 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(319.32, -580.9, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 319.32, -580.9, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 319.32, -580.9, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 8 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB8")
AddEventHandler("HB8", function(hT)
Citizen.Trace('Sent To Hospital Bed 8')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 322.89, -586.89, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 155.75 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(322.89, -586.89, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP,322.89, -586.89, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 322.89, -586.89, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 9 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB9")
AddEventHandler("HB9", function(hT)
Citizen.Trace('Sent To Hospital Bed 9')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 324.21, -582.84, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 337.31 + 180)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 324.21, -582.84, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  324.21, -582.84, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  324.21, -582.84, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 10 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB10")
AddEventHandler("HB10", function(hT)
Citizen.Trace('Sent To Hospital Bed 10')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 361.35, -581.23, 44.19)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 65.35 + 360)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 361.35, -581.23, 44.19, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  361.35, -581.23, 44.19)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  361.35, -581.23, 44.19)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 11 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB11")
AddEventHandler("HB11", function(hT)
Citizen.Trace('Sent To Hospital Bed 11')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 359.53, -586.11, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 63.74 + 360)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 359.53, -586.11, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  359.53, -586.11, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  359.53, -586.11, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 12 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB12")
AddEventHandler("HB12", function(hT)
Citizen.Trace('Sent To Hospital Bed 12')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 363.5, -588.96, 44.21)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 64.19 + 360)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 363.5, -588.96, 44.21, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  363.5, -588.96, 44.21)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  363.5, -588.96, 44.21)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 13 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB13")
AddEventHandler("HB13", function(hT)
Citizen.Trace('Sent To Hospital Bed 13')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 365.19, -586.04, 44.21)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 73.06 + 360)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 365.19, -586.04, 44.21, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  365.19, -586.04, 44.21)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  365.19, -586.04, 44.21)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 14 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB14")
AddEventHandler("HB14", function(hT)
Citizen.Trace('Sent To Hospital Bed 14')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 366.49, -581.64, 44.21)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 73.67 + 360)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 366.49, -581.64, 44.21, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  366.49, -581.64, 44.21)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  366.49, -581.64, 44.21)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)

-------------------------------------------------------------------
----------------------------- BED 15 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("HB15")
AddEventHandler("HB15", function(hT)
Citizen.Trace('Sent To Hospital Bed 15')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 357.49, -598.23, 43.99)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 156.76 + 360)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist( 357.49, -598.23, 43.99, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP,  357.49, -598.23, 43.99)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP,  357.49, -598.23, 43.99)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)


-------------------------------------------------------------------
----------------------------- OP 1 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("OP1")
AddEventHandler("OP1", function(hT)
Citizen.Trace('You are Placed Operation Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 315.25, -566.61, 43.28)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 154.02)

    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(315.25, -566.61, 44.28, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 315.25, -566.61, 43.28)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 314.6, -565.87, 43.28)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 2 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("OP2")
AddEventHandler("OP2", function(hT)
Citizen.Trace('You are Placed Operation Bed 2')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 321.11, -568.56, 44.26)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 157.52)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(321.11, -568.56, 44.26, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 321.11, -568.56, 44.26)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 320.31, -567.82, 43.28)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 3 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("OP3")
AddEventHandler("OP3", function(hT)
Citizen.Trace('You are Placed Operation Bed 3')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 326.83, -570.84, 44.26)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)

    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 159.64)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(326.83, -570.84, 44.26, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 326.83, -570.84, 44.26)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 326.02, -570.63, 43.28)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- MRI --------------------------------
-------------------------------------------------------------------
RegisterNetEvent("MRI")
AddEventHandler("MRI", function(hT)
Citizen.Trace('You are Placed MRI Bed')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 337.06, -575.12, 44.19)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 156.44)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(337.06, -575.12, 44.19, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 337.06, -575.12, 44.19)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 336.42, -574.73, 43.28)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- XRAY --------------------------------
-------------------------------------------------------------------
RegisterNetEvent("XRY")
AddEventHandler("XRY", function(hT)
Citizen.Trace('You are Placed XRay Bed')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 348.5, -579.23, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 155.92)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(348.5, -579.23, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 348.5, -579.23, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 348.05, -579.01, 43.28)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
--------------------------------------------------------------------
----------------------------- PBED 1 -------------------------------
--------------------------------------------------------------------
RegisterNetEvent("PHB1")
AddEventHandler("PHB1", function(hT)
Citizen.Trace('Sent To Hospital Private Room Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 359.75, -586.24, 44.2)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 65.33)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(359.75, -586.24, 44.2, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 359.75, -586.24, 44.2)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 359.75, -586.24, 44.2)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
--------------------------------------------------------------------
----------------------------- PBED 2 -------------------------------
--------------------------------------------------------------------
RegisterNetEvent("PHB2")
AddEventHandler("PHB2", function(hT)
Citizen.Trace('Sent To Hospital Private Room Bed 2')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 361.53, -581.3, 44.19)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 66.54)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(361.53, -581.3, 44.19, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 361.53, -581.3, 44.19)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 361.53, -581.3, 44.19)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
--------------------------------------------------------------------
----------------------------- PBED 3 -------------------------------
--------------------------------------------------------------------
RegisterNetEvent("PHB3")
AddEventHandler("PHB3", function(hT)
Citizen.Trace('Sent To Hospital Private Room Bed 3')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 354.43, -600.11, 44.22)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 67.17)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(354.43, -600.11, 44.22, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 354.43, -600.11, 44.22)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 354.43, -600.11, 44.22)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
--------------------------------------------------------------------
----------------------------- PBED 4 -------------------------------
--------------------------------------------------------------------
RegisterNetEvent("PHB4")
AddEventHandler("PHB4", function(hT)
Citizen.Trace('Sent To Hospital Private Room Bed 4')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 366.59, -581.58, 44.21)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 67.58)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(366.59, -581.58, 44.21, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 366.59, -581.58, 44.21)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 366.59, -581.58, 44.21)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
--------------------------------------------------------------------
----------------------------- PBED 5 -------------------------------
--------------------------------------------------------------------
RegisterNetEvent("PHB5")
AddEventHandler("PHB5", function(hT)
Citizen.Trace('Sent To Hospital Private Room Bed 5')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 365.07, -585.92, 44.21)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 66.74)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(365.07, -585.92, 44.21, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 365.07, -585.92, 44.21)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 365.07, -585.92, 44.21)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
--------------------------------------------------------------------
----------------------------- PBED 6 -------------------------------
--------------------------------------------------------------------
RegisterNetEvent("PHB6")
AddEventHandler("PHB6", function(hT)
Citizen.Trace('Sent To Hospital Private Room Bed 6')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 363.93, -589.09, 44.21)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 68.89)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(363.93, -589.09, 44.21, pL['x'], pL['y'], pL['z'])
    if D > 2 then

      SetEntityCoords(pP, 363.93, -589.09, 44.21)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 363.93, -589.09, 44.21)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)


-------------------------------------------------------------------------
----------------------------- DECLARE DEAD -------------------------------
-------------------------------------------------------------------------
RegisterNetEvent("DD1")
AddEventHandler("DD1", function(hT)
Citizen.Trace('You have been transferred to the Morgue')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 278.69, -1338.66, 25.52)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetPedComponentVariation(GetPlayerPed(-1), 11, 15, 0, 2)  	-- TORSO
    SetPedComponentVariation(GetPlayerPed(-1), 8, 15, 0, 2)  	-- TSHIRT
    SetPedComponentVariation(GetPlayerPed(-1), 4, 21, 0, 2)  	-- PANTS
    SetPedComponentVariation(GetPlayerPed(-1), 6, 16, 0, 2)   	-- SHOES
    SetPedComponentVariation(GetPlayerPed(-1), 3, 15, 0, 2)   	-- ARMS
    SetPedComponentVariation(GetPlayerPed(-1), 7, 0, 0, 2)		-- CHAINS
    SetPedComponentVariation(GetPlayerPed(-1), 5, 0 ,0 ,2) 		-- BAGS
    SetPedComponentVariation(GetPlayerPed(-1), 9, 0 ,0 ,2) 		-- VEST
    SetPedComponentVariation(GetPlayerPed(-1), 1, 0 ,0 ,2)		-- MASK
    ClearPedProp(GetPlayerPed(-1), -0)							-- HELMET
    ClearPedProp(GetPlayerPed(-1), 2)							-- EARS
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 48.63)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(278.69, -1338.66, 25.52, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 278.69, -1338.66, 25.52)
      if D > 1 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Dead are <b style="color:orange">NOT ALLOWED</b> to move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
 -- exports['Xyyy_Notifications']:SendAlert('success', 'The Coroner <b style="color:orange">Released</b> you.', 11000, { })
  exports['idolo_notifications']:showNotify('Dead are <b style="color:orange">NOT ALLOWED</b> to move.','success', 5000, { })
  SetEntityCoords(pP, 285.63, -1351.26, 24.50)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- SANDY SHORES ------------------------
-------------------------------------------------------------------
----------------------------- SANDY BED 1 -------------------------
-------------------------------------------------------------------
RegisterNetEvent("SB1")
AddEventHandler("SB1", function(hT)
Citizen.Trace('Sent To Hospital Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1822.1, 3673.99, 35.0)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 121.01)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1822.1, 3673.99, 35.0, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 1822.1, 3673.99, 35.0)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1822.1, 3673.99, 35.0)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- SANDY BED 2 -------------------------
-------------------------------------------------------------------
RegisterNetEvent("SB2")
AddEventHandler("SB2", function(hT)
Citizen.Trace('Sent To Hospital Bed 2')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1823.19, 3672.26, 35.0)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 112.79)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1823.19, 3672.26, 35.0, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 1823.19, 3672.26, 35.0)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1823.19, 3672.26, 35.0)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- SANDY BED 3 -------------------------
-------------------------------------------------------------------
RegisterNetEvent("SB3")
AddEventHandler("SB3", function(hT)
Citizen.Trace('Sent To Hospital Bed 3')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1820.13, 3669.6, 35.0)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 301.85)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1820.13, 3669.6, 35.0, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 1820.13, 3669.6, 35.0)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1820.13, 3669.6, 35.0)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- SANDY BED 4 -------------------------
-------------------------------------------------------------------
RegisterNetEvent("SB4")
AddEventHandler("SB4", function(hT)
Citizen.Trace('Sent To Hospital Bed 4')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1819.21, 3671.36, 35.0)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 300.48)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1819.21, 3671.36, 35.0, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 1819.21, 3671.36, 35.0)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1819.21, 3671.36, 35.0)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- SANDY BED 5 -------------------------
-------------------------------------------------------------------
RegisterNetEvent("SB5")
AddEventHandler("SB5", function(hT)
Citizen.Trace('Sent To Hospital Bed 5')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1818.17, 3672.91, 35.0)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 304.29)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1818.17, 3672.91, 35.0, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 1818.17, 3672.91, 35.0)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1818.17, 3672.91, 35.0)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- SANDY BED 6 -------------------------
-------------------------------------------------------------------
RegisterNetEvent("SB6")
AddEventHandler("SB6", function(hT)
Citizen.Trace('Sent To Hospital Bed 6')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1817.25, 3674.62, 35.0)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 300.77)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1817.25, 3674.62, 35.0, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, 1817.25, 3674.62, 35.0)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1817.25, 3674.62, 35.0)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 1 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("SP1")
AddEventHandler("SP1", function(hT)
Citizen.Trace('You are Placed Operation Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1825.81, 3685.57, 35.25)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 329.14)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1825.81, 3685.57, 35.25, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 1825.81, 3685.57, 35.25)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1826.41, 3685.12, 34.29)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 2 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("SP2")
AddEventHandler("SP2", function(hT)
Citizen.Trace('You are Placed Operation Bed 2')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1834.71, 3691.29, 35.25)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 106.45)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1834.71, 3691.29, 35.25, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 11834.71, 3691.29, 35.25)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1835.05, 3690.74, 34.27)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 3 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("SP3")
AddEventHandler("SP3", function(hT)
Citizen.Trace('You are Placed Operation Bed 3')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, 1835.74, 3689.03, 35.25)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 95.94)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(1835.74, 3689.03, 35.25, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, 1835.74, 3689.03, 35.25)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, 1836.08, 3688.44, 34.27)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- PALETO BAY --------------------------
-------------------------------------------------------------------
----------------------------- PALETO BED 1 ------------------------
-------------------------------------------------------------------
RegisterNetEvent("PB1")
AddEventHandler("PB1", function(hT)
Citizen.Trace('Sent To Hospital Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -257.73, 6321.82, 33.39)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 311.96)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-257.73, 6321.82, 33.39, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, -257.73, 6321.82, 33.39)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -257.99, 6322.89, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- PALETO BED 2 ------------------------
-------------------------------------------------------------------
RegisterNetEvent("PB2")
AddEventHandler("PB2", function(hT)
Citizen.Trace('Sent To Hospital Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -260.09, 6324.18, 33.35)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 311.88)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-260.09, 6324.18, 33.35, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, -260.09, 6324.18, 33.35)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -260.59, 6325.15, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- PALETO BED 3 ------------------------
-------------------------------------------------------------------
RegisterNetEvent("PB3")
AddEventHandler("PB3", function(hT)
Citizen.Trace('Sent To Hospital Bed 3')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -262.49, 6326.42, 33.35)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 312.11)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-262.49, 6326.42, 33.35, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, -262.49, 6326.42, 33.35)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -261.45, 6325.89, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- PALETO BED 4 ------------------------
-------------------------------------------------------------------
RegisterNetEvent("PB4")
AddEventHandler("PB4", function(hT)
Citizen.Trace('Sent To Hospital Bed 4')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -258.71, 6330.19, 33.35)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 132.99)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-258.71, 6330.19, 33.35, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, -258.71, 6330.19, 33.35)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -258.18, 6329.19, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- PALETO BED 5 ------------------------
-------------------------------------------------------------------
RegisterNetEvent("PB5")
AddEventHandler("PB5", function(hT)
Citizen.Trace('Sent To Hospital Bed 5')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -256.43, 6327.91, 33.35)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 132.07)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end
    if hT % 60 == 0 then
      exports['idolo_notifications']:showNotify('You have <b style="color:orange">' .. hT / 60 .. ' days</b> left until fully healed.','warn', 5000, { })
    end
    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-256.43, 6327.91, 33.35, pL['x'], pL['y'], pL['z'])
    if D > 2 then
      SetEntityCoords(pP, -256.43, 6327.91, 33.35)
      if D > 3 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        exports['idolo_notifications']:showNotify('Added <b style="color:orange">1 MORE DAY</b>, Please Don\'t Move.','error', 5000, { })
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -257.52, 6328.26, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 1 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("PP1")
AddEventHandler("PP1", function(hT)
Citizen.Trace('You are Placed Operation Bed 1')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -248.44, 6316.45, 33.35)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 41.91)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-248.44, 6316.45, 33.35, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, -248.44, 6316.45, 33.35)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -249.01, 6316.03, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
-------------------------------------------------------------------
----------------------------- OP 2 -------------------------------
-------------------------------------------------------------------
RegisterNetEvent("PP2")
AddEventHandler("PP2", function(hT)
Citizen.Trace('You are Placed Operation Bed 2')
if cJ == true then
  return
end
local pP = GetPlayerPed(-1)
if DoesEntityExist(pP) then

  Citizen.CreateThread(function()
  local playerOldLoc = GetEntityCoords(pP, true)
  SetEntityCoords(pP, -250.71, 6314.25, 33.35)
  cJ = true
  eJE = false
  while hT > 0 and not eJE do
    timecheck(hT)
    pP = GetPlayerPed(-1)
    SetEntityInvincible(pP, true)
    TaskPlayAnim(GetPlayerPed(-1),"anim@gangops@morgue@table@", "body_search",1.0, -1.0, 120000, 1, 120, false, false, false)
    SetEntityHeading(GetPlayerPed(-1), 42.38)
    if IsPedInAnyVehicle(pP, false) then
      ClearPedTasksImmediately(pP)
    end

    Citizen.Wait(500)
    local pL = GetEntityCoords(pP, true)
    local D = Vdist(-250.71, 6314.25, 33.35, pL['x'], pL['y'], pL['z'])
    if D > 1 then

      SetEntityCoords(pP, -250.71, 6314.25, 33.35)
      if D > 2 then
        hT = hT + 60
        if hT > 1500 then
          hT = 1500
        end
        Citizen.Trace('GUESS I TRIED TO GET UP')
        TriggerEvent('chatMessage', 'DOCTOR', { 255, 0, 0 }, "Siezure attack, we placed you back on your bed!")
      end
    end
    hT = hT - 0.5
  end
  Citizen.Trace('IM FREE')
  TriggerServerEvent('HospitalReleaseTime')
  TriggerServerEvent('chatMessageEntered', "SYSTEM", { 255, 0, 0 }, GetPlayerName(PlayerId()) .." was released from the hospital.")
  SetEntityCoords(pP, -251.23, 6313.8, 32.43)
  cJ = false
  SetEntityInvincible(pP, false)
  end)
end
end)
---- END CONFIG
RegisterNetEvent("UnHB")
AddEventHandler("UnHB", function()
eJE = true
end)

AddEventHandler('playerSpawned', function(spawn)
Citizen.Trace('Check For If I Am Hospitalized')
TriggerServerEvent('HospitalCheck')
end)

function timecheck(Time)
  if Time % 5 == 0 then
    TriggerServerEvent('HospitalUpdate', Time)
  elseif Time == 1 then
    TriggerServerEvent('HospitalReleaseTime')
    TriggerServerEvent('HospitalUpdate', 0)
  end
end
