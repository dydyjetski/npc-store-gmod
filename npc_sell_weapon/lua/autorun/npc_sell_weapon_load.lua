-- Loader file for 'npc_sell_weapon'
-- Automatically created by gcreator (github.com/wasied)
NPC_ARMORY = {}

-- Make loading functions
local function Inclu(f) return include("npc_sell_weapon/"..f) end
local function AddCS(f) return AddCSLuaFile("npc_sell_weapon/"..f) end
local function IncAdd(f) return Inclu(f), AddCS(f) end

-- Load addon files
IncAdd("config.lua")
IncAdd("languages.lua")
IncAdd("shared/sh_functions.lua")
-- IncAdd("constants.lua")

if SERVER then

	resource.AddSingleFile("resource/fonts/MontserratWasied-Bold.ttf")
	resource.AddSingleFile("resource/fonts/MontserratWasied-ExtraBold.ttf")
	resource.AddSingleFile("resource/fonts/MontserratWasied-Light.ttf")
	resource.AddSingleFile("resource/fonts/MontserratWasied-Medium.ttf")
	resource.AddSingleFile("resource/fonts/MontserratWasied-SemiBold.ttf")
	resource.AddSingleFile("resource/fonts/MontserratWasied-Thin.ttf")
	resource.AddSingleFile("resource/fonts/MontserratWasied-Italic.ttf")

	Inclu("server/sv_functions.lua")
	Inclu("server/sv_hooks.lua")
	Inclu("server/sv_network.lua")

	AddCS("client/cl_functions.lua")
	AddCS("client/cl_hooks.lua")
	AddCS("client/cl_interface.lua")

else

	Inclu("client/cl_functions.lua")
	Inclu("client/cl_hooks.lua")
	Inclu("client/cl_interface.lua")

end
