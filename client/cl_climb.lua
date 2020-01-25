local climbcooldowntime_ms = 200
local tpnbmax = 8
local mult1 = 30
local mult2 = 110

local climbing = false
local isclimbcooldown = false

local climbposx = 0
local climbposy = 0
local climbposz = 0

local numbertp = 0

AddEvent("OnGameTick",function(ds)
    if climbing ==false then
    if GetPlayerMovementMode(GetPlayerId()) == 5 then
    local x, y, z = GetPlayerLocation()
    local fx,fy,fz = GetPlayerForwardVector(GetPlayerId())
    local hittype, hitid, impactX1, impactY1, impactZ1 = LineTrace(x+fx*mult1,y+fy*mult1,z+fz*mult1,x+fx*mult2,y+fy*mult2,z+fz*mult2)
    if hittype~= 2 then
        if (impactX1~=0 and impactY1~=0 and impactZ1~=0) then
            climbposx=impactX1+fx*10
            climbposy=impactY1+fy*10
            local hittype, hitid, impactX2, impactY2, impactZ2 = LineTrace(x+fx*mult1,y+fy*mult1,z+70,x+fx*mult1,y+fy*mult1,z+150)
            z=z+35
            if (hittype~= 2 and impactX2==0 and impactY2==0 and impactZ2==0) then
              local hittype, hitid, impactX3, impactY3, impactZ3 = LineTrace(x+fx*mult1,y+fy*mult1,z+fz*mult1,x+fx*mult2,y+fy*mult2,z+fz*mult2)
              if (hittype~= 2 and impactX3==0 and impactY3==0 and impactZ3==0) then
                if (GetPlayerMovementSpeed(GetPlayerId())<700 and isclimbcooldown==false) then
                 isclimbcooldown=true
                 climbing=true
                 climbposz=z+150
                 SetIgnoreMoveInput(true)
                end
              end
            end
        end
    end
    end
else
    if numbertp<=tpnbmax then
        actor = GetPlayerActor(GetPlayerId())
        numbertp=numbertp+1
        local x, y, z = GetPlayerLocation()
        local addx = (climbposx-x)/tpnbmax
        local addy = (climbposy-y)/tpnbmax
        local addz = (climbposz-z)/tpnbmax
        actor:SetActorLocation(FVector(x+addx, y+addy, z+addz))
    else
        climbing=false
        numbertp=0
        SetIgnoreMoveInput(false)
        Delay(climbcooldowntime_ms,function()
         isclimbcooldown=false
        end)
    end
end
end)