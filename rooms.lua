--rooms
room_objects, door_states, active_objects = {}, {}, {}
f = {
  -- door = { door = true, solid = true, interactable = true, locked = true },
  -- arch = { door_arches = true },
  -- light = { light = true },
  rock = { rock = true, solid = true },
  c_rock = { c_rock = true, solid = true },
  spike = { spike_tile = true },
  vase = { vase = true, solid = true },
  bat = { bat = true },
  rat = { rat = true },
  -- sign = { sign = true, solid = true, interactable = true },
  -- key = { key = true, interactable = true },
  flame_b = { flames_back = true },
  flame_f = { flames_fore = true },
  flame = { flames = true }
  -- w_button = { w_button = true, interactable = true }
}

obj = function(x, y, fl) return { x = x, y = y, flags = fl } end
light = function(x, y, r) return { x = x, y = y, r = r, flags = { light = true } } end
door = function(x, y, flx, fly) return { x = x, y = y, flx = flx, fly = fly, flp = flx, fx = flx, fy = fly, flags = { door = true, solid = true, interactable = true, locked = true } } end
arch = function(x, y, v, flx, fly) return { x = x, y = y, vori = v, flx = flx, fly = fly, flp = flx, fx = flx, fy = fly, flags = { door_arches = true } } end
sign = function(x, y, t) return { x = x, y = y, text = t, flags = { sign = true, interactable = true, solid = true } } end
key = function(x, y) return { x = x, y = y, flags = { key = true, interactable = true } } end
w_button = function(x, y) return { x = x, y = y, flags = { w_button = true, interactable = true } } end
chest = function(x, y) return { x = x, y = y, flags = { chest = true, interactable = true } } end
room = function(x, y, t) room_objects[x .. "_" .. y] = t end

--

rf = function(t)
  local f = { name = true, dungeon = false, sewer = false, pit = false, zoom = false, rain = false }
  for k, v in pairs(t) do
    f[k] = v
  end
  return f
end

