esemics={}
esemics.prism_recipes={}

--[[ Example
esemics.register_prism_recipe({
result="item:name"
recipe={
"item:one",
"item:two",
"item:etcetera"
},
catalyst={
"item:three"
"etc:etera"
},
},
time=30 -- seconds
time_randomness=3 -- time ± math.random(0,time_randomness) -- optional
})
]]

function esemics.register_prism_recipe(def)
  print("\n\n\n\nregistering recipe\n\n\n\n")
  --def.type = "catalyst"
  if def.recipe== nil or def.recipe == nil or def.catalysts == nil then
    print("nil recipe")
    return nil
  end
  if def.result == nil then
    print("nil result")
  end
  if def.time == nil then
    print("nil dust time")
    time = 30
  end
  if def.time_randomness == nil then
    def.time_randomness = 0
  end
  print("registered new prisming recipe")
  print("result = "..def.result)
  print("dust_time = "..def.time)
  -- now that all that is checked and fixed lets actually do something with this
  table.insert(esemics.prism_recipes,#esemics.prism_recipes+1,def)
  print("\n\nrecipe registered\n\n")
end

local function itemize(itemstack)
  local self = itemstack
  print("-------------------------")
  print(type(self))
  print(tostring(self))
  print(type(itemstack))
  print(tostring(itemstack))
  print("-------------------------")
  if self == nil or itemstack == nil then
    function get_name()
      return ""
    end
    function get_count()
      return 0
    end
  end
  --local function get_name
  --local get_name, get_count
  if type(self) == "table" then	-- StackTable, easy peasy
    local function get_name()
      return self.name
    end
    local function get_count()
      return tostring(self.count)
    end
  elseif type(self) == "string" then	-- StackString, a little bit more tricky
    local parts = self:split(" ")
    local name = parts[1]
    local count = parts[2]
    local wear = parts[3]
    local meta = parts[4]
    local function get_name()
      return name
    end
    local function get_count()
      return count
    end
  end
  if get_name == nil or get_count == nil then
    print("UGH IT IS NIL FOR BOBS DAD")
  end
  return {
    get_name = get_name,
    get_count = get_count
  }
end

function esemics.get_craft_result(def)
  print("beginning recipe sweep")
  local o = {                         -- output table
    time = 0,                         -- output time
    item = ""                         -- output item
  }
  local d = {                         -- decremented input table
    items = {},                        -- decremented input items
    catalysts = {}		      -- decremented catalyst table
  }
  local mismatched = false
  for _,arecipe in pairs(esemics.prism_recipes) do
  local product = arecipe.result
  print("recipe for "..product)
  for itn,item in pairs(def.recipe) do
  --local item = itemize(itemstr)
  for ctn,catalyst in pairs(def.catalysts) do
  --local catalyst = itemize(catalyststr)
  for _,curitemstr in pairs(arecipe.recipe) do
  local curitem = itemize(curitemstr)
  for _,curcatstr in pairs(arecipe.catalysts) do
  local curcat = itemize(curcatstr)
    print(arecipe.result)
    print(item:get_name().."×"..item:get_count())
    print(catalyst:get_name().."×"..catalyst:get_count())
    if string.match(curitem,"group:") then
      print("it be group")
      local grouptbl = string.split(curitem,":")
      local groupstr = grouptbl[2]
      print(groupstr)
      if minetest.get_node_group(item:get_name(), groupstr) > 0 then
        print("group match for "..groupstr)
        if itn == 4 then
          o.item = product -- curitem                            -- set output items
          print(o.item)
          o.time = arecipe.time                         -- set output time
          print(o.time)
          d.items[itn] = curitem                            -- set decremented input items
          print(d.items[itn])
          print("o.items ="..o.items)
          print("o.time ="..o.time)
          print("d.items ="..d.items)
        end
      end
    elseif string.match(curcat,"group:") then
      print("cat be group")
      local grouptbl = string.split(curcat,":")
      local groupstr = grouptbl[2]
      print(groupstr)
      if minetest.get_node_group(catalyst:get_name(), groupstr) > 0 then
        print("group match for "..groupstr)
        if ctn == 4 then
          o.item = product -- curcat                            -- set output items
          print(o.item)
          o.time = arecipe.time                         -- set output time
          print(o.time)
          d.catalysts[ctn] = curcat                            -- set decremented input items
          print(d.catalysts[ctn])
          --print("o.items ="..o.items)
          --print("o.time ="..o.time)
          --print("d.items ="..d.items)
        end
      end
    elseif item:get_name() == curitem:get_name() then
      print("node match")
      if itn == 4 then
        o.item = product
        o.time = arecipe.time
        d.items[itn] = curitem
      end
    elseif catalyst:get_name() == curcat:get_name() then
      print("cat match")
      if ctn == 4 then
        o.item = product
        o.time = arecipe.time
        d.catalysts[ctn] = curcat
      end
    else
      mismatched = true
      print("mismatched items at item index #"..itn..", catalyst #"..ctn)
    end
    if mismatched == true then
      o = {
        item = "mismatched",
        time = -1
      }
      d = {
        items = def.items,
        catalysts = def.catalysts
      }
    else
      print("no mismatched items or catalysts, item #"..itn..", catalyst #"..ctn)
    end
      --[[elseif arecipe.recipe == def.items:get_name() then         -- if so, then check that the recipe output is the same as defined items
        print("oh chickie just died")
        o.items = arecipe.output                            -- if so, then set output items
        print(o.items[1])
        o.time = arecipe.time                     -- set output time
        print(o.time)
        d.items = arecipe.recipe                            -- set decremented input items
        print(o.items[1])
        print("o.items ="..o.items)
        print("o.time ="..o.time)
        print("d.items ="..d.items)
        break
        --return o,d                                                        -- return output and decremented input
      else
        print("beeb "..arecipe.recipe.." ~= "..def.items:get_name())
        o = {
          items = "",
          time = 0
        }
        d = {
          items = "",
        }
        print("o.items ="..o.items)
        print("o.time ="..o.time)
        print("d.items ="..d.items)
      end
      --end
      return o,d                                                        -- return output and decremented input
    end]]
  end
  end
  end
  end
  end
  return o,d
end

local srcpost = {2.75,0}
local catpost = {2.75,3}
local dstpost = {4.75,2}
local firpost = {2.75,2}
local imgpost = {3.75,2}
local ivhpost = {0,5}
local ivmpost = {0,6}
local function mkstr(tbl)
	local x = tbl[1]
	local y = tbl[2]
	return x..","..y
end
local srcpos = mkstr(srcpost)
local catpos = mkstr(catpost)
local dstpos = mkstr(dstpost)
local firpos = mkstr(firpost)
local imgpos = mkstr(imgpost)
local ivhpos = mkstr(ivhpost)
local ivmpos = mkstr(ivmpost)

local function active_formspec(reaction_percent, item_percent)
  local formspec =
    "size[8,8.5]"..
    default.gui_bg..
    default.gui_bg_img..
    default.gui_slots..
    "list[current_name;src;"..srcpos..";2,2;]"..
    "list[current_name;catalyst;"..catpos..";2,2;]"..
    "image["..firpos..";1,1;default_furnace_fire_bg.png^[lowpart:"..
    (100-reaction_percent)..":default_furnace_fire_fg.png^[multiply:#ff00ffc8]"..
    "image["..imgpos..";1,1;gui_furnace_arrow_bg.png^[lowpart:"..
    (item_percent)..":gui_furnace_arrow_fg.png^[transformR270]"..
    "list[current_name;dst;"..dstpos..";1,1;]"..
    "list[current_player;main;"..ivhpos..";8,1;]"..
    "list[current_player;main;"..ivmpos..";8,3;8]"..
    "listring[current_name;dst]"..
    "listring[current_player;main]"..
    "listring[current_name;src]"..
    "listring[current_player;main]"..
    "listring[current_name;catalyst]"..
    "listring[current_player;main]"..
    default.get_hotbar_bg(ivhpost[1], ivhpost[2])
  return formspec
end

local inactive_formspec =
  "size[8,8.5]"..
  default.gui_bg..
  default.gui_bg_img..
  default.gui_slots..
  "list[current_name;src;"..srcpos..";2,2;]"..
    "list[current_name;catalyst;"..catpos..";2,2;]"..
  "image["..firpos..";1,1;default_furnace_fire_bg.png^[multiply:#ff00ffc8]"..
  "image["..imgpos..";1,1;gui_furnace_arrow_bg.png^[transformR270]"..
  "list[current_name;dst;"..dstpos..";1,1;]"..
    "list[current_player;main;"..ivhpos..";8,1;]"..
    "list[current_player;main;"..ivmpos..";8,3;8]"..
  "listring[current_name;dst]"..
  "listring[current_player;main]"..
  "listring[current_name;src]"..
  "listring[current_player;main]"..
  "listring[current_name;catalyst]"..
  "listring[current_player;main]"..
  default.get_hotbar_bg(ivhpost[1], ivhpost[2])
--end
local function can_dig(pos, player)
  local meta = minetest.get_meta(pos);
  local inv = meta:get_inventory()
  return inv:is_empty("catalyst") and inv:is_empty("dst") and inv:is_empty("src")
end

local function allow_metadata_inventory_put(pos, listname, index, stack, player)
  if minetest.is_protected(pos, player:get_player_name()) then
    return 0
  end
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()
  print(listname)
  if listname == "catalyst" then
    --local deci = {}
    local catalystlist = inv:get_list("catalyst")
    local srclist = inv:get_list("src")
    print(stack:get_name())
    local itm, deci = esemics.get_craft_result({recipe=srclist, catalysts=catalystlist})
    print(deci.items)
    if itm.items ~= "" then
      if inv:is_empty("src") then
        meta:set_string("infotext", "prism is empty")
        print("prism is empty")
      end
      print(tostring(stack:get_count()).." catalyst")
      return stack:get_count()
    else
      print("that stack is bad, denying placement")
      return 0
    end
  elseif listname == "src" then
    print(tostring(stack:get_count()).." src")
    return stack:get_count()
  elseif listname == "dst" then
    return 0
  end
end

local function allow_metadata_inventory_move(pos, from_list, from_index, to_list, to_index, count, player)
  local meta = minetest.get_meta(pos)
  local inv = meta:get_inventory()
  local stack = inv:get_stack(from_list, from_index)
  --print("prism stack stack = "..stack)
  return allow_metadata_inventory_put(pos, to_list, to_index, stack, player)
end

local function allow_metadata_inventory_take(pos, listname, index, stack, player)
  if minetest.is_protected(pos, player:get_player_name()) then
    return 0
  end
  return stack:get_count()
end

local function swap_node(pos, name)
  local node = minetest.get_node(pos)
  if node.name == name then
    return
  end
  node.name = name
  minetest.swap_node(pos, node)
end

local function prism_node_timer(pos, elapsed)
  --
  -- Inizialize metadata
  --
  local meta = minetest.get_meta(pos)
  local time = meta:get_float("time") or 0
  --local src_time = meta:get_float("src_time") or 0
  local totaltime = meta:get_float("totaltime") or 120

  local inv = meta:get_inventory()
  local srclist, catalystlist

  local prismable, prismed
  local catalyst

  local update = true
  while update do
    update = false

    srclist = inv:get_list("src")
    catalystlist = inv:get_list("catalyst")

    --
    -- prismed
    --

    -- Check if we have prismable content
    local afterprismed
    for slot,stk in pairs(srclist) do
      print("srclist = "..stk:get_name().." × "..stk:get_count())
    end
    prismed, afterprismed = esemics.get_craft_result({items = srclist, catalysts=catalystlist})
    if prismed == nil or type(prismed) ~= "table" then
    	return
    end
    prismable = prismed.time ~= -1

    -- Check if we have enough catalyst to work
    if time < totaltime then
      -- The prism is currently active and has enough catalyst
      time = time + elapsed
      -- If there is a prismable item then check if it is ready yet
      if prismable then
        time = time + elapsed
        if time >= prismed.time then
          -- Place result in dst list if possible
          if inv:room_for_item("dst", prismed.item) then
            inv:add_item("dst", prismed.item)
            print("prism dst stack = "..inv:get_stack("dst",1))
            for slot,stk in pairs(afterprismed.catalysts) do
              inv:remove_item("catalyst",stk)
            end
            for slot,stk in pairs(afterprismed.items) do
              inv:remove_item("src",stk)
            end
            --inv:set_stack("src", 1, stk)
            print("prism src stack = "..inv:get_stack("src",1))
            time = time - prismed.time
            update = true
          end
        end
      end
    else
      -- prism ran out of catalyst
      --[[if prismable then
        -- We need to get new catalyst
        local aftercatalyst
        catalyst, aftercatalyst = esemics.get_craft_result({items = {catalystlist}})

        if catalyst.time == 0 then
          print("pop!")
        else
          -- Take catalyst from catalyst list
          inv:set_stack("catalyst", 1, aftercatalyst.items[1])
          print("prism catalyst stack = "..inv:get_stack("catalyst",1))
          update = true
          catalyst_totaltime = catalyst.time + (catalyst_time - catalyst_totaltime)
          src_time = src_time + elapsed
        end
      else
        -- We don't need to get new catalyst since there is no prismable item
        catalyst_totaltime = 0
        src_time = 0
      end
      catalyst_time = 0
    ]]end

    elapsed = 0
  end

  if catalyst and totaltime > time then
    totaltime = time
  end
  if srclist[1]:is_empty() and srclist[2]:is_empty() and srclist[3]:is_empty() and srclist[4]:is_empty() then
    time = 0
  end

  --
  -- Update formspec, infotext and node
  --
  local formspec = inactive_formspec
  local item_state
  local item_percent = 0
  if prismable then
    item_percent = math.floor(time / prismed.time * 100)
    if item_percent > 100 then
      item_state = "100% (output full)"
    else
      item_state = item_percent .. "%"
    end
  else
    if srclist[1]:is_empty() then
      item_state = "Empty"
    else
      item_state = "Not prismable"
    end
  end

  local catalyst_state = "Empty"
  local active = "inactive "
  local result = false

  if totaltime ~= 0 then
    active = "active "
    local catalyst_percent = math.floor(time / totaltime * 100)
    catalyst_state = catalyst_percent .. "%"
    formspec = active_formspec(catalyst_percent, item_percent)
    swap_node(pos, "esem:prism_active")
    -- make sure timer restarts automatically
    result = true
  else
    if not catalystlist[1]:is_empty() and catalystlist[2]:is_empty() and catalystlist[3]:is_empty() and catalystlist[4]:is_empty() then
      catalyst_state = "0%"
    end
    swap_node(pos, "esem:prism")
    -- stop timer on the inactive prism
    minetest.get_node_timer(pos):stop()
  end

  local infotext = "prism " .. active .. "(Item: " .. item_state .. "; catalyst: " .. catalyst_state .. ")"

  --
  -- Set meta values
  --
  meta:set_float("totaltime", totaltime)
  meta:set_float("time", time)
  --meta:set_float("src_time", src_time)
  meta:set_string("formspec", formspec)
  meta:set_string("infotext", infotext)

  return result
end

--
-- Node definitions
--

minetest.register_node("esem:prism", {
  description = "prism",
  tiles = {
      "esem_prism.png"
  },
  paramtype2 = "facedir",
  groups = {cracky=2},
  legacy_facedir_simple = true,
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),

  can_dig = can_dig,

  on_timer = prism_node_timer,

  on_construct = function(pos)
    local meta = minetest.get_meta(pos)
    meta:set_string("formspec", inactive_formspec)
    local inv = meta:get_inventory()
    inv:set_size('src', 4)
    inv:set_size('catalyst', 4)
    inv:set_size('dst', 1)
  end,

  on_metadata_inventory_move = function(pos)
    minetest.get_node_timer(pos):start(1.0)
  end,
  on_metadata_inventory_put = function(pos)
    -- start timer function, it will sort out whether prism can run or not.
    minetest.get_node_timer(pos):start(1.0)
  end,
  on_blast = function(pos)
    local drops = {}
    default.get_inventory_drops(pos, "src", drops)
    default.get_inventory_drops(pos, "catalyst", drops)
    default.get_inventory_drops(pos, "dst", drops)
    drops[#drops+1] = "esem:prism"
    minetest.remove_node(pos)
    return drops
  end,

  allow_metadata_inventory_put = allow_metadata_inventory_put,
  allow_metadata_inventory_move = allow_metadata_inventory_move,
  allow_metadata_inventory_take = allow_metadata_inventory_take,
})

minetest.register_node("esem:prism_active", {
  description = "prism",
  tiles = {
      "esem_prism.png"
  },
  paramtype2 = "facedir",
  light_source = 8,
  drop = "esem:prism",
  groups = {cracky=2, not_in_creative_inventory=1},
  legacy_facedir_simple = true,
  is_ground_content = false,
  sounds = default.node_sound_stone_defaults(),
  on_timer = prism_node_timer,

  can_dig = can_dig,

  allow_metadata_inventory_put = allow_metadata_inventory_put,
  allow_metadata_inventory_move = allow_metadata_inventory_move,
  allow_metadata_inventory_take = allow_metadata_inventory_take,
})

esemics.register_prism_recipe({
  result="esem:light_esem",
  recipe={
    "esem:red_esem",
    "esem:yellow_esem",
    "esem:green_esem",
    "esem:blue_esem",
  },
  catalysts={
    "esem:dark_esem",
  },
  time=30, -- seconds
  time_randomness=3 -- time ± math.random(0,time_randomness) -- optional
})