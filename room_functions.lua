--room_functions
function unlock_door(o)
  local ax, ay = mapx + o.x, mapy + o.y
  door_states[ax .. "_" .. ay] = true
  o.locked, o.flags.solid, o.flags.interactable = false, false, false
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

--

function door_lights(x, y, flx, fly, flp)
  local a, i = flp and split("240, 241, 241, 240") or split("224, 225, 225, 224"), flr(time() * (4 * t_increment) % 4) + 1
  local flip = i > 2
  if flp then
    spr(a[i], x + 4, y - 12, 1, 1, flx, flip)
    spr(a[i], x + 4, y + 20, 1, 1, flx, flip)
  else
    spr(a[i], x - 12, y + 4, 1, 1, flip, fly)
    spr(a[i], x + 20, y + 4, 1, 1, flip, fly)
  end
end

--

function normalize_obj_list(t)
  for o in all(t) do
    if o.flx ~= nil or o.fly ~= nil then
      o.flp = o.flx or false o.fx = o.flx or false o.fy = o.fly or false
    end
  end
end

--

function load_room_objects(room_id)
  active_objects = room_objects[room_id]
  normalize_obj_list(active_objects)
  for o in all(active_objects) do
    if o.flags.door then
      o.id = (mapx * 128 + o.x) .. "_" .. (mapy * 128 + o.y)
      if door_states[o.id] then
        o.locked, o.flags.solid, o.flags.interactable = false, false, false
      else
        o.locked = true
      end
    end
  end
end

--

function draw_player_interact_icon()
  local engaged_now = false
  for o in all(active_objects) do
    local flag = o.flags
    if flag.interactable then
      local ox, oy = mapx + o.x, mapy + o.y
      local len = abs(ox - p.x) + abs(oy - p.y + 4)
      if len > 0 and len < 22 then
        engaged_now = true
        if flag.sign and not reading and val == 0 and btn(BTN_O) then
          t_increment = 0.05
          tb_init(sign_dialog(o.text))
        end
        if flag.sign then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.HEALTH_POTION then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.DUNGEON_MAP then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.GOLDEN_KEY then
          sspr(29, 80, 3, 7, p.x + 8, p.y - 8)
          if btnp(BTN_O) then
            p.keys = (p.keys or 0) + 1
            del(active_objects, o)
            sfx(18, 3)
          end
        end
        if flag.chest then
          if o.active and o.locked then
            sspr(29, 80, 3, 7, p.x + 8, p.y - 8)
            if btnp(BTN_O) and o.locked then
              sfx(51, 3)
              boom(ox, oy, 9, 8, 7, 12, rnd({ 1, 2, 3 }))
              del(active_objects, o)
              local v = split(o.vori, "_")
              chest_alert("YOU FOUND A " .. v[1] .. " " .. (v[2] or ""))
              add(
                active_objects, obj("" .. o.vori .. "," .. o.x .. "," .. o.y + 4 .. ", nil, nil, nil, nil, nil, true, false, nil, nil, nil, nil, nil, nil")
              )
              if btnp(BTN_O) then return end
            end
          end
        end
        if flag.door and flag.solid then
          if p.keys > 0 then sspr(115, 96, 5, 8, p.x + 8, p.y - 8) end
          if btnp(BTN_O) then
            if o.locked and p.keys > 0 then
              p.keys = p.keys - 1 unlock_door(o)
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
  for a_obj in all(active_objects) do
    local flag, ax, ay, afx, afy = a_obj.flags, mapx + (a_obj.x or 0), mapy + (a_obj.y or 0), a_obj.flx, a_obj.fly
    if flag.rain ~= nil then raindrops = flag.rain end
    if flag.sewer then
      palette(sewer)
    elseif flag.dungeon then
      palette(dungeon)
    elseif flag.pit then
      palette(pit)
    end
    if flag.vase then spr(172, ax, ay, 2, 2) end
    if flag.sign then spr(170, ax, ay, 2, 2) end
    if flag.GOLDEN_KEY then spr(254, ax, ay, 2, 1) end
    if flag.DUNGEON_MAP then spr(61, ax + 4, ay, 1, 1) end
    if flag.HEALTH_POTION then spr(45, ax + 4, ay, 1, 1) end
    if flag.door then
      if a_obj.flp then
        if a_obj.locked then spr(168, ax, ay, 2, 2, afy, afx) end
      else
        if a_obj.locked then spr(128, ax, ay, 2, 2, afx, afy) end
      end
      door_lights(ax, ay, afx, afy, a_obj.flp)
    end
    if flag.coin then
      -- sspr(112, 104, 8, 6, ax, ay)
      sspr(112, 96, 2, 2, ax, ay)
    end
    if flag.chest then
      if a_obj.active then
        a_obj.flags.interactable = true
        if a_obj.locked then
          spr(13, ax, ay, 2, 2)
        end
      end
    end
    if flag.rock then spr(134, ax, ay, 2, 2) end
    if flag.stairs_down then
      spr(130, ax, ay, 2, 2)
      if stairs_trigger(a_obj) then
        use_transition(a_obj)
      end
    end
    if flag.stairs_up then
      if a_obj.active then
        spr(132, ax, ay, 2, 2, a_obj.flp, false)
        if stairs_trigger(a_obj) then
          use_transition(a_obj)
        end
      end
    end
    if flag.c_rock then spr(136, ax, ay, 2, 2) end
    if flag.spike then animate_spikes(a_obj) end
    if flag.button then
      if a_obj.pressed then
        spr(111, ax, ay, 1, 1)
      else
        spr(95, ax, ay, 1, 1)
      end
    end
    if flag.flames_back then flames(ax, ay) end
    if flag.s_shoot_v or flag.s_shoot_h then
      local v = flag.s_shoot_v
      sspr(112, v and 56 or 48, v and 8 or 5, v and 5 or 8, ax, ay, v and 8 or 5, v and 5 or 8, v and false or a_obj.flp, v and a_obj.flp or false)
      if not a_obj.added then
        add(get_room_shooters(cur_room_x, cur_room_y), a_obj) a_obj.added = true
      end
    end
    if flag.floor_tile then
      if not a_obj.active then
        spr(43, ax - 16, ay, 2, 2)
        spr(43, ax, ay, 2, 2)
      end
    end
  end
