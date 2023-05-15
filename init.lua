local mt, ms = minetest, minetest.settings
local max_distance = tonumber(ms:get "simple_woodcutter.max_distance") or 40
local max_radius = tonumber(ms:get "simple_woodcutter.max_radius") or 1
local delay = tonumber(ms:get "simple_woodcutter.delay") or 0.01
local S = mt.get_translator(mt.get_current_modname())
local privilege = { description = S "Player can fell trees quickly." }
mt.register_privilege("lumberjack", privilege)

local function chop_around(pos, oldnode, digger)
  local d = delay
  if not mt.check_player_privs(digger, "lumberjack") then d = d * 100 end
  mt.after(d, function()
    local next_pos = mt.find_node_near(pos, max_radius, oldnode.name)
    if not next_pos then return end
    local digger_pos = digger:get_pos()
    if not digger_pos then return end
    if pos:distance(digger_pos) > max_distance then return end
    mt.node_dig(next_pos, mt.get_node(next_pos), digger)
    chop_around(pos, oldnode, digger)
  end)
end

---@param digger mt.PlayerObjectRef
mt.register_on_dignode(function(pos, oldnode, digger)
  if not digger:is_player() then return end
  if not mt.registered_nodes[oldnode.name].groups.tree then return end
  if not digger:get_wielded_item():get_definition().groups.axe then return end
  if digger:get_hp() == 0 then return end
  chop_around(pos, oldnode, digger)
end)
