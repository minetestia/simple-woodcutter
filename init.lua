local max_distance = 20
local diggers = {}

local function start_process(pos, oldnode, digger)
  pos = minetest.find_node_near(pos, 4, oldnode.name)
  if not pos then return end
  if pos:distance(digger:get_pos()) > max_distance then return end
  minetest.node_dig(pos, minetest.get_node(pos), digger)
end

local function stop_process(digger)
  local name = digger:get_player_name()
  local process = diggers[name]
  if process then
    process:cancel()
    diggers[name] = nil
  end
  return name
end

minetest.register_on_dignode(function(pos, oldnode, digger)
  if not minetest.registered_nodes[oldnode.name].groups.tree then return end
  local groups = digger:get_wielded_item():get_definition().groups
  if not groups or not groups.axe then return end
  local name = stop_process(digger)
  diggers[name] = minetest.after(0.1, start_process, pos, oldnode, digger)
end)

minetest.register_on_dieplayer(stop_process)
minetest.register_on_leaveplayer(stop_process)
