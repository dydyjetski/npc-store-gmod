NPC_ARMORY.isMenuOpen = false

function NPC_ARMORY:OpenMenu()
    if NPC_ARMORY.isMenuOpen then return end
    NPC_ARMORY.isMenuOpen = true

    if IsValid(self.vMainMenu) then
        self.vMainMenu:Remove()
    end
    
    local vFrame = GtaLib:createMenu("AJ Menu", "Test subtitle")
    vFrame:setTitle(NPC_ARMORY.GetSentence("armory")) 
    vFrame:setSubtitle(NPC_ARMORY.GetSentence("principalDesc")) 
    vFrame:isClosable(true)
    vFrame.onClose = function() 
        NPC_ARMORY.isMenuOpen = false
    end
    self.vMainMenu = vFrame

    GtaLib:drawMenu(vFrame, function(menu)
        for _, category in ipairs(NPC_ARMORY.Config.Categories) do
            local subMenu = GtaLib:createSubMenu(vFrame, category.name, NPC_ARMORY.GetSentence("inSubmenu"), function(menu)
                for weaponName, weapon in pairs(category.items) do
                    local discountedPrice = weapon.price

                    if NPC_ARMORY.Config.Discount then
                        local playerRank = LocalPlayer():GetUserGroup() 
                        local discount = NPC_ARMORY.Config.Ranks[playerRank] or 0
                        if discount > 0 then
                            discountedPrice = weapon.price * (1 - discount)
                        end
                    end
                    local finalPrice = discountedPrice < weapon.price and discountedPrice .. " " .. NPC_ARMORY.Config.Devise or weapon.price .. " " .. NPC_ARMORY.Config.Devise

                    GtaLib:button(menu, weapon.name, weapon.description, {
                        onActive = function()
                            net.Start("DIDI:BUY_WEAPON")
                            net.WriteEntity(LocalPlayer())
                            net.WriteString(weaponName) 
                            net.SendToServer()
                            menu:close()
                            NPC_ARMORY.isMenuOpen = false
                        end,
                        onHovered = function()
                        end
                    }, { textColor = color_white, rightText = finalPrice })
                end
            end)

            GtaLib:button(menu, category.name, "", {
                onActive = function()
                end,
                onHovered = function()
                end
            }, { textColor = color_white, rightText = ">" }, subMenu)
        end

        GtaLib:lineSeparator(menu, { color = Color(255,255,255) })

        if NPC_ARMORY.Config.Robbery then
            GtaLib:button(menu, NPC_ARMORY.GetSentence("robberyButton"), "", {
                onActive = function()
                    net.Start("DIDI:START_ROB_TIMER")
                    net.WriteEntity(LocalPlayer())
                    net.SendToServer()
                    menu:close()
                end,
                onHovered = function()
                end
            }, { textColor = color_red, rightText = ""} )

            GtaLib:lineSeparator(menu, { color = Color(255,255,255) })
        end

        GtaLib:button(menu, NPC_ARMORY.GetSentence("closeButton"), "", {
            onActive = function()
                menu:close()
            end,
            onHovered = function()
            end
        }, { textColor = color_red, rightText = ""} )
    end)
end


net.Receive("DIDI:OPEN_NPC_ARMORY", function()
	NPC_ARMORY:OpenMenu()
end)