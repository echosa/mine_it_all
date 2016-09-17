--[[
TODO:
- Add registration function for mods to register block/tool combos
- Allow adding of groups like group:wood instead of just blocks
- Do not let tools mine more than their current wear amount allows
- Add hunger penalty (dependency on hunger mod)
]]

dofile(minetest.get_modpath("mine_it_all").."/mineable_nodes.lua")

local function is_node_vein_diggable(node, tool)
    for _,mineable_node in pairs(mia.enabled_nodes) do
        if node == mineable_node.node_name then
            for _,useable_tool in pairs(mineable_node.tools) do
                if useable_tool == tool then
                    return true
                end
            end
        end
    end
    return false
end

local function vein_dig(pos, node, digger)
    local itemstacks = minetest.get_node_drops(node)
    for _, itemname in ipairs(itemstacks) do
        digger:get_inventory():add_item('main', itemname)
    end
    minetest.remove_node(pos, node, digger)
end

local function remove_touching_nodes(pos, node, digger)
    local dig_count = 0
    vein_dig(pos, node, digger)
    dig_count = dig_count + 1

    local nearby = minetest.find_nodes_in_area({x=pos.x-1, y=pos.y-1, z=pos.z-1}, {x=pos.x+1, y=pos.y+1, z=pos.z+1}, {node})

    for _,vein_pos in ipairs(nearby) do
        vein_dig(vein_pos, node, digger)
        dig_count = dig_count + remove_touching_nodes(vein_pos, node, digger)
    end

    return dig_count
end

minetest.register_on_dignode(function(pos, node, digger)
    local current_tool = digger:get_wielded_item():get_name()
    if digger:get_player_control().sneak and is_node_vein_diggable(node.name, current_tool) then
        local dig_count = remove_touching_nodes(pos, node.name, digger)

        local def = ItemStack({name=node.name}):get_definition()
        local wielded = digger:get_wielded_item()
        local wdef = wielded:get_definition()
        local tp = wielded:get_tool_capabilities()
        local dp = core.get_dig_params(def.groups, tp)
        if wdef and wdef.after_use then
            wielded = wdef.after_use(wielded, digger, node, dp) or wielded
        elseif not core.setting_getbool("creative_mode") then
            -- Wear out tool
            wielded:add_wear(dp.wear * dig_count)
        end
        digger:set_wielded_item(wielded)

    end
end)
