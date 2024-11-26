-- Notify a player with the specified message
local robberyCooldowns = {}
local lastRobberyTime = 0

local function hasValidWeapon(ply)
	local weaponInHand = ply:GetActiveWeapon()
	return IsValid(weaponInHand) and table.HasValue(NPC_ARMORY.Config.ValidRobberyWeapons, weaponInHand:GetClass())
end


function NPC_ARMORY:Notify(pPlayer, sContent, id)
	
	assert(IsValid(pPlayer) and pPlayer:IsPlayer(), "Unable to notify an invalid player entity")
	
	if DarkRP then
		return DarkRP.notify(pPlayer, id, 5, sContent)
	end
	
	return pPlayer:PrintMessage(HUD_PRINTTALK, sContent)
	
end

local function isPlayerInAABox(ply, zone)
    local playerPos = ply:GetPos() 
    return playerPos:WithinAABox(zone.boxStart, zone.boxEnd)
end

net.Receive("DIDI:BUY_WEAPON", function(len, ply)
	
	local sender = net.ReadEntity()
	if sender ~= ply then return end
	local sWeapon = net.ReadString()
	
    local tWeapon = nil

    for _, category in ipairs(NPC_ARMORY.Config.Categories) do
        if category.items[sWeapon] then
            tWeapon = category.items[sWeapon]
			cat = category
            break
        end
    end

    if cat.useZone and cat.zone and isPlayerInAABox(ply, cat.zone) then
        return NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("notInZone"), 1)
    end

	if not tWeapon then
		return NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("invalidWeapon"), 1)
	end

	if ply:HasWeapon(tWeapon.entity) then
        return NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("haveWeapon"), 1)
    end

	if not ply:canAfford(tWeapon.price) then
		return NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("donthaveMoney"), 1)
	end

	local finalPrice = tWeapon.price

	if NPC_ARMORY.Config.Discount then
		local playerRank = ply:GetUserGroup()
		local discount = NPC_ARMORY.Config.Ranks[playerRank] or 0 
		finalPrice = tWeapon.price * (1 - discount)
	end
	
	ply:addMoney(-finalPrice)
	ply:Give(tWeapon.entity)
	NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("buy") .. tWeapon.name .. NPC_ARMORY.GetSentence("for") .. finalPrice .. NPC_ARMORY.Config.Devise, 0)
	ply:EmitSound("gta_sound/pay.mp3")
end)

net.Receive("DIDI:START_ROB_TIMER", function(len, ply)
	local timerName = "RobberyTimer_" .. ply:SteamID()
	if timer.Exists(timerName) then
		NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("alreadyRobbery"), 1)
		return
	end

	local sender = net.ReadEntity()
	if sender ~= ply then return end
	local currentTime = os.time()

    if currentTime - lastRobberyTime < NPC_ARMORY.Config.RobberyCooldown then
        local timeLeft = NPC_ARMORY.Config.RobberyCooldown - (currentTime - lastRobberyTime)
        NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("needtoWait") .. timeLeft .. NPC_ARMORY.GetSentence("afterWait"), 1)
        return
    end

    local npcEntity = ents.FindByClass("npc_armory")[1] 
    if not IsValid(npcEntity) then return end

	if ply:GetPos():Distance(npcEntity:GetPos()) > 150 then
        NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("distanceToNPC"), 1)
        return
    end

	if NPC_ARMORY.Config.NeedWeaponForRobbery then 
		if not hasValidWeapon(ply) then
			NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("needWeapon"), 1)
			return  
		end
	end

	for _, player in ipairs(player.GetAll()) do
		player:ChatPrint(NPC_ARMORY.GetSentence("globalRobberyAlert"))
	end

    timer.Create(timerName, 2, NPC_ARMORY.Config.RobberyTimer, function()
        if not IsValid(ply) then
            timer.Remove(timerName)
            return
        end

        local currentPos = ply:GetPos()
        if npcEntity:GetPos():Distance(currentPos) > 150 then
            NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("robberyFailDistance"), 1)
            timer.Remove(timerName)
        end
		if NPC_ARMORY.Config.NeedWeaponForRobbery then
			if not hasValidWeapon(ply) then
				NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("needWeaponRobbery"), 1)
				timer.Remove(timerName)  
				return
			end
		end
    end)
	NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("robbery") .. NPC_ARMORY.Config.RobberyTimer .. NPC_ARMORY.GetSentence("sec") , 0)
    timer.Simple(NPC_ARMORY.Config.RobberyTimer, function()
        if not IsValid(ply) then return end
        if timer.Exists(timerName) then 
            ply:addMoney(NPC_ARMORY.Config.RobberyReward) 
            NPC_ARMORY:Notify(ply, NPC_ARMORY.GetSentence("goodRobbery") .. NPC_ARMORY.Config.RobberyReward .. NPC_ARMORY.Config.Devise, 0)
            ply:EmitSound("gta_sound/pay.mp3") 
			lastRobberyTime = currentTime
            timer.Remove(timerName)
        end
    end)
end)
