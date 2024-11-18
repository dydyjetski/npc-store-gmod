function NPC_ARMORY.GetSentence(key)
    local result = "Language avaible : en | fr | es | ru | de"

    local sentence = istable(NPC_ARMORY.Language[NPC_ARMORY.Lang]) and NPC_ARMORY.Language[NPC_ARMORY.Lang][key] or nil

    if istable(NPC_ARMORY.Language[NPC_ARMORY.Lang]) and isstring(sentence) then
        result = sentence 
    elseif istable(NPC_ARMORY.Language["en"]) and isstring(NPC_ARMORY.Language["en"][key]) then
        result = NPC_ARMORY.Language["en"][key]
    end

    return result
end