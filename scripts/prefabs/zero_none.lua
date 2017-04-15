local assets =
{
	Asset( "ANIM", "anim/zero.zip" ),
	Asset( "ANIM", "anim/ghost_zero_build.zip" ),
}

local skins =
{
	normal_skin = "zero",
	ghost_skin = "ghost_zero_build",
}

local base_prefab = "zero"

local tags = {"ZERO", "CHARACTER"}

return CreatePrefabSkin("zero_none",
{
	base_prefab = base_prefab, 
	skins = skins, 
	assets = assets,
	tags = tags,
	
	skip_item_gen = true,
	skip_giftable_gen = true,
})