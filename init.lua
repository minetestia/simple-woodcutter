local max_distance, max_radius, delay = 20, 4, 0.1

minetest.register_on_dignode(function(pos, oldnode, digger)
  if not minetest.registered_nodes[oldnode.name].groups.tree then return end
  local groups = digger:get_wielded_item():get_definition().groups
  if not groups or not groups.axe then return end
  if digger:get_hp() == 0 then return end
  if not minetest.get_player_by_name(digger:get_player_name()) then return end
  minetest.after(delay, function()
    pos = minetest.find_node_near(pos, max_radius, oldnode.name)
    if not pos then return end
    if pos:distance(digger:get_pos()) > max_distance then return end
    minetest.node_dig(pos, minetest.get_node(pos), digger)
  end)
end)