room(
  0, 0, {
    { name = "CASTLE ENTRANCE", flags = rf { dungeon = true } },
    obj(64, 0, f.c_rock),
    arch(64, 0, true, false, false),
    sign(
      33,
      5,
      {
        "WELCOME TO THE DARK\nDUNGEONS OF THE SPOOKY\nCASTLE OF NAME. CONTAINED\nWITHIN THESE DANK WALLS ARE\nSECRETS, TRIALS...",
        "...AND TREASURES BEYOND\nYOUR WILDEST IMAGINATION.\n\nARMED ONLY WITH A SWORD AND\nYOUR ELVEN POWER OF...",
        "ILLUMINATION, YOU MUST\nBRAVE THE TERRORS IN THE\nDARK.\nMAY GOD HAVE MERCY\nON YOUR SOUL!"
      }
    ),
    obj(64, 64, f.rock),
    obj(80, 64, f.rock),
    obj(16, 16, f.flame_b),
    light(24, 20, 20),
    obj(96, 16, f.flame_b),
    light(104, 20, 20),
    arch(64, 120, true, true, true),
    door(64, 112, false, true),
    obj(16, 80, f.vase),
    obj(16, 96, f.vase),
    obj(32, 96, f.vase),
    obj(90, 90, f.bat),
    obj(100, 40, f.rat)
  }
)
room(
  0,
  1,
  {
    { name = "CASTLE GARDEN STORAGE", flags = rf { sewer = true, rain = true } },
    door(64, 0, false, false),
    arch(64, 0, true, false, false),
    light(56, 8, 15),
    light(87, 8, 15),
    obj(112, 96, f.vase),
    obj(112, 80, f.vase),
    obj(96, 96, f.vase),
    obj(96, 80, f.vase),
    obj(20, 90, f.bat),
    obj(100, 40, f.rat),
    obj(32, 48, f.vase)
  }
)
room(
  0,
  2,
  {
    { name = "MAIN BOSS CHAMBER", flags = rf { dungeon = true } },
    door(64, 112, false, true),
    arch(64, 120, true, true, true),
    obj(16, 16, f.flame_b),
    light(24, 20, 20),
    obj(96, 16, f.flame_b),
    light(104, 20, 20),
    obj(16, 96, f.flame_f),
    light(24, 100, 20),
    obj(96, 96, f.flame_f),
    light(104, 100, 20)
  }
)
room(
  0,
  3,
  {
    { name = "PASSAGE END", flags = rf { dungeon = true } },
    door(64, 0, false, false),
    arch(64, 0, true, false, false),
    light(56, 8, 15),
    light(87, 8, 15),
    obj(32, 16, f.flame_f),
    light(40, 20, 20),
    obj(80, 16, f.flame_f),
    light(88, 20, 20),
    sign(
      18,
      70,
      {
        "AHEAD LIES YOUR GREATEST\nCHALLENGE SO FAR...\n\n...THE DREADED BOSSNAME",
        "HE'S TOUGH AND FAST BUT HE\nDOESN'T SEE TOO WELL IN\nTHE DARK. THAT COULD MAKE\nALL THE DIFFERENCE."
      }
    )
  }
)
room(
  1,
  0,
  {
    { name = "ENTRANCE LOBBY INNER", flags = rf { dungeon = true } },
    door(112, 32, true, false),
    light(118, 22, 15),
    light(118, 52, 15),
    arch(120, 32, false, true, false),
    obj(32, 96, f.rock),
    obj(96, 96, f.rock),
    obj(100, 40, f.rat),
    obj(100, 90, f.rat)
  }
)
room(
  1,
  1,
  {
    { name = "CASTLE GARDEN STORAGE", flags = rf { sewer = true, rain = true } },
    door(112, 32, true, false),
    light(118, 22, 15),
    light(118, 52, 15),
    arch(120, 32, false, true, false),
    obj(16, 96, f.vase),
    obj(16, 80, f.vase),
    obj(32, 80, f.vase),
    obj(0, 80, f.vase),
    obj(0, 96, f.vase),
    obj(96, 16, f.vase),
    obj(96, 48, f.vase),
    obj(16, 16, f.vase),
    obj(32, 16, f.vase)
  }
)
room(
  1,
  2,
  {
    { name = "THE PIT MAZE", flags = rf { pit = true } },
    obj(16, 16, { stairs_down = true, solid = true }),
    obj(16, 64, f.spike),
    obj(32, 96, f.spike),
    obj(48, 64, f.spike),
    sign(48, 5, { "THREE BUTTONS MUST BE\nPRESSED TO REVEAL THE\nHIDDEN STAIRCASE.\n\nWHERE COULD THEY BE?" }),
    w_button(100, 73)
  }
)
room(
  2,
  0,
  {
    { name = "THE BOTTOMLESS PATHS - WEST", flags = rf { dungeon = true } },
    door(0, 32, true, true),
    arch(0, 32, false, false, false),
    arch(48, 120, true, true, true),
    light(8, 22, 15),
    light(8, 52, 15),
    key(18, 100),
    obj(80, 80, f.bat),
    obj(60, 20, f.bat)
  }
)
room(
  2,
  1,
  {
    { name = "WATCH THE DROP", flags = rf { dungeon = true } },
    door(0, 32, true, true),
    light(8, 22, 15),
    light(8, 52, 15),
    arch(0, 32, false, false, false),
    arch(48, 0, true, false, false)
  }
)
room(
  2,
  2,
  {
    { name = "THE PIT MAZE", flags = rf { pit = true } },
    w_button(20, 41)
  }
)
room(
  3,
  0,
  {
    { name = "THE BOTTOMLESS PATHS - EAST", flags = rf { dungeon = true } },
    obj(80, 80, f.bat),
    obj(60, 20, f.bat),
    obj(10, 90, f.bat)
  }
)
room(
  3,
  1,
  {
    { name = "THE BOTTOMLESS PATHS - SOUTH", flags = rf { dungeon = true } },
    chest(70, 40)
  }
)
room(
  3, 2, {
    { name = "THE PIT MAZE", flags = rf { pit = true } }
  }
)
room(
  4,
  0,
  {
    { name = "RESTING POINT", flags = rf { dungeon = true } },
    door(64, 112, false, true),
    arch(64, 120, true, true, true),
    light(56, 120, 15),
    light(87, 120, 15),
    obj(80, 32, f.flame),
    light(88, 36, 30),
    obj(80, 32, f.flame_b),
    obj(80, 8, f.vase),
    obj(16, 96, f.vase),
    obj(32, 96, f.vase),
    obj(16, 80, f.vase)
  }
)
room(
  4,
  1,
  {
    { name = "MYSTERY KEY ROOM", flags = rf { dungeon = true } },
    door(64, 0, false, false),
    arch(64, 0, true, false, false),
    light(56, 8, 15),
    light(79, 8, 15),
    sign(34, 6, { "THE KEY ON THE TABLE\nUNLOCKS A DOOR ON THIS\nFLOOR...\n\nBUT WHICH ONE?" }),
    key(56, 64)
  }
)
room(
  4,
  2,
  {
    { name = "THE PIT MAZE", flags = rf { pit = true } },
    w_button(84, 9)
  }
)
room(
  4,
  3,
  {
    { name = "HALL OF SPIKES", flags = rf { dungeon = true } },
    obj(15, 95, f.spike),
    obj(47, 79, f.spike),
    obj(63, 79, f.spike),
    obj(95, 95, f.spike)
  }
)
room(
  5, 0, {
    { name = "OUTER WALLS VIEW", flags = rf { dungeon = true } },
    obj(32, 16, f.rock),
    obj(48, 32, f.c_rock),
    obj(64, 48, f.rock)
  }
)
room(
  5, 1, {
    { name = "THE SLIDING FLOORS", flags = rf { dungeon = true } }
  }
)
room(
  5, 2, {
    { name = "NEED NAME HERE", flags = rf { dungeon = true } }
  }
)
room(
  5, 3, {
    { name = "NEED NAME HERE", flags = rf { dungeon = true } }
  }
)
room(
  6,
  0,
  {
    { name = "OUTER COURTYARD", flags = rf { sewer = true, rain = true } },
    sign(
      105,
      53,
      {
        "THE NEXT ROOM HAS SPIKES\nTHAT SHOOT FROM BOTTOM TO\nTOP. YOU HAVE TO PRESS THE\nBUTTON AT THE TOP TO STOP\nTHE SPIKES AND CLOSE...",
        "THE PITS DOORS."
      }
    ),
    door(80, 112, false, true, true),
    arch(80, 120, true, true, false),
    light(72, 120, 15),
    light(103, 120, 15)
  }
)
room(
  6, 1, {
    { name = "CRUMBLING GROTTO", flags = rf { dungeon = true } },
    door(80, 0, false, false, true),
    arch(80, 0, true, false, false),
    light(72, 8, 15),
    light(103, 8, 15),
    obj(80, 80, f.flame),
    light(88, 84, 30),
    obj(80, 80, f.flame_b),
    obj(40, 80, f.bat),
    obj(90, 50, f.bat)
  }
)
room(
  7,
  0,
  {
    { name = "SPIKES OF DOOM", flags = rf { sewer = true, rain = true } },
    w_button(20, 9),
    w_button(68, 9),
    w_button(116, 9)
  }
)
room(
  7,
  1,
  {
    { name = "MORE CRUMBLING GROTTO", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)
room(
  8,
  0,
  {
    { name = "MORE CRUMBLING GROTTO", flags = rf { sewer = true, rain = true } },
    door(112, 64, true, false),
    light(118, 54, 15),
    light(118, 84, 15),
    arch(120, 64, false, true, false),
    chest(96, 16)
  }
)
room(
  8,
  1,
  {
    { name = "REALLY CRUMBLING GROTTO", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)
room(
  8, 2, {
    { name = "DEFAULT ROOM NAME", flags = rf { dungeon = true } }
  }
)

room(
  9, 0, {
    { name = "CRUMBLED GROTTO", flags = rf { pit = true, zoom = true } },
    door(0, 64, true, true),
    light(8, 54, 15),
    light(8, 84, 15),
    arch(0, 64, false, false, false)
  }
)

room(
  9, 1, {
    { name = "CRUMBLED GROTTO", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)
room(
  10, 1, {
    { name = "CRUMBLED GROTTO", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)

--

function unlock_door(o)
  local ax, ay = mapx + o.x, mapy + o.y
  door_states[ax .. "_" .. ay] = true
  o.locked = false
  o.flags.solid = false
  local dl, dr, dt, db = o.x, 128 - o.x, o.y, 128 - o.y
  if dl <= dr and dl <= dt and dl <= db then
    ax = ax - 16
  elseif dr <= dl and dr <= dt and dr <= db then
    ax = ax + 16
  elseif dt <= dl and dt <= dr and dt <= db then
    ay = ay - 16
  else
    ay = ay + 16
  end
  door_states[ax .. "_" .. ay] = true
  sfx(8, 3)
end

function door_lights(x, y, fx, fy, flp)
  local a = flp and { 240, 241, 241, 240 } or { 224, 225, 225, 224 }
  local i = flr(time() * (4 * t_increment) % 4) + 1
  local flip = i > 2
  if flp then
    spr(a[i], x + 4, y - 12, 1, 1, fx, flip) spr(a[i], x + 4, y + 20, 1, 1, fx, flip)
  else
    spr(a[i], x - 12, y + 4, 1, 1, flip, fy) spr(a[i], x + 20, y + 4, 1, 1, flip, fy)
  end
end

function normalize_obj_list(t)
  for o in all(t) do
    if o.flx ~= nil or o.fly ~= nil then
      o.flp = o.flx or false o.fx = o.flx or false o.fy = o.fly or false
    end
  end
end

function draw_player_interact_icon()
  local engaged_now = false
  for o in all(active_objects) do
    local f = o.flags
    if f.interactable then
      local ox, oy = mapx + flr(o.x), mapy + flr(o.y)
      local len = abs(ox - flr(p.x)) + abs(oy - flr(p.y) + 6)
      if len > 0 and len < 22 then
        engaged_now = true
        if f.sign and not reading and val == 0 and btn(BTN_O) then
          t_increment = 0.05 tb_init(15, o.text)
        end
        if f.sign then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if f.key or f.chest then sspr(29, 80, 3, 7, p.x + 8, p.y - 8) end
        if f.door and f.solid then
          if p.keys > 0 then sspr(113, 96, 5, 8, p.x + 8, p.y - 8) end
          if btnp(BTN_O) then
            if o.locked and p.keys > 0 then
              p.keys -= 1 unlock_door(o)
            elseif o.locked then
              sfx(9, 3)
            end
          end
        end
      end
    end
  end
  p.engaged = engaged_now
  if not engaged_now then
    reading = false
    val = 0
  end
end

--

function draw_background_sprites()
  for obj in all(active_objects) do
    local f = obj.flags
    if f.zoom ~= nil then zoom_view = f.zoom end
    if f.rain ~= nil then raindrops = f.rain end
    if f.quake ~= nil then quake = f.quake end
    if f.sewer then
      palette(sewer)
    elseif f.dungeon then
      palette(dungeon)
    elseif f.pit then
      palette(pit)
    end
    if f.vase then spr(172, mapx + obj.x, mapy + obj.y, 2, 2) end
    if f.sign then spr(170, mapx + obj.x, mapy + obj.y, 2, 2) end
    if f.key then spr(254, mapx + obj.x, mapy + obj.y, 2, 1) end
    if f.door then
      if obj.flp then
        if obj.locked then spr(168, mapx + obj.x, mapy + obj.y, 2, 2, obj.fy, obj.fx) end
      else
        if obj.locked then spr(128, mapx + obj.x, mapy + obj.y, 2, 2, obj.fx, obj.fy) end
      end
      door_lights(mapx + obj.x, mapy + obj.y, obj.fx, obj.fy, obj.flp)
    end
    if f.chest then spr(13, mapx + obj.x, mapy + obj.y, 2, 2, obj.fx, obj.fy) end
    if f.rock then spr(134, mapx + obj.x, mapy + obj.y, 2, 2) end
    if f.stairs_down then spr(130, mapx + obj.x, mapy + obj.y, 2, 2) end
    if f.stairs_up then spr(132, mapx + obj.x, mapy + obj.y, 2, 2) end
    if f.c_rock then spr(136, mapx + obj.x, mapy + obj.y, 2, 2) end
    if f.spike_tile then animate_spikes(obj) end
    if f.w_button then spr(95, mapx + obj.x, mapy + obj.y, 1, 1) end
    if f.flames_back then flames(mapx + obj.x, mapy + obj.y) end
  end
end

function animate_spikes(o)
  local t = flr((time() * t_increment * 3) % 4) + 1
  local f = ({ 78, 79, 94, 79 })[t]
  local x, y = mapx + o.x, mapy + o.y
  for i = 0, 1 do
    for j = 0, 1 do
      spr(f, x + i * 8, y + j * 8)
    end
  end
end

function draw_foreground_sprites()
  for obj in all(active_objects) do
    local f = obj.flags
    if f.bat and not obj.spawned then
      add(baddie_m.baddies, new_bat(mapx + obj.x, mapy + obj.y)) obj.spawned = true
    end
    if f.rat and not obj.spawned then
      add(baddie_m.baddies, new_rat(mapx + obj.x, mapy + obj.y)) obj.spawned = true
    end
    if f.blob and not obj.spawned then
      add(baddie_m.baddies, new_blob(mapx + obj.x, mapy + obj.y)) obj.spawned = true
    end
    if f.door_arches then
      if obj.vori then
        if obj.flp == false then rectfill(mapx + obj.x - 4, mapy + obj.y + 2, mapx + obj.x + 19, mapy + obj.y - 6, 0) end
        if obj.flp == true then rectfill(mapx + obj.x - 4, mapy + obj.y + 5, mapx + obj.x + 19, mapy + obj.y + 13, 0) end
        spr(49, mapx + obj.x + 8, mapy + obj.y, 1, 1, false, obj.flp) spr(49, mapx + obj.x, mapy + obj.y, 1, 1, true, obj.flp)
      else
        spr(51, mapx + obj.x, mapy + obj.y, 1, 1, obj.flp, true) spr(51, mapx + obj.x, mapy + obj.y + 8, 1, 1, obj.flp, false)
      end
    end
    if f.flames_fore then flames(mapx + obj.x, mapy + obj.y) end
  end
end

function flames(x, y)
  local a = { 166, 167, 167, 166 }
  local i = flr(time() * 6 * t_increment % #a) + 1
  return spr(a[i], x + 4, y - 8, 1, 2, i > 2, false)
end

function get_current_room() return flr(p.x / 128) .. "_" .. flr(p.y / 128) end

function load_room_objects(room_id)
  active_objects = room_objects[room_id] or {}
  normalize_obj_list(active_objects)
  for o in all(active_objects) do
    if o.flags and o.flags.door then
      o.id = (mapx + o.x) .. "_" .. (mapy + o.y)
      if door_states[o.id] then
        o.locked = false o.flags.solid = false
      else
        o.locked = (o.locked == nil) and true or o.locked
      end
    end
  end
end

-- local current_room = ""
-- function check_room_change()
--   local new_room = get_current_room()
--   if new_room ~= current_room then
--     current_room = new_room active_objects = {} load_room_objects(current_room)
--   end
-- end

local current_room = ""
function check_room_change()
  local new_room = get_current_room()
  if new_room ~= current_room then
    current_room = new_room

    active_objects = {}
    load_room_objects(current_room)

    -- set palette based on room flags
    local flags = room_objects[current_room][1].flags

    palette(flags.dungeon and dungeon or flags.sewer and sewer or pit)
    current_palette = flags.dungeon and "dungeon" or flags.sewer and "sewer" or "pit"

    dset(0, flr(p.x))
    dset(1, flr(p.y))
    dset(2, flr(p.remaining_hearts))
    dset(3, flr(p.keys))
  end
end

function draw_torch_light()
  for obj in all(active_objects) do
    if obj.flags.light then
      local px, py = mapx + obj.x, mapy + obj.y
      fillp(░) circfill(px, py, obj.r + rnd(3) + 10, 14)
      fillp(▒) circfill(px, py, obj.r + rnd(3) + 6, 14)
      fillp(0x0000) circfill(px, py, obj.r + rnd(3) + 3, 14)
    end
  end
end

function draw_flames()
  for obj in all(active_objects) do
    if obj.flags.flames then flames(mapx + obj.x, mapy + obj.y) end
  end
end