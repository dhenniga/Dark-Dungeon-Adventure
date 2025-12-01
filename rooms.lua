--rooms
room_objects, door_states, active_objects = {}, {}, {}
f = {
  rock = { rock = true, solid = true },
  c_rock = { c_rock = true, solid = true },
  spike = { spike_tile = true },
  vase = { vase = true, solid = true },
  bat = { bat = true },
  rat = { rat = true },
  blob = { blob = true },
  flame_b = { flames_back = true },
  flame_f = { flames_fore = true },
  flame = { flames = true }
}

obj = function(x, y, fl) return { x = x, y = y, flags = fl } end
light = function(x, y, rad) return { x = x, y = y, r = rad, flags = { light = true } } end
door = function(x, y, flx, fly) return { x = x, y = y, flx = flx, fly = fly, flp = flx, fx = flx, fy = fly, flags = { door = true, solid = true, interactable = true, locked = true } } end
arch = function(x, y, v, flx, fly) return { x = x, y = y, vori = v, flx = flx, fly = fly, flp = flx, fx = flx, fy = fly, flags = { door_arches = true } } end
sign = function(x, y, t) return { x = x, y = y, text = t, flags = { sign = true, interactable = true, solid = true } } end
key = function(x, y) return { x = x, y = y, flags = { key = true, interactable = true } } end
w_button = function(x, y) return { x = x, y = y, flags = { w_button = true, interactable = true } } end
chest = function(x, y) return { x = x, y = y, flags = { chest = true, interactable = true, solid = true } } end
s_shoot_v = function(x, y, active, delay, timing, speed, flp) return { x = x, y = y, active = active, delay = delay, timing = timing, speed = speed, flp = flp, flags = { s_shoot_v = true } } end
s_shoot_h = function(x, y, active, delay, timing, speed, flp) return { x = x, y = y, active = active, delay = delay, timing = timing, speed = speed, flp = flp, flags = { s_shoot_h = true } } end

room = function(x, y, t) room_objects[x .. "_" .. y] = t end

--

rf = function(t)
  local w = { name = true, dungeon = false, sewer = false, pit = false, rain = false }
  for k, v in pairs(t) do
    w[k] = v
  end
  return w
end

