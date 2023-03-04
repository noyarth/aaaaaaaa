ESX = nil   
local PlayerData = {}

Citizen.CreateThread(function()
    while ESX == nil do
        ESX = exports['es_extended']:getSharedObject()
        Citizen.Wait(0)
    end

end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    PlayerData.job = job
end)

local isJudge = false
local isPolice = false
local isMedic = false
local isDoctor = false
local isNews = false
local isDead = false
local isInstructorMode = false
local myJob = "unemployed"
local isHandcuffed = false
local isHandcuffedAndWalking = false
local hasOxygenTankOn = false
local gangNum = 0
local cuffStates = {}


rootMenuConfig =  {
    

    {
        id = "general",
        displayName = "General",
        icon = "#globe-europe",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"general:carry","general:steal", "general:bills", "ems:putinvehicle", "ems:outofvehicle"}
    }, 
   --[[ {
        id = "accessories",
        displayName = "Accessories",
        icon = "#accessories",
        enableMenu = function()
            return not isDead
        end,
        subMenus = {"accessories:helmet", "accessories:ears", "accessories:glasses", "accessories:mask", "accessories:shirt", "accessories:pants", "accessories:bag", "accessories:chain", "accessories:vest" } 
    },	]]--
   --[[ {
        id = "illegalmenu",
        displayName = "Illegal Menu",
        icon = "#cuffs-rob",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "cuffing:drag", "cuffing:search","cuffing:takehostage" }

    },]]
    {
        id = "animations",
        displayName = "Marche Style",
        icon = "#walking",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "animations:brave", "animations:hurry", "animations:business", "animations:tipsy", "animations:injured","animations:tough", "animations:default", "animations:hobo", "animations:money", "animations:swagger", "animations:shady", "animations:maneater", "animations:chichi", "animations:sassy", "animations:sad", "animations:posh", "animations:alien" }
    },

    {
        id = "expressions",
        displayName = "Expressions",
        icon = "#expressions",
        enableMenu = function()
            return not isDead
        end,
        subMenus = { "expressions:normal", "expressions:drunk", "expressions:angry", "expressions:dumb", "expressions:electrocuted", "expressions:grumpy", "expressions:happy", "expressions:injured", "expressions:joyful", "expressions:mouthbreather", "expressions:oneeye", "expressions:shocked", "expressions:sleeping", "expressions:smug", "expressions:speculative", "expressions:stressed", "expressions:sulking", "expressions:weird", "expressions:weird2"}
    },

     {
         id = "vehicle",
         displayName = "Vehicule Control",
         icon = "#vehicle",
         functionName = "veh:options",
         enableMenu = function()
             return (not isDead and IsPedInAnyVehicle(PlayerPedId(), false))
         end,
         subMenus = { "vehicle:engine", "vehicle:givecarkeys"}
     },

    {
        id = "mechanic",
        displayName = "Actions Mecano",
        icon = "#mechanic",
        enableMenu =function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "mechanic")
        end,
        subMenus = { "mechanic:impound", "mechanic:bill", "mechanic:repair","mechanic:hijack", "mechanic:wash", "mechanic:flatbed"}
    },

    {
        id = "mechanic-objects",
        displayName = "Objets Mecano",
        icon = "#police-objects",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "mechanic")
        end,
        subMenus = { "mech:roadcone", "mech:toolchest" }
    },

    {
        id = "police",
        displayName = "Actions Police",
        icon = "#police",
        enableMenu =function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "police")
        end,
        subMenus = {"police:putinvehicle", "police:outofvehicle",  "police:cuff","police:uncuff", "police:drag", "police:mdt", "police:search"}
    },

    {
        id = "taxi",
        displayName = "Actions Taxi",
        icon = "#taxi",
        enableMenu =function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "taxi")
        end,
        subMenus = { "oliann_taxi:sendbill" }
    },
    
    {
        id = "police-check",
        displayName = "Check Police",
        icon = "#police-check",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "police")
        end,
        subMenus = {"police:comserve","police:gsr","police:bill","police:bills","police:checklicense", "police:impound", "police:hijack"} 
    },

    {
        id = "police-objects",
        displayName = "Objets Police",
        icon = "#police-objects",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "police")
        end,
        subMenus = { "police:cone", "police:barier", "police:light", 'police:boxpile', 'police:cash', "police:deleteObject"}
    },

    -- {
    --     id = "news",
    --     displayName = "News",
    --     icon = "#news",
    --     enableMenu =function()
    --         local Data = ESX.GetPlayerData()
    --         return (not isDead and Data.job ~= nil and Data.job.name == "reporter")
    --     end,
    --     subMenus = { "news:boom", "news:mic", "news:cam" }
    -- },

    {
        id = "ems",
        displayName = "Actions ems",
        icon = "#ems-ambulance",
        enableMenu = function()
            local Data = ESX.GetPlayerData()
            return (not isDead and Data.job ~= nil and Data.job.name == "ambulance")
        end,
        subMenus = { "ems:med","ems:bill", "ems:revive", "ems:treat", "ems:putinvehicle", "ems:outofvehicle"}
    }
}

