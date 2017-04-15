local assets=
{
    Asset("ANIM", "anim/zerosword.zip"),
    Asset("ANIM", "anim/swap_zerosword.zip"),
 
    Asset("ATLAS", "images/inventoryimages/zerosword.xml"),
    Asset("IMAGE", "images/inventoryimages/zerosword.tex"),
}

local function OnEquip(inst, owner)
        owner.AnimState:OverrideSymbol("swap_object", "swap_zerosword", "swap_katanas")
        owner.AnimState:Show("ARM_carry")
        owner.AnimState:Hide("ARM_normal")
    end
 
    local function OnUnequip(inst, owner)
        owner.AnimState:Hide("ARM_carry")
        owner.AnimState:Show("ARM_normal")
    end
 local function fn()
	local inst = CreateEntity()
	
	inst.entity:AddTransform()
	inst.entity:AddAnimState()
    inst.entity:AddNetwork()

    MakeInventoryPhysics(inst)
     
    inst.AnimState:SetBank("katanas")
    inst.AnimState:SetBuild("katanas")
    inst.AnimState:PlayAnimation("idle")
 
 if not TheWorld.ismastersim then
        return inst
    end
 
    inst.entity:SetPristine()
    
    inst:AddTag("sharp")

    inst:AddComponent("weapon")
    inst.components.weapon:SetDamage(42)
	inst.components.weapon.blinking = true
	inst.components.weapon:SetRange(5, 2)
	
	inst:AddComponent("tool")
	inst.components.tool:SetAction(ACTIONS.CHOP, 1)
    
 
    inst:AddComponent("inspectable")
	
     
    inst:AddComponent("inventoryitem")
	inst.components.inventoryitem.keepondeath = true
    inst.components.inventoryitem.imagename = "zerosword"
    inst.components.inventoryitem.atlasname = "images/inventoryimages/zerosword.xml"
     
    inst:AddComponent("equippable")
    inst.components.equippable:SetOnEquip( OnEquip )
    inst.components.equippable:SetOnUnequip( OnUnequip )
	inst.components.inventoryitem.keepondeath = true

    return inst
end
   
return  Prefab("common/inventory/zerosword", fn, assets, prefabs)
