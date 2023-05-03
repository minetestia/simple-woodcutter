local max_distance, max_radius, delay = 40, 1, 0.01

local function chop_around(pos, oldnode, digger)
  local next_pos = minetest.find_node_near(pos, max_radius, oldnode.name)
  if not next_pos then return end
  local digger_pos = digger:get_pos()
  if not digger_pos then return end
  if pos:distance(digger_pos) > max_distance then return end
  minetest.node_dig(next_pos, minetest.get_node(next_pos), digger)
  minetest.after(delay, chop_around, pos, oldnode, digger)
end

minetest.register_on_dignode(function(pos, oldnode, digger)
  if not minetest.registered_nodes[oldnode.name].groups.tree then return end
  if not digger:get_wielded_item():get_definition().groups.axe then return end
  if digger:get_hp() == 0 then return end
  minetest.after(delay, chop_around, pos, oldnode, digger)
end)