newSubMenus = {
    ['general:emotes'] = {
        title = "Animations",
        icon = "#more",
        functionName = "emotes:OpenMenu"
    },

    ['general:bills'] = {
        title = "Facture",
        icon = "#police-bills",
        functionName = "showbills:bills"
    },

    ['general:carry'] = {
        title = "Carry",
        icon = "#cuffs-drag",
        functionName = "oliann:carry"
    },

    ['general:steal'] = { ----- faction
        title = "Voler",
        icon = "#cuffs-rob",
        functionName = "search:Player"
    },

    -- Cuff

    ['cuffing:steal'] = {
        title = "Voler",
        icon = "#cuffs-steal",
        functionName = "search:Player",
    },

    ['cuffing:drag'] = {
        title = "Escorter",
        icon = "#cuffs-drag",
        -- enableMenu = function()
        --     local Data = ESX.GetPlayerData()
        --     return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        -- end,
        functionName = "cuff:drag"
    },

    ['cuffing:search'] = {
        title = "Voler",
        icon = "#cuffs-steal",
        -- enableMenu = function()
        --     local Data = ESX.GetPlayerData()
        --     return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        -- end,
        functionName = "search:Player"
    },

    ['cuffing:takehostage'] = {
        title = "Otage",
        icon = "#cuffs-rob",
        -- enableMenu = function()
        --     local Data = ESX.GetPlayerData()
        --     return (not isDead and Data.job ~= nil and Data.job.name ~= "ambulance" and Data.job.name ~= "police" and not IsPedInAnyVehicle(ped, true))
        -- end,
        functionName = "eyetakehostage" --cuff:takehostage
    },



    --------------------------------------
    ['animations:brave'] = {
        title = "Brave",
        icon = "#animation-brave",
        functionName = "AnimSet:Brave"
    },

    ['animations:hurry'] = {
        title = "Hurry",
        icon = "#animation-hurry",
        functionName = "AnimSet:Hurry"
    },

    ['animations:business'] = {
        title = "Business",
        icon = "#animation-business",
        functionName = "AnimSet:Business"
    },

    ['animations:tipsy'] = {
        title = "Tipsy",
        icon = "#animation-tipsy",
        functionName = "AnimSet:Tipsy"
    },

    ['animations:injured'] = {
        title = "Injured",
        icon = "#animation-injured",
        functionName = "AnimSet:Injured"
    },

    ['animations:tough'] = {
        title = "Tough",
        icon = "#animation-tough",
        functionName = "AnimSet:ToughGuy"
    },

    ['animations:sassy'] = {
        title = "Sassy",
        icon = "#animation-sassy",
        functionName = "AnimSet:Sassy"
    },

    ['animations:sad'] = {
        title = "Sad",
        icon = "#animation-sad",
        functionName = "AnimSet:Sad"
    },

    ['animations:posh'] = {
        title = "Posh",
        icon = "#animation-posh",
        functionName = "AnimSet:Posh"
    },

    ['animations:alien'] = {
        title = "Alien",
        icon = "#animation-alien",
        functionName = "AnimSet:Alien"
    },

    ['animations:nonchalant'] = {
        title = "Nonchalant",
        icon = "#animation-nonchalant",
        functionName = "AnimSet:NonChalant"
    },

    ['animations:hobo'] = {
        title = "Hobo",
        icon = "#animation-hobo",
        functionName = "AnimSet:Hobo"
    },

    ['animations:money'] = {
        title = "Money",
        icon = "#animation-money",
        functionName = "AnimSet:Money"
    },

    ['animations:swagger'] = {
        title = "Swagger",
        icon = "#animation-swagger",
        functionName = "AnimSet:Swagger"
    },

    ['animations:shady'] = {
        title = "Shady",
        icon = "#animation-shady",
        functionName = "AnimSet:Shady"
    },

    ['animations:maneater'] = {
        title = "Maneater",
        icon = "#animation-maneater",
        functionName = "AnimSet:ManEater"
    },

    ['animations:chichi'] = {
        title = "Chichi",
        icon = "#animation-chichi",
        functionName = "AnimSet:ChiChi"
    },

    ['animations:default'] = {
        title = "Default",
        icon = "#animation-default",
        functionName = "AnimSet:default"
    },

    ["expressions:angry"] = {
        title="Angry",
        icon="#expressions-angry",
        functionName = "expressions",
        functionParameters =  { "mood_angry_1" }
    },

    ["expressions:drunk"] = {
        title="Drunk",
        icon="#expressions-drunk",
        functionName = "expressions",
        functionParameters =  { "mood_drunk_1" }
    },

    ["expressions:dumb"] = {
        title="Dumb",
        icon="#expressions-dumb",
        functionName = "expressions",
        functionParameters =  { "pose_injured_1" }
    },

    ["expressions:electrocuted"] = {
        title="Electrocuted",
        icon="#expressions-electrocuted",
        functionName = "expressions",
        functionParameters =  { "electrocuted_1" }
    },

    ["expressions:grumpy"] = {
        title="Grumpy",
        icon="#expressions-grumpy",
        functionName = "expressions", 
        functionParameters =  { "mood_drivefast_1" }
    },

    ["expressions:happy"] = {
        title="Happy",
        icon="#expressions-happy",
        functionName = "expressions",
        functionParameters =  { "mood_happy_1" }
    },

    ["expressions:injured"] = {
        title="Injured",
        icon="#expressions-injured",
        functionName = "expressions",
        functionParameters =  { "mood_injured_1" }
    },

    ["expressions:joyful"] = {
        title="Joyful",
        icon="#expressions-joyful",
        functionName = "expressions",
        functionParameters =  { "mood_dancing_low_1" }
    },

    ["expressions:mouthbreather"] = {
        title="Mouthbreather",
        icon="#expressions-mouthbreather",
        functionName = "expressions",
        functionParameters = { "smoking_hold_1" }
    },

    ["expressions:normal"]  = {
        title="Normal",
        icon="#expressions-normal",
        functionName = "expressions:clear"
    },

    ["expressions:oneeye"]  = {
        title="Oneeye",
        icon="#expressions-oneeye",
        functionName = "expressions",
        functionParameters = { "pose_aiming_1" }
    },

    ["expressions:shocked"]  = {
        title="Shocked",
        icon="#expressions-shocked",
        functionName = "expressions",
        functionParameters = { "shocked_1" }
    },

    ["expressions:sleeping"]  = {
        title="Sleeping",
        icon="#expressions-sleeping",
        functionName = "expressions",
        functionParameters = { "dead_1" }
    },

    ["expressions:smug"]  = {
        title="Smug",
        icon="#expressions-smug",
        functionName = "expressions",
        functionParameters = { "mood_smug_1" }
    },

    ["expressions:speculative"]  = {
        title="Speculative",
        icon="#expressions-speculative",
        functionName = "expressions",
        functionParameters = { "mood_aiming_1" }
    },

    ["expressions:stressed"]  = {
        title="Stressed",
        icon="#expressions-stressed",
        functionName = "expressions",
        functionParameters = { "mood_stressed_1" }
    },

    ["expressions:sulking"]  = {
        title="Sulking",
        icon="#expressions-sulking",
        functionName = "expressions",
        functionParameters = { "mood_sulk_1" },
    },

    ["expressions:weird"]  = {
        title="Weird",
        icon="#expressions-weird",
        functionName = "expressions",
        functionParameters = { "effort_2" }
    },

    ["expressions:weird2"]  = {
        title="Weird2",
        icon="#expressions-weird2",
        functionName = "expressions",
        functionParameters = { "effort_3" }
     },    


    --------------------------------------
    ["emotes:smoke"] = {
        title = "Smoke",
        icon = "#emotes-smoke",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" ,"smoke" }
    },

    ["emotes:lean"] = {
        title = "Lean",
        icon = "#emotes-lean",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" ,"lean" }
    },

    ["emotes:sitchair"] = {
        title = "SitChair",
        icon = "#emotes-sitchair",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" ,"sitchair" }
    },

    ["emotes:dance"] = {
        title = "Dance",
        icon = "#emotes-dance",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "dance" ,"dance" }
    },
   
    ["emotes:surr"] = {
        title = "Surrender",
        icon = "#emotes-surr",
        functionName = 'menu:dpemotes:cmd',
        functionParameters =  { "emote" , "surrender" }
    },


    ---- taxi
    ['oliann_taxi:sendbill'] = {
        title = "Facture",
        icon = "#vehicle-callmec",
        functionName = "oliann_taxi:sendbill"
    },
    --------------------------------------



    ['vehicle:callMechanic'] = {
        title = "Mechanic",
        icon = "#vehicle-callmec",
        functionName = "menu:general:callmechanic"
    },

    ['vehicle:engine'] = {
        title = "Moteur",
        icon = "#vehicle-engine",
        functionName = "vehicle:engine"
    },

    ['vehicle:givecarkeys'] = {
        title = "Givecar Keys",
        icon = "#vehicle-hotw",
        functionName = "esx_givecarkeys:keys"
    },

    -------------------------------------
    
    ['police:cone'] = {
        title = "Cone",
        icon = "#object-cone",
        functionName = "menu:roadcone",
    },
	
	['police:boxpile'] = {
        title = "Boite",
        icon = "#police",
        functionName = "menu:boxpile", 
    },
	
	['police:cash'] = {
        title = "Boite Argent",
        icon = "#police",
        functionName = "menu:cash",
    },
    
    ['police:barier'] = {
        title = "Barriere",
        icon = "#police",
        functionName = 'menu:barrier',
    },
    
    ['police:light'] = {
        title = "Herse",
        icon = "#object-light",
        functionName = "menu:spikes",
    },
        
    ['police:deleteObject'] = {
        title = "Suprimer Objets",
        icon = "#object-delete",
        functionName = "menu:removeprops",
    },

    ['police:search'] = {
        title = "Fouiller",
        icon = "#police-search",
        functionName = "menu:searchpol"
    },

    ['police:impound'] = {
        title = "Impound",
        icon = "#police-jail",
        functionName = "menu:IMPOUND"
    },
	
	['police:hijack'] = {
        title = "Hijack Vehicule",
        icon = "#police-jail",
        functionName = "menu:LOCKPICK"
    },

    ['police:bill'] = {
        title = "Facture",
        icon = "#police-bills",
        functionName = "menu:FINE"
    },
    
    ['police:checklicense'] = {
        title = "Regarder License",
        icon = "#object-light",
        functionName = "menu:LICENSES"
    },

    ['police:bills'] = {
        title = "Facture Impayer",
        icon = "#police-bills",
        functionName = "menu:BILLS"
    },
    ['police:gsr'] = {
        title = "Test GSR",
        icon = "#object-cone",
        functionName = "menu:GSR"
    },
    ['police:comserve'] = {
        title = "Community Service",
        icon = "#police",
        functionName = "menu:COMSERV"
    },

    ['police:cuff'] = {
        title = "Menotter",
        icon = "#police-cuff",
        functionName = "police:handcuff"
    },
    ['police:uncuff'] = {
        title = "De-Menotter",
        icon = "#police-uncuff",
        functionName = "police:uncuff"
    },

    ['police:mdt'] = {
        title = "Tablette",
        icon = "#police-mdt",
        functionName = "menu:police:mdt"
    },

    ['police:putinvehicle'] = {
        title = "Mettre Vehicule",
        icon = "#general-put-in-veh",
        functionName = "menu:PUTVEH",
    },
    ['ems:putinvehicle'] = {
        title = "Mettre vehicule",
        icon = "#general-put-in-veh",
        functionName = "menu:emsv",
    },

    ['police:outofvehicle'] = {
        title = "Sortir Vehicule",
        icon = "#general-unseat-nearest",
        functionName = "menu:OUTVEH",
    },
    ['ems:outofvehicle'] = {
        title = "Sortir Vehicule",
        icon = "#general-unseat-nearest",
        functionName = "menu:emso",
    },

    ['police:drag'] = {
        title = "Escorter",
        icon = "#police-drag",
        functionName = "menu:DRAG",
    },

    --------------------------------------

    ['ems:bill'] = {
        title = "Facture",
        icon = "#ems-bill",
        functionName = "oliann_ambulance:sendbill"
    },

    ['ems:revive'] = {
        title = "Reanimer",
        icon = "#ems-revive",
        functionName = "oliann_ambulance:revive"

    },

    ['ems:treat'] = {
        title = "Guerir",
        icon = "#ems-heal",
        functionName = "oliann_ambulance:treatplayer"
    },

    ['ems:med'] = {
        title = "Regarder Vitaux",
        icon = "#ems-heal",
        functionName = "ems:med",
    },

    --------------------------------------
	['news:boom'] = {
        title = "Boom",
        icon = "#news-boom",
        functionName = "Mic:ToggleBMic"
    },

    ['news:cam'] = {
        title = "Cam",
        icon = "#news-cam",
        functionName = "Cam:ToggleCam"
    },

    ['news:mic'] = {
        title = "Mic",
        icon = "#news-mic",
        functionName = "Mic:ToggleMic"
    },


    --------------------------------------
    
    ['mech:roadcone'] = {
        title = "Cone",
        icon = "#object-cone",
        functionName = "mech:roadcone",
    },

    ['mech:toolchest'] = {
        title = "Coffre outils",
        icon = "#police",
        functionName = "mech:toolchest",
    },

    ["mechanic:bill"] = {
        title = "Facture",
        icon = "#ems-bill",
        functionName = "mech:sendbill"
    },

    ["mechanic:hijack"] = {
        title = "Hijack",
        icon = "#mechanic-hijack",
        functionName = "menu:LOCKPICK",
    },

    ["mechanic:repair"] = {
        title = "Reparer",
        icon = "#mechanic-repair",
        functionName = "mech:fixvehicle"
    },

    ["mechanic:wash"] = {
        title = "Nettoyer",
        icon = "#mechanic-wash",
        functionName = "mech:cleanvehicle"
    },

    ["mechanic:impound"] = {
        title = "Impound",
        icon = "#mechanic-impound",
        functionName = "mech:deleteveh"
    },

    ["mechanic:flatbed"] = {
        title = "Flatbed",
        icon = "#mechanic-flatbed",
        functionName = "mech:flatbedveh"
    },
    --------------------------------------
    ["accessories:mask"] = {
        title = "Mask",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Mask',
        functionParameters =  { "Mask" }
    },

    ["accessories:glasses"] = {
        title = "Glasses",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Glasses',
        functionParameters =  { "Glasses" }
    },

    ["accessories:helmet"] = {
        title = "Helmet",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Helmet',
        functionParameters =  { "Helmet" }
    },

    ["accessories:ears"] = {
        title = "Ears",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Ear',
        functionParameters =  { "Ears" }
    },
	
	["accessories:shirt"] = {
        title = "Torso",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Torso',
        functionParameters =  { "Torso" }
    },
	
	["accessories:pants"] = {
        title = "Pants",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Pants',
        functionParameters =  { "Pants" }
    },
	
	["accessories:bag"] = {
        title = "Bags",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Bag',
        functionParameters =  { "Bag" }
    },
	
	["accessories:chain"] = {
        title = "Chain",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Chain', 
        functionParameters =  { "Chain" }
    },
	
	["accessories:vest"] = {
        title = "Vest",
        icon = "#accessories-clothings",
        functionName = 'esx_clothes_lgrp:Vest',
        functionParameters =  { "Vest" }
    }
}


function GetPlayers()
    local players = {}

    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            players[#players+1]= i
        end
    end

    return players
end

function GetClosestPlayer()
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local closestPed = -1
    local ply = PlayerPedId()
    local plyCoords = GetEntityCoords(ply, 0)
    if not IsPedInAnyVehicle(PlayerPedId(), false) then
        for index,value in ipairs(players) do
            local target = GetPlayerPed(value)
            if(target ~= ply) then
                local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
                local distance = #(vector3(targetCoords["x"], targetCoords["y"], targetCoords["z"]) - vector3(plyCoords["x"], plyCoords["y"], plyCoords["z"]))
                if(closestDistance == -1 or closestDistance > distance) and not IsPedInAnyVehicle(target, false) then
                    closestPlayer = value
                    closestPed = target
                    closestDistance = distance
                end
            end
        end
        return closestPlayer, closestDistance, closestPed
    end
end

