
-------------------------------------------- General --------------------------------------------
Config = {}
Config.Framework = "esx" -- newqb, oldqb, esx
Config.DefaultHud = "radial" -- Default hud when player first login avaliable huds [radial, classic, text]
Config.DefaultSpeedUnit = "kmh" -- Default speed unit when player first login avaliable speed units [kmh, mph]
Config.HudSettingsCommand = 'hudsettings' -- Command for open hud settings
Config.DisplayMapOnWalk = true -- true - Show map when walking | false - Hide map when walking
Config.DisplayRealTime = false -- if you set this to true will show the real time according to player local time | if false it will show the game time
Config.EnableSpamNotification = true -- Spam preventation for seatbelt, cruise etc.
Config.EnableDateDisplay = true -- Determines if display date or nor
Config.DefaultMap = "rectangle" -- rectangle, radial
Config.DefaultSpeedometerSize = 0.8 -- 0.5 - 1.3
Config.EnableAmmoHud = false -- Determines if display ammo hud or nor
Config.DefaultRefreshRate = 200 -- Refresh rate for vehicle hud
Config.EnableHealth = true
Config.EnableHunger = true
Config.EnableThirst = true
Config.EnableArmor = true
Config.EnableStamina = true
Config.EnableSpeedometer = true
Config.EnableHud = true



-------------------------------------------- Watermark hud --------------------------------------------
Config.UseWaterMarkText = false -- if true text will be shown | if  false logo will be shown
Config.WaterMarkText1 = "CODEM" -- Top right server text
Config.WaterMarkText2 = "SCRiPTS"  -- Top right server text
Config.WaterMarkLogo = "https://cdn.discordapp.com/attachments/1012520456173142078/1052768430048166019/olianndev.png" -- Logo url
Config.LogoWidth = "120px"
Config.LogoHeight = "53px"


Config.Text1Style = {
    ["background"] = 'linear-gradient(90deg, #e960c7 0%, #78a3ff 100%)',
    ["text-shadow"] = "0px 0.38rem 2.566rem rgba(116, 5, 147, 0.55)",
    ["-webkit-background-clip"]= "text",
    ["-webkit-text-fill-color"]= "transparent",
    ["background-clip"] = "text",
    
}

Config.Text2Style = {
    ["color"] = "#ffffff",

}

Config.EnableWaterMarkHud = false -- Determines if right-top hud is enabled or not


-------------------------------------------- Keys --------------------------------------------
Config.DefaultCruiseControlKey = "k" -- Default control key for cruise. Players can change the key according to their desire 
Config.DefaultSeatbeltControlKey = "b" -- Default control key for seatbelt. Players can change the key according to their desire 
Config.VehicleEngineToggleKey = "G" -- Default control key for toggle engine. Players can change the key according to their desire 
Config.NitroKey = "X" -- Default control key for use nitro. Players can change the key according to their desire 


-------------------------------------------- Nitro --------------------------------------------
Config.RemoveNitroOnpress = 2 -- Determines of how much you want to remove nitro when player press nitro key
Config.NitroItem = "nitro" -- item to install nitro to a vehicle
Config.EnableNitro = false -- Determines if nitro system is enabled or not
Config.NitroForce = 40.0 -- Nitro force when player using nitro


-------------------------------------------- Money commands --------------------------------------------
Config.EnableCashAndBankCommands = true -- Determines if money commands are enabled or not
Config.CashCommand = "cash"  -- command to see cash
Config.BankCommand = "bank" -- command to see bank money


-------------------------------------------- Engine Toggle --------------------------------------------
Config.EnableEngineToggle = true -- Determines if engine toggle is enabled or not

-------------------------------------------- Vehicle Functionality --------------------------------------------
Config.EnableCruise = true -- Determines if cruise mode is active
Config.EnableSeatbelt = true -- Determines if seatbelt is active


-------------------------------------------- Settings text --------------------------------------------
Config.SettingsLocale = { -- Settings texts
    ["text_hud_1"] = "text",
    ["text_hud_2"] = "hud",
    ["classic_hud_1"] = "classic",
    ["classic_hud_2"] = "hud",
    ["radial_hud_1"] = "radial",
    ["radial_hud_2"] = "hud",
    ["hide_hud"] = "Hide Hud",
    ["show_hud"] = "Show Hud",
    ["enable_cinematicmode"] = "Cinematic Mode",
    ["disable_cinematicmode"] = "Disable Cinematic",
    ["exit_settings_1"] = "EXIT FROM",
    ["exit_settings_2"] = "SETTINGS",
    ["speedometer"] = "SPEEDOMETER",
    ["map"] = "MAP",
    ["show_compass"] = "Show Compass",
    ["hide_compass"] = "Hide Compass",
    ["rectangle"] = "Rectangle",
    ["radial"] = "Radial",
    ["dynamic"] = "DYNAMiC",
    ["status"] = "STATUS",
    ["enable"] = "Enable",
    ["disable"] = "Disable",
    ["hide_at"] = "Hide at",
    ["and_above"] = "and above",
    ["enable_edit_mode"] = "Enable Edit Mode",
    ["disable_edit_mode"] = "Disable Edit Mode",
    ["reset_hud_positions"] = "Reset Hud Positions",
    ["info_text"] = "Be aware increasing refresh rate may decrease your in game perfomance!",
    ["speedometer_size"] = "Speedometer Size",
    ["refresh_rate"] = "Refresh Rate",
    ["esc_to_exit"] = "PRESS ESC TO EXIT EDIT MODE"
}


