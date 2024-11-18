-- Clear fonts cache after a screen size change
hook.Add("OnScreenSizeChanged", "NPC_ARMORY:OnScreenSizeChanged", function()
	NPC_ARMORY.Fonts = {}
end)