end

--

function animate_spikes(o)
  local t = flr((time() * t_increment * 3) % 4) + 1
  local frames = ({ 78, 79, 94, 79 })[t]
  local x, y = mapx + o.x, mapy + o.y
  for i = 0, 1 do
    for j = 0, 1 do
      spr(frames, x + i * 8, y + j * 8)
    end
  end
end

--

function draw_foreground_sprites()
  for a_obj in all(active_objects) do
    local flag, ax, ay = a_obj.flags, mapx + (a_obj.x or 0), mapy + (a_obj.y or 0)

    if flag.bat and not a_obj.spawned then
      add(baddie_m.baddies, bat(ax, ay)) a_obj.spawned = true
    end

    if flag.rat and not a_obj.spawned then
      add(baddie_m.baddies, rat(ax, ay)) a_obj.spawned = true
    end

    if flag.blob and not a_obj.spawned then
      add(baddie_m.baddies, blob(ax, ay)) a_obj.spawned = true
    end

    if flag.arch then
      if a_obj.vori then
        if a_obj.flp == false then rectfill(ax - 4, ay + 2, ax + 19, ay - 6, 0) end
        if a_obj.flp == true then rectfill(ax - 4, ay + 5, ax + 19, ay + 13, 0) end
        spr(49, ax + 8, ay, 1, 1, false, a_obj.flp)
        spr(49, ax, ay, 1, 1, true, a_obj.flp)
      else
        spr(51, ax, ay, 1, 1, a_obj.flp, true)
        spr(51, ax, ay + 8, 1, 1, a_obj.flp, false)
      end
    end

    if flag.flames_fore then
      flames(ax, ay)
    end
  end
end

--

function flames(x, y)
  local a = { 166, 167, 167, 166 }
  local i = flr(time() * 6 * t_increment % #a) + 1
  return spr(a[i], x + 4, y - 8, 1, 2, i > 2, false)
end

--

function get_current_room() return flr(p.x / 128) .. "_" .. flr(p.y / 128) end

--

current_room = ""
function check_room_change()
  local new_room = get_current_room()
  if new_room ~= current_room then
    current_room = new_room

    active_objects = {} -- clears the room objects IMPORTANT
    load_room_objects(current_room)

    -- set palette based on room flags
    local flags = {}
    if room_objects[current_room] and room_objects[current_room][1] and room_objects[current_room][1].flags then
      flags = room_objects[current_room][1].flags
    end

    palette(flags.dungeon and dungeon or flags.sewer and sewer or pit)
    current_palette = flags.dungeon and "dungeon" or flags.sewer and "sewer" or "pit"

    dset(0, flr(p.x))
    dset(1, flr(p.y))

    for o in all(active_objects) do
      if o.flags.button then
        add(buttons, o)
      end
    end
  end
end

--

function draw_torch_light()
  for a_obj in all(active_objects) do
    if a_obj.flags.light then
      local px, py, pr = mapx + a_obj.x, mapy + a_obj.y, a_obj.rad
      fillp(32125.5) circfill(px, py, pr + rnd(3) + 10, 14)
      fillp(23130.5) circfill(px, py, pr + rnd(3) + 6, 14)
      fillp(0x0000) circfill(px, py, pr + rnd(3) + 3, 14)
    end
  end
end