-------------------------------------------- Fuel --------------------------------------------
Config.UseLegacyFuel = false --Enable this if you use legacy fuel

Config.GetVehicleFuel = function(vehicle) -- you can change LegacyFuel export if you use another fuel system 
    if Config.UseLegacyFuel then
        return exports["ox_fuel"]:GetFuel(vehicle)
    else
        return GetVehicleFuelLevel(vehicle)
    end
end


-------------------------------------------- Stress --------------------------------------------
Config.UseStress = false -- if you set this to false the stress hud will be removed
--Config.StressWhitelistJobs = { -- Add here jobs you want to disable stress 
  --  'police', 'ambulance'
--}

Config.AddStress = {
    ["on_shoot"] = {
        min = 1,
        max = 2,
        enable = true,
    },
    ["on_fastdrive"] = {
        min = 1,
        max = 1,
        enable = true,
    },
}
--[[
Config.RemoveStress = { -- You can set here amounts by your desire
    ["on_eat"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_drink"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["on_swimming"] = {
        min = 5,
        max = 10,
        enable = true,

    },
    ["stress_tabs"] = {
        min = 5,
        max = 10,
        enable = true,
    },

}
]]--


-------------------------------------------- Notifications --------------------------------------------

Config.Notifications = { -- Notifications
    ["stress_gained"] = {
        message = 'Getting Stressed',
        type = "error",
    },
    ["stress_relive"] = {
        message =  'You Are Relaxing',
        type = "success",
    },
    ["took_off_seatbelt"] = {
        type = "error",
        message = "You took off seatbelt.",
    },
    ["took_seatbelt"] = {
        type = "success",
        message = "You took seatbelt.",
    },
    ["cruise_actived"] = {
        type = "success",
        message = "Cruise actived.",
    },
    ["cruise_disabled"] = {
        type = "error",
        message = "Cruise disabled.",
    },
    ["spam"] = {
        type = "error",
        message = "Please wait for a few seconds.",
    },
    ["engine_on"] = {
        type = "success",
        message = "Engine is on.",
    }, 
    ["engine_off"] = {
        type = "success",
        message = "Engine is off.",
    }, 
    ["cant_install_nitro"] = {
        type = "error",
        message = "You can't install nitro inside vehicle.",
    }, 
    ["no_veh_nearby"] = {
        type = "error",
        message = "No vehicle nearby.",
    }, 
    ["cash_display"] = {
        type = "success",
        message = "You have $%s in your pocket.",
    }, 
    ["bank_display"] = {
        type = "success",
        message = "You have $%s in your bank.",
    }, 
}

Config.Notification = function(message, type, isServer, src) -- You can change here events for notifications
    if isServer then
        if Config.Framework == "esx" then
            TriggerClientEvent("esx:showNotification", src, message)
        else
            TriggerClientEvent('QBCore:Notify', src, message, type, 1500)
        end
    else
        if Config.Framework == "esx" then
            TriggerEvent("esx:showNotification", message)
        else
            TriggerEvent('QBCore:Notify', message, type, 1500)
        end
    end
end 

-------------------------------------------- Seatbelt --------------------------------------------

-- ejectVelocity - The gta velocity at which ejection from the car should happen when not wearing seatbelt
--      This is NOT MPH or KPH but instead GTA Velocity. to convert:
--      MPH -> Vel = (MPH / 2.236936)
--      KPH -> Vel = (KPH / 3.6)
--  Default: (60 / 2.236936)
Config.ejectVelocity = (60 / 2.236936)

-- unknownEjectVelocity - This value should be equal or greater than the value of ejectVelocity
--      The purpose of this variable is confusing https://docs.fivem.net/natives/?_0x4D3118ED
--  Default: (70 / 2.236936)
Config.unknownEjectVelocity = (70 / 2.236936)

-- unknownModifier - Don't know the purpose of this value, probably best to leave as is
Config.unknownModifier = 17.0 --  Default: 17.0,

-- minDamage - Minimum damage given when ejected from car?
Config.minDamage = 30
