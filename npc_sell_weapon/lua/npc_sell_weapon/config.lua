NPC_ARMORY.Config = {}

NPC_ARMORY.Lang = "fr" -- Langage of the Addon ( en, fr, pl, tr, ru, cn, de )

NPC_ARMORY.Config.Devise = "€" // FR: Devise de votre serveur | EN: Currency of your server

-- NPC --
NPC_ARMORY.Config.NPCModel = "models/odessa.mdl" // FR: Modèle de l'entité | EN: Model of the entity

NPC_ARMORY.Config.SayHi = false // true = say hi, false = don't say hi | FR: true = dire bonjour, false = ne pas dire bonjour
NPC_ARMORY.Config.SayHiSound = "vo/npc/male01/hi01.wav" // FR: Son de l'entité | EN: Sound of the entity. (https://wiki.facepunch.com/gmod/HL2_Sound_List)

NPC_ARMORY.Config.ColorTextAboveNPC = Color(255, 255, 255) // FR: Couleur du texte au dessus de l'entité (RVB)| EN: Color of the text above the entity (RGB)

-- RESTRICTION IF JOB IS PRESENT / RESTRICTION SI UN TRAVAIL EST PRÉSENT --
NPC_ARMORY.Config.RestrictIfGunDealer = false // true = restrict if gun dealer was avaible, false = don't restrict | FR: true = restreindre si un armurier est en ville, false = ne pas restreindre
NPC_ARMORY.Config.AllowedTeams = { // if yes above, team gun dealer for restrict acces to players | FR: si oui au dessus, team armurier pour resteindre l'accès aux autres joueurs.
    TEAM_GUN
    -- TEAM_CITIZEN
}

--[[ BYPASS BY RANK / EVITER LA RESTRICTION SI UN ARMURIER EST EN VILLE PAR GRADE POUR CERTAINS GROUPES ]]--
NPC_ARMORY.Config.BypassByRank = false // true = bypass by rank, false = don't bypass | FR: true = exempté par grade, false = ne pas exempter
NPC_ARMORY.Config.BypassRank = {
    "superadmin", -- FR: Grade accès au PNJ même si un armurier est en ville | EN: Rank access to the NPC even if a gun dealer is in town
    "admin"
}

--[[ RESTRICTION BY RANK / RESTRICTION PAR GRADE ]]--
NPC_ARMORY.Config.RestrictByRank = false // true = restrict by rank, false = don't restrict | FR: true = restreindre par grade, false = ne pas restreindre
NPC_ARMORY.Config.RankRestrict = {
    "user"       -- exemple de grade restreint
}

--[[ RESTRICTION BY LEVEL / RESTRICTION PAR NIVEAU (https://github.com/uen/Leveling-System) ]]--
NPC_ARMORY.Config.RestrictForLevel = false -- EN: true = bypass by level, false = don't bypass | FR: true = exempté par niveau, false = ne pas exempter
NPC_ARMORY.Config.NeededLevel = 2 -- FR: Niveau minimum requis pour éviter la restriction | EN: Minimum level required to avoid restriction

-- DISCOUNT--
NPC_ARMORY.Config.Discount = false // true = enable discount, false = disable discount | FR: true = activer la réduction, false = désactiver la réduction
NPC_ARMORY.Config.Ranks = { 
    ["superadmin"] = 0.5, -- 50% discount
}

-- ROBBERY SYSTEM / SYSTÈME DE BRAQUAGE --
NPC_ARMORY.Config.Robbery = true // true = enable robbery, false = disable robbery | FR: true = activer le braquage, false = désactiver le braquage
NPC_ARMORY.Config.RobberyReward = 5000 // FR: Récompense du braquage | EN: Robbery reward
NPC_ARMORY.Config.RobberyTimer = 10 // FR: Durée du braquage | EN: Robbery duration
NPC_ARMORY.Config.RobberyCooldown = 30 // FR: Temps de recharge du braquage | EN: Robbery cooldown
NPC_ARMORY.Config.NeedWeaponForRobbery = false // FR: Besoin d'une arme pour braquer? | EN: Need a weapon to rob?
NPC_ARMORY.Config.ValidRobberyWeapons = {
    "fas2_ak47",   -- Remplacez par les noms d'armes valides
    "weapon_357", -- class of allowed weapons
    "weapon_smg1",
    "weapon_ar2",
    -- Ajoutez d'autres armes ici
}

-- Exemple de structure de configuration pour des catégories personnalisées
-- Create your own categorie!
NPC_ARMORY.Config.Categories = {
    {
        name = "Fusil d'assaut", -- Nom de la catégorie
        items = { -- Les armes dans cette catégorie
            ["Ak-47"] = {
                name = "AK-47",
                entity = "fas2_ak47",
                description = "",
                price = 3000,
            },
            ["Lockpick"] = {
                name = "Lockpick",
                entity = "lockpick",
                description = "Fusil d'assaut populaire, utilisé par les forces armées.",
                price = 1000,
            },
        }
    },
    {
        name = "BEST ADDONS!", -- Nom de la catégorie
        items = { -- Les armes dans cette catégorie
            ["Bayonet Knife"] = {
                name = "Bayonet Knife",
                entity = "csgo_bayonet",
                description = "",
                price = 400,
            },
            ["Bayonet Knifee"] = {
                name = "Bayonet Knifee",
                entity = "csgo_bayonet",
                description = "",
                price = 400,
            },
        }
    },
    {
        name = "Bonjour", -- Nom de la catégorie
        items = { -- Les armes dans cette catégorie
            ["BANANA"] = {
                name = "BANANA",
                entity = "weapon_banana_pistol",
                description = "",
                price = 400,
            },
            ["Bayonet Knifee"] = {
                name = "Bayonet Knifee",
                entity = "csgo_bayonet",
                description = "",
                price = 400,
            },
        }
    },
    -- Ajoutez d'autres catégories selon les besoins
}
