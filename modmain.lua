 -- Import the lib use.
modimport("libs/env.lua")
 
-- Disable the map screen.
use "data/screens/mapscreen" 

-- Actions Initialization.
use "data/actions/init"

-- Component Initialization.
use "data/components/init"


PrefabFiles = {
	"zero",
	"zero_none",
	"zerosword",
}

Assets = {
    Asset( "IMAGE", "images/saveslot_portraits/zero.tex" ),
    Asset( "ATLAS", "images/saveslot_portraits/zero.xml" ),

    Asset( "IMAGE", "images/selectscreen_portraits/zero.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/zero.xml" ),
	
    Asset( "IMAGE", "images/selectscreen_portraits/zero_silho.tex" ),
    Asset( "ATLAS", "images/selectscreen_portraits/zero_silho.xml" ),

    Asset( "IMAGE", "bigportraits/zero.tex" ),
    Asset( "ATLAS", "bigportraits/zero.xml" ),
	
	Asset( "IMAGE", "images/map_icons/zero.tex" ),
	Asset( "ATLAS", "images/map_icons/zero.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_zero.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_zero.xml" ),
	
	Asset( "IMAGE", "images/avatars/avatar_ghost_zero.tex" ),
    Asset( "ATLAS", "images/avatars/avatar_ghost_zero.xml" ),
	
	Asset( "IMAGE", "images/avatars/self_inspect_zero.tex" ),
    Asset( "ATLAS", "images/avatars/self_inspect_zero.xml" ),
	
	Asset( "IMAGE", "images/names_zero.tex" ),
    Asset( "ATLAS", "images/names_zero.xml" ),
	
    Asset( "IMAGE", "bigportraits/zero_none.tex" ),
    Asset( "ATLAS", "bigportraits/zero_none.xml" ),

}

local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS
local SpawnPrefab = GLOBAL.SpawnPrefab


AddPlayerPostInit(function(inst)
   if inst.components.combat == nil then
        return
    end
	if GLOBAL.TheWorld.ismastersim then
		local old_start = inst.components.combat.StartAttack
		inst.components.combat.StartAttack = function(self)
			old_start(self)
			if self.target then
				local weapon = self:GetWeapon()
				if weapon and weapon.components.weapon and weapon.components.weapon.blinking then
					local distance = math.sqrt(self.inst:GetDistanceSqToInst(self.target))
					local hitrange = weapon.components.weapon.hitrange
					if distance > hitrange then
						local smoke1 = SpawnPrefab("maxwell_smoke")
						local smoke2 = SpawnPrefab("maxwell_smoke")
						local sx, sy, sz = self.inst.Transform:GetWorldPosition()
						smoke1.Transform:SetPosition(sx, sy, sz)
						local fx, fy, fz = self.target.Transform:GetWorldPosition()
						local q = (distance - hitrange + 0.2) / distance
						local dx = sx - q * (sx - fx)
						local dy = sy - q * (sy - fy)
						local dz = sz - q * (sz - fz)
						inst.Transform:SetPosition(dx, dy, dz)
						smoke2.Transform:SetPosition(dx, dy, dz)
					end
				end
			end
		end
	end
end)

 function _G.IsDontStarveTogether()
return kleifileexists("scripts/networking.lua") and true or false
end


-- The character select screen lines
STRINGS.CHARACTER_TITLES.zero = "The Intoner"
STRINGS.CHARACTER_NAMES.zero = "Zero"
STRINGS.CHARACTER_DESCRIPTIONS.zero = "*Perk 1\n*Perk 2\n*Perk 3"
STRINGS.CHARACTER_QUOTES.zero = "\"Quote\""

GLOBAL.STRINGS.NAMES.ZEROSWORD = "Zero's sword"
GLOBAL.STRINGS.CHARACTERS.GENERIC.DESCRIBE.ZEROSWORD = "a set of sharpened swords"
-- Custom speech strings
STRINGS.CHARACTERS.ZERO = require "speech_zero"

-- The character's name as appears in-game 
STRINGS.NAMES.ZERO = "Zero"

AddMinimapAtlas("images/map_icons/zero.xml")

-- Add mod character to mod character list. Also specify a gender. Possible genders are MALE, FEMALE, ROBOT, NEUTRAL, and PLURAL.
AddModCharacter("zero", "FEMALE")
