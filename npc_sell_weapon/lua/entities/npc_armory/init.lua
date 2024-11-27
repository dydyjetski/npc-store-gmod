AddCSLuaFile("entities/npc_armory/cl_init.lua")
AddCSLuaFile("entities/npc_armory/shared.lua")

include ("entities/npc_armory/shared.lua")

function ENT:Initialize()

    self:SetModel(NPC_ARMORY.Config.NPCModel) 
    self:SetHullType(HULL_HUMAN)
    self:SetHullSizeNormal()
    self:SetNPCState(NPC_STATE_SCRIPT)
    self:SetSolid(SOLID_BBOX)
    self:SetUseType(SIMPLE_USE)
    self:DropToFloor()
    
end

local cooldowns = {}

function ENT:Use(activator, caller)
    
    if not IsValid(activator) or not activator:IsPlayer() then return end
    
    local distance = activator:GetPos():DistToSqr(self:GetPos())
    if distance > 1000 then return end
    
    local steamID = activator:SteamID() 
    if cooldowns[steamID] and CurTime() < cooldowns[steamID] then
        return 
    end

    local playerRank = activator:GetUserGroup()
    local playerLevel = activator:getDarkRPVar("level") or 0
    local isBypass = false

    
    if NPC_ARMORY.Config.BypassByRank then
        for _, exemptRank in ipairs(NPC_ARMORY.Config.BypassRank) do
            if playerRank == exemptRank then
                isBypass = true
                break
            end
        end
    end

    if NPC_ARMORY.Config.RestrictForLevel then
        if playerLevel >= NPC_ARMORY.Config.NeededLevel then
            isBypass = true
        end
    end

    if NPC_ARMORY.Config.RestrictIfGunDealer then
        local teamPresent = false


        for _, player in ipairs(player.GetAll()) do
            if isBypass then break end
            for _, allowedTeam in ipairs(NPC_ARMORY.Config.AllowedTeams) do
                if player:Team() == allowedTeam then
                    teamPresent = true
                    break
                end
            end
            if teamPresent then
                break
            end
        end

        if teamPresent then
            return NPC_ARMORY:Notify(activator, NPC_ARMORY.GetSentence("msgifGunDealer"), 1)
        end
    end

    if NPC_ARMORY.Config.RestrictByRank then
        for _, restrictedRank in ipairs(NPC_ARMORY.Config.RankRestrict) do
            if playerRank == restrictedRank then
                return NPC_ARMORY:Notify(activator, NPC_ARMORY.GetSentence("msgRefuseAccess"), 1)
            end
        end
    end

    if NPC_ARMORY.Config.SayHi then
        self:EmitSound("vo/npc/male01/hi01.wav")
    end
    
    net.Start("DIDI:OPEN_NPC_ARMORY")
    net.Send(activator)
    
end
