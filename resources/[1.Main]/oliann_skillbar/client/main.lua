local chance = 0
local skillGap = 20
local keys = {
    [1] = { "Q", 81 },
    [2] = { "W", 87 },
    [3] = { "E", 69 }
}

function openGui(sentLength, taskID, chanceSent, skillGapSent)
    guiEnabled = true
    SetNuiFocus(guiEnabled, false)

    local skillKey = math.random(1, 3)
    local skillText = "P R E S S &nbsp;&nbsp;  [ <span style='color: red;'><b>" .. keys[skillKey][1] .. "</b></span> ]"

    SendNUIMessage({
        runProgress = true,
        length = sentLength,
        Task = taskID,
        chance = chanceSent,
        skillgap = skillGapSent,
        skillText = skillText,
        skillKey = keys[skillKey][2]
    })
end

function updateGui(sentLength, taskID, chanceSent, skillGapSent)
    SendNUIMessage({
        runUpdate = true,
        length = sentLength,
        Task = taskID,
        chance = chanceSent,
        skillgap = skillGapSent
    }) 
end

local activeTasks = 0

function closeGuiFail()
    guiEnabled = false
    SetNuiFocus(guiEnabled, guiEnabled)
    SendNUIMessage({
        closeFail = true
    })
    --ClearPedTasks(PlayerPedId())
end

function closeGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled, guiEnabled)
    SendNUIMessage({
        closeProgress = true
    })
    --ClearPedTasks(PlayerPedId())
end


function closeNormalGui()
    guiEnabled = false
    SetNuiFocus(guiEnabled, guiEnabled)
    SendNUIMessage({
        closeProgress = true
    })    
end

RegisterNUICallback('taskCancel', function(data, cb)
    closeGui()
    local taskIdentifier = data.tasknum
    activeTasks = 2
end)
--[[
RegisterNUICallback('taskEnd', function(data, cb)
    closeNormalGui()

    if ( tonumber(data.taskResult) < (chance + (skillGap + 2)) and tonumber(data.taskResult) > (chance) ) then
        activeTasks = 3
    else
        activeTasks = 2
    end
end)
]]
RegisterNUICallback('taskEnd', function(data, cb)
    closeNormalGui()

    if ( tonumber(data.taskResult) < (chance + 20) and tonumber(data.taskResult) > (chance) ) then
        activeTasks = 3
    else
        activeTasks = 2
    end
end)

local factor = 1.0
local taskInProcess = false

function FactorFunction(pos)
    if not pos then
        factor = factor - 0.1
        if factor < 0.4 then
            factor = 0.4
        end
    else
        factor = factor + 0.1
        if factor > 1.0 then
            factor = 1.0
        end
    end

    TriggerEvent("pyrp_skillbar:restoreFactor")
end

RegisterNetEvent("pyrp_skillbar:restoreFactor")
AddEventHandler("pyrp_skillbar:restoreFactor", function()
    Wait(10000)
    FactorFunction(true)
end)

-- RegisterCommand('ragdoll', function(source, args)
--     SetPedToRagdollWithFall(PlayerPedId(), 1500, 2000, 1, GetEntityForwardVector(PlayerPedId()), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
-- end)

function taskBar(difficulty, skillGapSent)
    if difficulty < 1500 then
        difficulty = 1500
    end

    skillGap = skillGapSent

    if skillGap < 7 then
        skillGap = 7
    end


    local playerPed = PlayerPedId()

    if taskInProcess then
        return 100
    end

    -- FactorFunction(false)

    chance = math.random(35, 90)

    local length = math.ceil(difficulty + factor)

    taskInProcess = true
    local taskIdentifier = "taskId" .. math.random(1000000)
    openGui(length, taskIdentifier, chance, skillGap)
    activeTasks = 1

    local maxcount = GetGameTimer() + length
    local curTime

    while activeTasks == 1 do
        Citizen.Wait(1)
        curTime = GetGameTimer()

        if curTime > maxcount or IsPedRagdoll(playerPed) then
            activeTasks = 2
        end

        local fuck = 100 - ( ((maxcount - curTime) / length) * 100)
        fuck = math.min(100, fuck)
        updateGui(fuck, taskIdentifier, chance, skillGap)
    end

    if activeTasks == 2 then
        closeGuiFail()
        taskInProcess = false
        return 0
    else
        closeGui()
        taskInProcess = false
        return 100
    end
end

-- function skillBar(difficulty, skillGapSent)
--     if difficulty < 1500 then
--         difficulty = 1500
--     end

--     skillGap = skillGapSent

--     if skillGap < 7 then
--         skillGap = 7
--     end


--     local playerPed = PlayerPedId()

--     if taskInProcess then
--         return 100
--     end

--     -- FactorFunction(false)

--     chance = math.random(35, 90)

--     local length = math.ceil(difficulty + factor)

--     taskInProcess = true
--     local taskIdentifier = "taskId" .. math.random(1000000)
--     openGui(length, taskIdentifier, chance, skillGap)
--     activeTasks = 1

--     local maxcount = GetGameTimer() + length
--     local curTime

--     while activeTasks == 1 do
--         Citizen.Wait(1)
--         curTime = GetGameTimer()

--         if curTime > maxcount or IsPedRagdoll(playerPed) then
--             activeTasks = 2
--         end

--         local fuck = 100 - ( ((maxcount - curTime) / length) * 100)
--         fuck = math.min(100, fuck)
--         updateGui(fuck, taskIdentifier, chance, skillGap)
--     end

--     if activeTasks == 2 then
--         closeGuiFail()
--         taskInProcess = false
--         return 0
--     else
--         closeGui()
--         taskInProcess = false
--         return 100
--     end
-- end

exports('taskBar', taskBar);