room(
  0, 0, {
    { name = "𝘤𝘢𝘴𝘵𝘭𝘦 𝘦𝘯𝘵𝘳𝘢𝘯𝘤𝘦", flags = rf { dungeon = true } },
    obj(64, 0, f.c_rock),
    arch(64, 0, true, false, false),
    sign(
      33,
      5,
      {
        "𝘸𝘦𝘭𝘤𝘰𝘮𝘦 𝘵𝘰 𝘵𝘩𝘦 𝘥𝘢𝘳𝘬 𝘥𝘶𝘯𝘨𝘦𝘰𝘯𝘴\n𝘰𝘧 𝘵𝘩𝘦 𝘴𝘱𝘰𝘰𝘬𝘺 𝘤𝘢𝘴𝘵𝘭𝘦 𝘰𝘧\n𝘯𝘢𝘮𝘦. 𝘤𝘰𝘯𝘵𝘢𝘪𝘯𝘦𝘥 𝘸𝘪𝘵𝘩𝘪𝘯 𝘵𝘩𝘦𝘴𝘦\n𝘥𝘢𝘯𝘬 𝘸𝘢𝘭𝘭𝘴 𝘢𝘳𝘦 𝘴𝘦𝘤𝘳𝘦𝘵𝘴,\n𝘵𝘳𝘪𝘢𝘭𝘴, 𝘮𝘰𝘯𝘴𝘵𝘦𝘳𝘴 𝘢𝘯𝘥...",
        "...𝘵𝘳𝘦𝘢𝘴𝘶𝘳𝘦𝘴 𝘣𝘦𝘺𝘰𝘯𝘥\n𝘺𝘰𝘶𝘳 𝘸𝘪𝘭𝘥𝘦𝘴𝘵 𝘪𝘮𝘢𝘨𝘪𝘯𝘢𝘵𝘪𝘰𝘯.\n\n𝘢𝘳𝘮𝘦𝘥 𝘰𝘯𝘭𝘺 𝘸𝘪𝘵𝘩 𝘢 𝘴𝘸𝘰𝘳𝘥 𝘢𝘯𝘥\n𝘺𝘰𝘶𝘳 𝘦𝘭𝘷𝘦𝘯 𝘱𝘰𝘸𝘦𝘳 𝘰𝘧...",
        "𝘪𝘭𝘭𝘶𝘮𝘪𝘯𝘢𝘵𝘪𝘰𝘯, 𝘺𝘰𝘶 𝘮𝘶𝘴𝘵\n𝘣𝘳𝘢𝘷𝘦 𝘵𝘩𝘦 𝘵𝘦𝘳𝘳𝘰𝘳𝘴 𝘪𝘯 𝘵𝘩𝘦\n𝘥𝘢𝘳𝘬.\n𝘮𝘢𝘺 𝘨𝘰𝘥 𝘩𝘢𝘷𝘦 𝘮𝘦𝘳𝘤𝘺\n𝘰𝘯 𝘺𝘰𝘶𝘳 𝘴𝘰𝘶𝘭!"
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
    light(56, 120, 12),
    light(87, 120, 12),
    obj(16, 80, f.vase),
    obj(16, 96, f.vase),
    obj(32, 96, f.vase)
    -- s_shoot_v(36, 114, true, 1, 60, 2, false),
    -- s_shoot_h(8, 36, true, 1, 70, 2, false),

    -- s_shoot_v(48, 6, true, 1, 80, 2, true), -- 𝘥𝘰𝘸𝘯
    -- s_shoot_h(112, 48, true, 1, 90, 2, true) -- 𝘳𝘪𝘨𝘩𝘵 𝘵𝘰 𝘭𝘦𝘧𝘵
  }
)
room(
  0,
  1,
  {
    { name = "𝘤𝘢𝘴𝘵𝘭𝘦 𝘨𝘢𝘳𝘥𝘦𝘯 𝘴𝘵𝘰𝘳𝘢𝘨𝘦", flags = rf { sewer = true, rain = true } },
    door(64, 0, false, false),
    arch(64, 0, true, false, false),
    light(56, 8, 12),
    light(87, 8, 12),
    obj(112, 96, f.vase),
    obj(112, 80, f.vase),
    obj(96, 96, f.vase),
    obj(96, 80, f.vase),
    obj(20, 90, f.bat),
    obj(100, 32, f.rat),
    obj(32, 48, f.vase),
    s_shoot_v(36, 114, true, 1, 60, 3, false),
    s_shoot_h(8, 36, true, 1, 60, 3, false)
  }
)
room(
  0,
  2,
  {
    { name = "𝘮𝘢𝘪𝘯 𝘣𝘰𝘴𝘴 𝘤𝘩𝘢𝘮𝘣𝘦𝘳", flags = rf { dungeon = true } },
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
    { name = "𝘱𝘢𝘴𝘴𝘢𝘨𝘦 𝘦𝘯𝘥", flags = rf { dungeon = true } },
    door(64, 0, false, false),
    arch(64, 0, true, false, false),
    light(56, 8, 12),
    light(87, 8, 12),
    obj(32, 16, f.flame_f),
    light(40, 20, 20),
    obj(80, 16, f.flame_f),
    light(88, 20, 20),
    sign(
      18,
      70,
      {
        "𝘢𝘩𝘦𝘢𝘥 𝘭𝘪𝘦𝘴 𝘺𝘰𝘶𝘳 𝘨𝘳𝘦𝘢𝘵𝘦𝘴𝘵\n𝘤𝘩𝘢𝘭𝘭𝘦𝘯𝘨𝘦 𝘴𝘰 𝘧𝘢𝘳...\n\n...𝘵𝘩𝘦 𝘥𝘳𝘦𝘢𝘥𝘦𝘥 𝘣𝘰𝘴𝘴𝘯𝘢𝘮𝘦",
        "𝘩𝘦'𝘴 𝘵𝘰𝘶𝘨𝘩 𝘢𝘯𝘥 𝘧𝘢𝘴𝘵 𝘣𝘶𝘵 𝘩𝘦\n𝘥𝘰𝘦𝘴𝘯'𝘵 𝘴𝘦𝘦 𝘵𝘰𝘰 𝘸𝘦𝘭𝘭 𝘪𝘯\n𝘵𝘩𝘦 𝘥𝘢𝘳𝘬. 𝘵𝘩𝘢𝘵 𝘤𝘰𝘶𝘭𝘥 𝘮𝘢𝘬𝘦\n𝘢𝘭𝘭 𝘵𝘩𝘦 𝘥𝘪𝘧𝘧𝘦𝘳𝘦𝘯𝘤𝘦."
      }
    )
  }
)
room(
  1,
  0,
  {
    { name = "𝘦𝘯𝘵𝘳𝘢𝘯𝘤𝘦 𝘭𝘰𝘣𝘣𝘺 𝘪𝘯𝘯𝘦𝘳", flags = rf { dungeon = true } },
    door(112, 32, true, false),
    light(118, 22, 12),
    light(118, 52, 12),
    arch(120, 32, false, true, false),
    obj(32, 96, f.rock),
    obj(96, 96, f.rock),
    obj(96, 40, f.rat),
    obj(96, 80, f.rat)
  }
)
room(
  1,
  1,
  {
    { name = "𝘤𝘢𝘴𝘵𝘭𝘦 𝘨𝘢𝘳𝘥𝘦𝘯 𝘴𝘵𝘰𝘳𝘢𝘨𝘦", flags = rf { sewer = true, rain = true } },
    door(112, 32, true, false),
    light(118, 22, 12),
    light(118, 52, 12),
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
    { name = "𝘵𝘩𝘦 𝘱𝘪𝘵 𝘮𝘢𝘻𝘦", flags = rf { pit = true } },
    obj(16, 16, { stairs_down = true, solid = true }),
    obj(16, 64, f.spike),
    obj(32, 96, f.spike),
    obj(48, 64, f.spike),
    sign(48, 5, { "𝘵𝘩𝘳𝘦𝘦 𝘣𝘶𝘵𝘵𝘰𝘯𝘴 𝘮𝘶𝘴𝘵 𝘣𝘦\n𝘱𝘳𝘦𝘴𝘴𝘦𝘥 𝘵𝘰 𝘳𝘦𝘷𝘦𝘢𝘭 𝘵𝘩𝘦\n𝘩𝘪𝘥𝘥𝘦𝘯 𝘴𝘵𝘢𝘪𝘳𝘤𝘢𝘴𝘦.\n\n𝘸𝘩𝘦𝘳𝘦 𝘤𝘰𝘶𝘭𝘥 𝘵𝘩𝘦𝘺 𝘣𝘦?" }),
    w_button(100, 73)
  }
)
room(
  2,
  0,
  {
    { name = "𝘵𝘩𝘦 𝘣𝘰𝘵𝘵𝘰𝘮𝘭𝘦𝘴𝘴 𝘱𝘢𝘵𝘩𝘴 - 𝘸𝘦𝘴𝘵", flags = rf { dungeon = true } },
    door(0, 32, true, true),
    arch(0, 32, false, false, false),
    arch(48, 120, true, true, true),
    light(8, 22, 12),
    light(8, 52, 12),
    key(18, 100),
    obj(80, 80, f.bat),
    obj(60, 20, f.bat)
  }
)
room(
  2,
  1,
  {
    { name = "𝘸𝘢𝘵𝘤𝘩 𝘵𝘩𝘦 𝘥𝘳𝘰𝘱", flags = rf { dungeon = true } },
    door(0, 32, true, true),
    light(8, 22, 12),
    light(8, 52, 12),
    arch(0, 32, false, false, false),
    arch(48, 0, true, false, false)
  }
)
room(
  2,
  2,
  {
    { name = "𝘵𝘩𝘦 𝘱𝘪𝘵 𝘮𝘢𝘻𝘦", flags = rf { pit = true } },
    w_button(20, 41)
  }
)
room(
  3,
  0,
  {
    { name = "𝘵𝘩𝘦 𝘣𝘰𝘵𝘵𝘰𝘮𝘭𝘦𝘴𝘴 𝘱𝘢𝘵𝘩𝘴 - 𝘦𝘢𝘴𝘵", flags = rf { dungeon = true } },
    obj(80, 80, f.bat),
    obj(60, 20, f.bat),
    obj(10, 90, f.bat)
  }
)
room(
  3,
  1,
  {
    { name = "𝘵𝘩𝘦 𝘣𝘰𝘵𝘵𝘰𝘮𝘭𝘦𝘴𝘴 𝘱𝘢𝘵𝘩𝘴 - 𝘴𝘰𝘶𝘵𝘩", flags = rf { dungeon = true } },
    chest(70, 40)
  }
)
room(
  3, 2, {
    { name = "𝘵𝘩𝘦 𝘱𝘪𝘵 𝘮𝘢𝘻𝘦", flags = rf { pit = true } }
  }
)
room(
  4,
  0,
  {
    { name = "𝘳𝘦𝘴𝘵𝘪𝘯𝘨 𝘱𝘰𝘪𝘯𝘵", flags = rf { dungeon = true } },
    door(64, 112, false, true),
    arch(64, 120, true, true, true),
    light(56, 120, 12),
    light(87, 120, 12),
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
    { name = "𝘮𝘺𝘴𝘵𝘦𝘳𝘺 𝘬𝘦𝘺 𝘳𝘰𝘰𝘮", flags = rf { dungeon = true } },
    door(64, 0, false, false),
    arch(64, 0, true, false, false),
    light(56, 8, 12),
    light(79, 8, 12),
    sign(34, 6, { "𝘵𝘩𝘦 𝘬𝘦𝘺 𝘰𝘯 𝘵𝘩𝘦 𝘵𝘢𝘣𝘭𝘦\n𝘶𝘯𝘭𝘰𝘤𝘬𝘴 𝘢 𝘥𝘰𝘰𝘳 𝘰𝘯 𝘵𝘩𝘪𝘴\n𝘧𝘭𝘰𝘰𝘳...\n\n𝘣𝘶𝘵 𝘸𝘩𝘪𝘤𝘩 𝘰𝘯𝘦?" }),
    key(56, 64)
  }
)
room(
  4,
  2,
  {
    { name = "𝘵𝘩𝘦 𝘱𝘪𝘵 𝘮𝘢𝘻𝘦", flags = rf { pit = true } },
    w_button(84, 9)
  }
)
room(
  4,
  3,
  {
    { name = "𝘩𝘢𝘭𝘭 𝘰𝘧 𝘴𝘱𝘪𝘬𝘦𝘴", flags = rf { dungeon = true } },
    obj(15, 95, f.spike),
    obj(47, 79, f.spike),
    obj(63, 79, f.spike),
    obj(95, 95, f.spike)
  }
)
room(
  5, 0, {
    { name = "𝘰𝘶𝘵𝘦𝘳 𝘸𝘢𝘭𝘭𝘴 𝘷𝘪𝘦𝘸", flags = rf { dungeon = true } },
    obj(32, 16, f.rock),
    obj(48, 32, f.c_rock),
    obj(64, 48, f.rock)
  }
)
room(
  5, 1, {
    { name = "𝘵𝘩𝘦 𝘴𝘭𝘪𝘥𝘪𝘯𝘨 𝘧𝘭𝘰𝘰𝘳𝘴", flags = rf { dungeon = true } }
  }
)
room(
  5, 2, {
    { name = "𝘯𝘦𝘦𝘥 𝘯𝘢𝘮𝘦 𝘩𝘦𝘳𝘦", flags = rf { dungeon = true } }
  }
)
room(
  5, 3, {
    { name = "𝘯𝘦𝘦𝘥 𝘯𝘢𝘮𝘦 𝘩𝘦𝘳𝘦", flags = rf { dungeon = true } }
  }
)
room(
  6,
  0,
  {
    { name = "𝘰𝘶𝘵𝘦𝘳 𝘤𝘰𝘶𝘳𝘵𝘺𝘢𝘳𝘥", flags = rf { sewer = true, rain = true } },
    sign(
      105,
      53,
      {
        "𝘵𝘩𝘦 𝘯𝘦𝘹𝘵 𝘳𝘰𝘰𝘮 𝘩𝘢𝘴 𝘴𝘱𝘪𝘬𝘦𝘴\n𝘵𝘩𝘢𝘵 𝘴𝘩𝘰𝘰𝘵 𝘧𝘳𝘰𝘮 𝘣𝘰𝘵𝘵𝘰𝘮 𝘵𝘰\n𝘵𝘰𝘱. 𝘺𝘰𝘶 𝘩𝘢𝘷𝘦 𝘵𝘰 𝘱𝘳𝘦𝘴𝘴 𝘵𝘩𝘦\n𝘣𝘶𝘵𝘵𝘰𝘯 𝘢𝘵 𝘵𝘩𝘦 𝘵𝘰𝘱 𝘵𝘰 𝘴𝘵𝘰𝘱\n𝘵𝘩𝘦 𝘴𝘱𝘪𝘬𝘦𝘴 𝘢𝘯𝘥 𝘤𝘭𝘰𝘴𝘦...",
        "𝘵𝘩𝘦 𝘱𝘪𝘵𝘴 𝘥𝘰𝘰𝘳𝘴."
      }
    ),
    door(80, 112, false, true, true),
    arch(80, 120, true, true, false),
    light(72, 120, 12),
    light(103, 120, 12)
  }
)
room(
  6, 1, {
    { name = "𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    door(80, 0, false, false, true),
    arch(80, 0, true, false, false),
    light(72, 8, 12),
    light(103, 8, 12),
    obj(80, 80, f.flame),
    light(88, 84, 15),
    obj(80, 80, f.flame_f),
    obj(32, 32, f.bat),
    obj(48, 48, f.bat),
    obj(64, 64, f.bat),
    obj(64, 80, f.bat),
    obj(96, 96, f.bat),
    obj(112, 96, f.bat),
    obj(32, 80, f.bat),
    obj(64, 80, f.bat)
  }
)
room(
  7,
  0,
  {
    { name = "𝘴𝘱𝘪𝘬𝘦𝘴 𝘰𝘧 𝘥𝘰𝘰𝘮", flags = rf { sewer = true, rain = true } },
    w_button(20, 9),
    w_button(68, 9),
    w_button(116, 9),
    s_shoot_v(20, 114, true, 1, 60, 3, false),
    s_shoot_v(68, 114, true, 1, 60, 3, false),
    s_shoot_v(116, 114, true, 1, 60, 3, false)
  }
)
room(
  7,
  1,
  {
    { name = "𝘮𝘰𝘳𝘦 𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)
room(
  8,
  0,
  {
    { name = "𝘮𝘰𝘳𝘦 𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { sewer = true, rain = true } },
    door(112, 64, true, false),
    light(118, 54, 12),
    light(118, 84, 12),
    arch(120, 64, false, true, false),
    chest(96, 16),
    s_shoot_v(36, 114, true, 1, 60, 3, false),
    w_button(36, 9)
  }
)
room(
  8,
  1,
  {
    { name = "𝘳𝘦𝘢𝘭𝘭𝘺 𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)
room(
  8, 2, {
    { name = "𝘥𝘦𝘧𝘢𝘶𝘭𝘵 𝘳𝘰𝘰𝘮 𝘯𝘢𝘮𝘦", flags = rf { dungeon = true } }
  }
)

room(
  9, 0, {
    { name = "𝘵𝘩𝘦 𝘭𝘪𝘨𝘩𝘵𝘭𝘦𝘴𝘴 𝘱𝘪𝘵", flags = rf { pit = true } },
    door(0, 64, true, true),
    light(8, 54, 12),
    light(8, 84, 12),
    arch(0, 64, false, false, false),
    light(88, 100, 20),
    obj(80, 96, f.flame_f),
    light(54, 20, 20),
    obj(48, 16, f.flame_b),
    obj(112, 32, f.rat),
    obj(112, 48, f.rat),
    obj(112, 64, f.rat),
    obj(112, 80, f.rat),
    obj(112, 96, f.rat),
    obj(80, 32, f.rat),
    obj(80, 48, f.rat)
  }
)

room(
  9, 1, {
    { name = "𝘤𝘳𝘶𝘮𝘣𝘭𝘦𝘥 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat),
    key(100, 6)
  }
)

room(
  10, 0, {
    { name = "𝘵𝘩𝘦 𝘭𝘪𝘨𝘩𝘵𝘭𝘦𝘴𝘴 𝘱𝘪𝘵", flags = rf { pit = true } },
    obj(48, 96, f.flame_f),
    light(56, 100, 20),
    obj(64, 32, f.flame_b),
    light(72, 36, 20)
  }
)

room(
  10, 1, {
    { name = "𝘤𝘳𝘶𝘮𝘣𝘭𝘦𝘥 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj(40, 80, f.bat),
    obj(90, 50, f.bat),
    obj(64, 64, f.bat)
  }
)

--

function unlock_door(o)
  local ax, ay = mapx + o.x, mapy + o.y
  door_states[ax .. "_" .. ay] = true
  o.locked, o.flags.solid = false, false
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

function door_lights(x, y, fx, fy, flp)
  local a, i = flp and { 240, 241, 241, 240 } or { 224, 225, 225, 224 }, flr(time() * (4 * t_increment) % 4) + 1
  local flip = i > 2
  if flp then
    spr(a[i], x + 4, y - 12, 1, 1, fx, flip) spr(a[i], x + 4, y + 20, 1, 1, fx, flip)
  else
    spr(a[i], x - 12, y + 4, 1, 1, flip, fy) spr(a[i], x + 20, y + 4, 1, 1, flip, fy)
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

function draw_player_interact_icon()
  local engaged_now = false
  for o in all(active_objects) do
    local flag = o.flags
    if flag.interactable then
      local ox, oy = mapx + o.x, mapy + o.y
      local len = abs(ox - p.x) + abs(oy - p.y + 6)
      if len > 0 and len < 22 then
        engaged_now = true
        if flag.sign and not reading and val == 0 and btn(𝘣𝘵𝘯_𝘰) then
          t_increment = 0.05 tb_init(15, o.text)
        end
        if flag.sign then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.key then
          sspr(29, 80, 3, 7, p.x + 8, p.y - 8)
          if btnp(𝘣𝘵𝘯_𝘰) then
            p.keys = (p.keys or 0) + 1
            del(active_objects, o)
            sfx(18, 3)
          end
        end
        if flag.chest then sspr(29, 80, 3, 7, p.x + 8, p.y - 8) end
        if flag.door and flag.solid then
          if p.keys > 0 then sspr(113, 96, 5, 8, p.x + 8, p.y - 8) end
          if btnp(𝘣𝘵𝘯_𝘰) then
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
    local flag = a_obj.flags
    if flag.rain ~= nil then raindrops = flag.rain end
    if flag.quake ~= nil then quake = flag.quake end
    if flag.sewer then
      palette(sewer)
    elseif flag.dungeon then
      palette(dungeon)
    elseif flag.pit then
      palette(pit)
    end
    if flag.vase then spr(172, mapx + a_obj.x, mapy + a_obj.y, 2, 2) end
    if flag.sign then spr(170, mapx + a_obj.x, mapy + a_obj.y, 2, 2) end
    if flag.key then spr(254, mapx + a_obj.x, mapy + a_obj.y, 2, 1) end
    if flag.door then
      if a_obj.flp then
        if a_obj.locked then spr(168, mapx + a_obj.x, mapy + a_obj.y, 2, 2, a_obj.fy, a_obj.fx) end
      else
        if a_obj.locked then spr(128, mapx + a_obj.x, mapy + a_obj.y, 2, 2, a_obj.fx, a_obj.fy) end
      end
      door_lights(mapx + a_obj.x, mapy + a_obj.y, a_obj.fx, a_obj.fy, a_obj.flp)
    end
    if flag.chest then spr(13, mapx + a_obj.x, mapy + a_obj.y, 2, 2, a_obj.fx, a_obj.fy) end
    if flag.rock then spr(134, mapx + a_obj.x, mapy + a_obj.y, 2, 2) end
    if flag.stairs_down then spr(130, mapx + a_obj.x, mapy + a_obj.y, 2, 2) end
    if flag.stairs_up then spr(132, mapx + a_obj.x, mapy + a_obj.y, 2, 2) end
    if flag.c_rock then spr(136, mapx + a_obj.x, mapy + a_obj.y, 2, 2) end
    if flag.spike_tile then animate_spikes(a_obj) end
    if flag.w_button then spr(95, mapx + a_obj.x, mapy + a_obj.y, 1, 1) end
    if flag.flames_back then flames(mapx + a_obj.x, mapy + a_obj.y) end
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
    local flag = a_obj.flags
    if flag.bat and not a_obj.spawned then
      add(baddie_m.baddies, bat(mapx + a_obj.x, mapy + a_obj.y)) a_obj.spawned = true
    end
    if flag.rat and not a_obj.spawned then
      add(baddie_m.baddies, rat(mapx + a_obj.x, mapy + a_obj.y)) a_obj.spawned = true
    end
    if flag.blob and not a_obj.spawned then
      add(baddie_m.baddies, blob(mapx + a_obj.x, mapy + a_obj.y)) a_obj.spawned = true
    end
    if flag.door_arches then
      if a_obj.vori then
        if a_obj.flp == false then rectfill(mapx + a_obj.x - 4, mapy + a_obj.y + 2, mapx + a_obj.x + 19, mapy + a_obj.y - 6, 0) end
        if a_obj.flp == true then rectfill(mapx + a_obj.x - 4, mapy + a_obj.y + 5, mapx + a_obj.x + 19, mapy + a_obj.y + 13, 0) end
        spr(49, mapx + a_obj.x + 8, mapy + a_obj.y, 1, 1, false, a_obj.flp) spr(49, mapx + a_obj.x, mapy + a_obj.y, 1, 1, true, a_obj.flp)
      else
        spr(51, mapx + a_obj.x, mapy + a_obj.y, 1, 1, a_obj.flp, true) spr(51, mapx + a_obj.x, mapy + a_obj.y + 8, 1, 1, a_obj.flp, false)
      end
    end
    if flag.flames_fore then
      flames(mapx + a_obj.x, mapy + a_obj.y)
    end
    if flag.s_shoot_v or flag.s_shoot_h then
      local v = flag.s_shoot_v
      sspr(112, v and 56 or 48, v and 8 or 5, v and 5 or 8, mapx + a_obj.x, mapy + a_obj.y, v and 8 or 5, v and 5 or 8, v and false or a_obj.flp, v and a_obj.flp or false)
      if not a_obj.added then
        add(shooters, a_obj) a_obj.added = true
      end
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

function load_room_objects(room_id)
  active_objects = room_objects[room_id] or {}
  normalize_obj_list(active_objects)
  for o in all(active_objects) do
    if o.flags and o.flags.door then
      o.id = (mapx * 128 + o.x) .. "_" .. (mapy * 128 + o.y)
      if door_states[o.id] then
        o.locked = false o.flags.solid = false
      else
        o.locked = (o.locked == nil) and true or o.locked
      end
    end
  end
end

--

local current_room = ""
function check_room_change()
  local new_room = get_current_room()
  if new_room ~= current_room then
    current_room = new_room

    active_objects = {}
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
  end
end

--

function draw_torch_light()
  for a_obj in all(active_objects) do
    if a_obj.flags.light then
      local px, py = mapx + a_obj.x, mapy + a_obj.y
      fillp(32125.5) circfill(px, py, a_obj.r + rnd(3) + 10, 14)
      fillp(23130.5) circfill(px, py, a_obj.r + rnd(3) + 6, 14)
      fillp(0x0000) circfill(px, py, a_obj.r + rnd(3) + 3, 14)
    end
  end
end

--

arrows = {}
shooters = {}

function spawn_arrow(shooter)
  local direction, vx, vy
  if shooter.flags.s_shoot_v then
    direction = shooter.flp and 1 or 0
    vx = 0 vy = shooter.speed * (direction == 1 and 1 or -1)
  else
    direction = shooter.flp and 3 or 2
    vy = 0 vx = shooter.speed * (direction == 2 and 1 or -1)
  end
  add(arrows, { x = shooter.x, y = shooter.y, vx = vx, vy = vy, d = direction })
  sfx(19, 3)
end

function update_shooters()
  if mapx == cur_room_x and mapy == cur_room_y then
    for shooter in all(shooters) do
      if shooter.active then
        shooter.delay -= t_increment
        if shooter.delay <= 0 then
          spawn_arrow(shooter)
          shooter.delay = shooter.timing
        end
      end
    end
  end
end

function update_arrows()
  for arrow in all(arrows) do
    -- move the arrow
    arrow.x += arrow.vx * t_increment
    arrow.y += arrow.vy * t_increment

    -- collision with player
    if arrow.x < p.x + 8 and arrow.x + 8 > p.x and arrow.y < p.y + 8 and arrow.y + 8 > p.y then
      p.remaining_hearts -= 1
      p.dx, p.dy = arrow.vx, arrow.vy
      del(arrows, arrow)
    end

    -- arrow leaves the screen
    if arrow.x < mapx or arrow.x > mapx + 120 or arrow.y < mapy or arrow.y > mapy + 120 then
      del(arrows, arrow)
    end
  end
end

local adraw = {
  { 117, 48, 3, 8, false, false, 2, -4 }, -- 𝘥𝘰𝘸𝘯 to 𝘶𝘱 -- 𝘥𝘰𝘯𝘦
  { 117, 48, 3, 8, false, true, 3, 2 }, -- 𝘶𝘱 to 𝘥𝘰𝘸𝘯
  { 112, 61, 8, 3, false, false, 2, 2 }, -- 𝘭𝘦𝘧𝘵 to 𝘳𝘪𝘨𝘩𝘵 -- 𝘥𝘰𝘯𝘦
  { 112, 61, 8, 3, true, false, -4, 2 } -- 𝘳𝘪𝘨𝘩𝘵 to 𝘭𝘦𝘧𝘵
}

function draw_arrows()
  for arrow in all(arrows) do
    local d = adraw[arrow.d + 1]
    sspr(
      d[1], d[2], d[3], d[4], arrow.x + d[7], arrow.y + d[8], d[3], d[4], d[5], d[6]
    )
  end
end