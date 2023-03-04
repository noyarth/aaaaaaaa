Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local ped = GetPlayerPed( -1 )
		local weapon = GetSelectedPedWeapon(ped)

		if IsPedArmed(ped, 6) then
        	DisableControlAction(1, 140, true)
            DisableControlAction(1, 141, true)
            DisableControlAction(1, 142, true)
        end		
		
		if weapon == GetHashKey("WEAPON_FIREEXTINGUISHER") then		
			if IsPedShooting(ped) then
				SetPedInfiniteAmmo(ped, true, GetHashKey("WEAPON_FIREEXTINGUISHER"))
			end
		end
	end
    wait(1000)
end)


-- Recoil
local recoils = {
    [453432689] = 0.11, -- PISTOL
    [3219281620] = 0.60, -- PISTOL MK2
    [1593441988] = 0.55, -- COMBAT PISTOL
    [584646201] = 0.07, -- AP PISTOL
    [-1716589765] = 0.50, -- PISTOL .50
    [324215364] = 0.48, -- MICRO SMG
    [736523883] = 0.48, -- SMG
    [2024373456] = 0.1, -- SMG MK2
    [-270015777] = 0.5, -- ASSAULT SMG
    [-1074790547] = 0.07, -- ASSAULT RIFLE
    [961495388] = 0.23, -- ASSAULT RIFLE MK2
    [-2084633992] = 0.01, -- CARBINE RIFLE
    [4208062921] = 0.029, -- CARBINE RIFLE MK2
    [-1357824103] = 0.01, -- ADVANCED RIFLE
    [-1660422300] = 0.016, -- MG
    [2144741730] = 0.017, -- COMBAT MG
    [3686625920] = 0.016, -- COMBAT MG MK2
    [487013001] = 0.4, -- PUMP SHOTGUN
    [2017895192] = 0.4, -- SAWNOFF SHOTGUN
    [-494615257] = 0.4, -- ASSAULT SHOTGUN
    [-1654528753] = 0.4, -- BULLPUP SHOTGUN
    [911657153] = 0.0, -- STUN GUN
    [100416529] = 0.5, -- SNIPER RIFLE
    [205991906] = 0.7, -- HEAVY SNIPER
    [177293209] = 0.7, -- HEAVY SNIPER MK2
    [856002082] = 1.2, -- REMOTE SNIPER
    [-1568386805] = 1.0, -- GRENADE LAUNCHER
    [1305664598] = 1.0, -- GRENADE LAUNCHER SMOKE
    [-1312131151] = 0.0, -- RPG
    [1752584910] = 0.0, -- STINGER
    [1119849093] = 0.01, -- MINIGUN
    [-1076751822] = 0.2, -- SNS PISTOL
    [1627465347] = 0.1, -- GUSENBERG
    [-1063057011] = 0.01, -- SPECIAL CARBINE
    [-771403250] = 0.08, -- HEAVY PISTOL
    [2132975508] = 0.05, -- BULLPUP RIFLE
    [137902532] = 1.2, -- VINTAGE PISTOL
    [-1466123874] = 0.7, -- MUSKET
    [984333226] = 1.3, -- HEAVY SHOTGUN
    [-952879014] = 0.3, -- MARKSMAN RIFLE
    [1672152130] = 0.3, -- HOMING LAUNCHER
    [1198879012] = 0.9, -- FLARE GUN
    [171789620] = 0.18, -- COMBAT PDW
    [-598887786] = 0.9, -- MARKSMAN PISTOL
    [1834241177] = 2.4, -- RAILGUN
    [-619010992] = 0.01, -- MACHINE PISTOL
    [-1045183535] = 1.2, -- REVOLVER
    [-275439685] = 0.7, -- DOUBLE BARREL SHOTGUN
    [1649403952] = 0.05, -- COMPACT RIFLE
    [317205821] = 0.2, -- AUTO SHOTGUN
    [125959754] = 0.5, -- COMPACT LAUNCHER
    [-1121678507] = 0.01, -- MINI SMG     
}

local myRecoilFactor = 1.20
local drivebyFactor = 0.0

RegisterNetEvent('idolo_tnginamo:newStress')
AddEventHandler('idolo_tnginamo:newStress', function(stress)
    myRecoilFactor = ( tonumber(stress) / 650000 ) + 1.20
end)


Citizen.CreateThread( function()

    
    while true do 

        if IsPedArmed(GetPlayerPed(-1), 6) then
            Citizen.Wait(1)
        else
            Citizen.Wait(1500)
        end   

        if IsPedShooting(PlayerPedId()) then

        	if IsPedDoingDriveby(PlayerPedId()) then        		
        		drivebyFactor = 4.0       
        	else
        		drivebyFactor = 0.0       
        	end

            local _,wep = GetCurrentPedWeapon(PlayerPedId())
            _,cAmmo = GetAmmoInClip(PlayerPedId(), wep)
            if recoils[wep] and recoils[wep] ~= 0 then
                tv = 0
                if GetFollowPedCamViewMode() == 4 then
                    p = GetGameplayCamRelativePitch()
                    recoiling = 2
                    while recoiling > 0 do

                        possiblerecoil = math.random(math.ceil(recoils[wep] * 400))
                        recoilfactor = possiblerecoil/100
                        dicks = math.random(100)
                        recoilfactor = recoilfactor + myRecoilFactor + drivebyFactor
                        SetGameplayCamRelativePitch(p+recoilfactor,0.5)

                        
                        recoiling = recoiling - 1                     
                    end
                else
                    p = GetGameplayCamRelativePitch()
                    recoiling = 3
                    while recoiling > 0 do

                         possiblerecoil = math.random(math.ceil(recoils[wep] * 450))
                        recoilfactor = possiblerecoil/100
                        dicks = math.random(100)
                        recoilfactor = recoilfactor + myRecoilFactor + drivebyFactor
                        SetGameplayCamRelativePitch(p+recoilfactor,0.25)                      
                        recoiling = recoiling - 1                     
                    end
                end

            end
        end

    end

end)