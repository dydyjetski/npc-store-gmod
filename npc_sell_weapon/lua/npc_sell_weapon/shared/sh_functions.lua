function NPC_ARMORY.GetSentence(key)
    local result = "Language avaible : en | fr | es | ru | de"

    local sentence = istable(NPC_ARMORY.Languages[NPC_ARMORY.Lang]) and NPC_ARMORY.Languages[NPC_ARMORY.Lang][key] or nil

    if istable(NPC_ARMORY.Languages[NPC_ARMORY.Lang]) and isstring(sentence) then
        result = sentence 
    elseif istable(NPC_ARMORY.Languages["en"]) and isstring(NPC_ARMORY.Languages["en"][key]) then
        result = NPC_ARMORY.Languages["en"][key]
    end

    return result
end
