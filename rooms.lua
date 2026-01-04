--rooms
room_objects, door_states, active_objects, arrows, events = {}, {}, {}, {}, {}
room = function(x, y, t) room_objects[x .. "_" .. y] = t end

--

rf = function(t)
  local w = { name = true, dungeon = false, sewer = false, pit = false, rain = false }
  for k, v in pairs(t) do
    w[k] = v
  end
  return w
end

--

local function convert(v)
  if v == nil or v == "nil" then return nil end
  if v == "true" then return true end
  if v == "false" then return false end
  local num = tonum(v)
  if num ~= nil then return num end
  return v
end

--   level name and type  = 1
--   x = 2
--   y = 3
--   vori = 4
--   rad = 5
--   flx = 6
--   fly = 7
--   flp = 8
--   interactable = 9
--   solid = 10
--   locked = 11
--   text = 12
--   active = 13
--   delay = 14
--   timing = 15
--   speed = 16

function obj(s)
  local t, o = split(s), {}
  local c = convert
  for i, k in ipairs { "x", "y", "vori", "rad", "flx", "fly", "flp", "interactable", "solid", "locked", "text", "active", "delay", "timing", "speed" } do
    local v = c(t[i + 1])
    if v ~= nil then o[k] = v end
  end
  o.flags = { [t[1]] = true, solid = o.solid, interactable = o.interactable, locked = o.locked }
  return o
end

function sign_dialog(index)
  local alltext = {
    {
      "WECOME TO THE DARK DUNGEONS\nOF CASTLE DOOM. CONTAINED\nWITHIN THIS DARK WALLS ARE\nSECRETS, TRIALS, MONSTERS\nAND TREASURES BEYOND...",
      "YOUR WILDEST IMAGINATION.\nARMED ONLY WITH A SWORD AND\nYOUR ELVEN POWER OF\nILLUMINATION, YOU MUST BRAVE\nTHE TERRORS IN THE DARK.",
      "MAY GOD HAVE MERCY ON\nYOUR SOUL!"
    },
    {
      "𝘢𝘩𝘦𝘢𝘥 𝘭𝘪𝘦𝘴 𝘺𝘰𝘶𝘳 𝘨𝘳𝘦𝘢𝘵𝘦𝘴𝘵\n𝘤𝘩𝘢𝘭𝘭𝘦𝘯𝘨𝘦 𝘴𝘰 𝘧𝘢𝘳...\n\n...𝘵𝘩𝘦 𝘥𝘳𝘦𝘢𝘥𝘦𝘥 𝘣𝘰𝘴𝘴𝘯𝘢𝘮𝘦",
      "𝘩𝘦'𝘴 𝘵𝘰𝘶𝘨𝘩 𝘢𝘯𝘥 𝘧𝘢𝘴𝘵 𝘣𝘶𝘵 𝘩𝘦\n𝘥𝘰𝘦𝘴𝘯'𝘵 𝘴𝘦𝘦 𝘵𝘰𝘰 𝘸𝘦𝘭𝘭 𝘪𝘯\n𝘵𝘩𝘦 𝘥𝘢𝘳𝘬. 𝘵𝘩𝘢𝘵 𝘤𝘰𝘶𝘭𝘥 𝘮𝘢𝘬𝘦\n𝘢𝘭𝘭 𝘵𝘩𝘦 𝘥𝘪𝘧𝘧𝘦𝘳𝘦𝘯𝘤𝘦."
    },
    {
      "𝘵𝘩𝘳𝘦𝘦 𝘣𝘶𝘵𝘵𝘰𝘯𝘴 𝘮𝘶𝘴𝘵 𝘣𝘦\n𝘱𝘳𝘦𝘴𝘴𝘦𝘥 𝘵𝘰 𝘳𝘦𝘷𝘦𝘢𝘭 𝘵𝘩𝘦\n𝘩𝘪𝘥𝘥𝘦𝘯 𝘴𝘵𝘢𝘪𝘳𝘤𝘢𝘴𝘦.\n\n𝘸𝘩𝘦𝘳𝘦 𝘤𝘰𝘶𝘭𝘥 𝘵𝘩𝘦𝘺 𝘣𝘦?"
    },
    {
      "𝘵𝘩𝘦 𝘬𝘦𝘺 𝘰𝘯 𝘵𝘩𝘦 𝘵𝘢𝘣𝘭𝘦\n𝘶𝘯𝘭𝘰𝘤𝘬𝘴 𝘢 𝘥𝘰𝘰𝘳 𝘰𝘯 𝘵𝘩𝘪𝘴\n𝘧𝘭𝘰𝘰𝘳...\n\n𝘣𝘶𝘵 𝘸𝘩𝘪𝘤𝘩 𝘰𝘯𝘦?"
    },
    {
      "𝘵𝘩𝘦 𝘯𝘦𝘹𝘵 𝘳𝘰𝘰𝘮 𝘩𝘢𝘴 𝘴𝘱𝘪𝘬𝘦𝘴\n𝘵𝘩𝘢𝘵 𝘴𝘩𝘰𝘰𝘵 𝘧𝘳𝘰𝘮 𝘣𝘰𝘵𝘵𝘰𝘮 𝘵𝘰\n𝘵𝘰𝘱. 𝘺𝘰𝘶 𝘩𝘢𝘷𝘦 𝘵𝘰 𝘱𝘳𝘦𝘴𝘴 𝘵𝘩𝘦\n𝘣𝘶𝘵𝘵𝘰𝘯 𝘢𝘵 𝘵𝘩𝘦 𝘵𝘰𝘱 𝘵𝘰 𝘴𝘵𝘰𝘱\n𝘵𝘩𝘦 𝘴𝘱𝘪𝘬𝘦𝘴 𝘢𝘯𝘥 𝘤𝘭𝘰𝘴𝘦...",
      "𝘵𝘩𝘦 𝘱𝘪𝘵𝘴 𝘥𝘰𝘰𝘳𝘴."
    }
  }
  return alltext[index]
end

--

room(
  0, 0, {
    { name = "𝘤𝘢𝘴𝘵𝘭𝘦 𝘦𝘯𝘵𝘳𝘢𝘯𝘤𝘦", flags = rf { dungeon = true } },
    obj "c_rock,64,0,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "arch,64,0,true,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "sign,33,5,nil,nil,nil,nil,nil,true,true,nil,1,nil,nil,nil,nil",
    obj "rock,64,64,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "rock,80,64,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "flames_back,16,16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,24,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_back,96,16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,104,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "arch,64,120,true,nil,true,true,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "door,64,112,nil,nil,false,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "light,56,120,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,87,120,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "vase,16,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,16,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,32,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",

    obj "button,85,7,nil,nil,nil,4,nil,true,nil,nil,show_chest_0_0,nil,nil,nil,nil",
    obj "chest,48,64,key,nil,nil,nil,nil,false,false,true,show_chest_0_0,false,nil,nil,nil",
    -- obj "coin,30,70,nil,nil,nil,nil,nil,nil,nil,nil,nil,false,nil,nil,nil",
    -- obj "coin,96,68,nil,nil,nil,nil,nil,nil,nil,nil,nil,false,nil,nil,nil",
    -- obj "coin,30,66,nil,nil,nil,nil,nil,nil,nil,nil,nil,false,nil,nil,nil",

    -- obj "s_shoot_v,96,112,nil,nil,nil,nil,false,nil,nil,nil,nil,true,1,60,1",
    -- obj "s_shoot_h,15,36,nil,nil,nil,nil,false,nil,nil,nil,nil,true,1,60,1",
    -- obj "s_shoot_v,50,16,nil,nil,nil,nil,true,nil,nil,nil,nil,true,1,60,1",
    -- obj "s_shoot_h,112,48,nil,nil,nil,nil,true,nil,nil,nil,nil,true,1,60,1",

    obj "stairs_up,112,96,nil,nil,148,295,true,nil,true,nil,nil,true,nil,nil,nil",
    obj "rock,112,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil"
  }
)
room(
  0, 1, {
    { name = "𝘤𝘢𝘴𝘵𝘭𝘦 𝘨𝘢𝘳𝘥𝘦𝘯 𝘴𝘵𝘰𝘳𝘢𝘨𝘦", flags = rf { sewer = true, rain = true } },
    obj "door,64,0,nil,nil,false,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,64,0,true,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,56,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,87,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "vase,112,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,112,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,96,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,96,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "bat,20,90,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,100,32,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "vase,32,48,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil"
  }
)
room(
  0, 2, {
    { name = "𝘮𝘢𝘪𝘯 𝘣𝘰𝘴𝘴 𝘤𝘩𝘢𝘮𝘣𝘦𝘳", flags = rf { dungeon = true } },
    obj "door,64,112,nil,nil,false,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,64,120,true,nil,true,true,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_back,16,16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,24,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_back,96,16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,104,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_fore,16,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,24,100,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_fore,96,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,104,100,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  0, 3, {
    { name = "𝘱𝘢𝘴𝘴𝘢𝘨𝘦 𝘦𝘯𝘥", flags = rf { dungeon = true } },
    obj "door,64,0,nil,nil,false,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,64,0,true,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,56,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,87,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_fore,32,16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,40,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_fore,80,16,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,88,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "sign,18,70,nil,nil,nil,nil,nil,true,true,nil,2,nil,nil,nil,nil"
  }
)
room(
  1, 0, {
    { name = "𝘦𝘯𝘵𝘳𝘢𝘯𝘤𝘦 𝘭𝘰𝘣𝘣𝘺 𝘪𝘯𝘯𝘦𝘳", flags = rf { dungeon = true } },
    obj "door,112,32,nil,nil,true,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,120,32,false,nil,true,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,22,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,52,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rock,32,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "rock,96,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "rat,96,40,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,94,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "button,96,7,nil,nil,nil,4,nil,true,false,nil,show_chest_1_0,nil,nil,nil,nil",
    obj "chest,32,32,key,nil,nil,nil,nil,false,false,true,show_chest_1_0,false,nil,nil,nil"
  }
)
room(
  1, 1, {
    { name = "𝘤𝘢𝘴𝘵𝘭𝘦 𝘨𝘢𝘳𝘥𝘦𝘯 𝘴𝘵𝘰𝘳𝘢𝘨𝘦", flags = rf { sewer = true, rain = true } },
    obj "door,112,32,nil,nil,true,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,120,32,false,nil,true,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,22,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,52,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "vase,16,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,16,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,0,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,0,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,96,16,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,96,48,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,16,16,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,32,16,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "stairs_down,32,96,nil,nil,102,102,nil,nil,true,nil,nil,nil,nil,nil,nil"
  }
)
room(
  1, 2, {
    { name = "BASEMENT OF THE FLIES", flags = rf { pit = true } },
    obj "stairs_down,16,16,nil,nil,102,102,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "spike,16,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "spike,32,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "spike,48,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "sign,48,21,nil,nil,nil,nil,nil,true,true,nil,3,nil,nil,nil,nil",
    obj "button,100,73,nil,nil,nil,4,nil,nil,nil,nil,three_buttons_1,nil,nil,nil,nil",
    obj "rat,94,50,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  1, 3, {
    { name = "NEEDS A NAME", flags = rf { dungeon = true } }
  }
)
room(
  2, 0, {
    { name = "𝘵𝘩𝘦 𝘣𝘰𝘵𝘵𝘰𝘮𝘭𝘦𝘴𝘴 𝘱𝘢𝘵𝘩𝘴 - 𝘸𝘦𝘴𝘵", flags = rf { dungeon = true } },
    obj "door,0,32,nil,nil,true,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,0,32,false,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,8,22,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,8,52,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "arch,48,120,true,nil,true,true,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "key,18,100,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,80,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,60,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  2, 1, {
    { name = "𝘸𝘢𝘵𝘤𝘩 𝘵𝘩𝘦 𝘥𝘳𝘰𝘱", flags = rf { dungeon = true } },
    obj "door,0,32,nil,nil,true,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,0,32,false,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,8,22,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,8,52,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "arch,48,0,true,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  2, 2, {
    { name = "BASEMENT OF THE FLIES", flags = rf { pit = true } },
    obj "button,20,41,nil,nil,nil,4,nil,nil,nil,nil,three_buttons_2,nil,nil,nil,nil"
  }
)
room(
  2, 3, {
    { name = "NEEDS A NAME", flags = rf { dungeon = true } }
  }
)
room(
  3, 0, {
    { name = "𝘵𝘩𝘦 𝘣𝘰𝘵𝘵𝘰𝘮𝘭𝘦𝘴𝘴 𝘱𝘢𝘵𝘩𝘴 - 𝘦𝘢𝘴𝘵", flags = rf { dungeon = true } },
    obj "bat,80,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,60,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,10,90,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  3, 1, {
    { name = "𝘵𝘩𝘦 𝘣𝘰𝘵𝘵𝘰𝘮𝘭𝘦𝘴𝘴 𝘱𝘢𝘵𝘩𝘴 - 𝘴𝘰𝘶𝘵𝘩", flags = rf { dungeon = true } },
    obj "chest,70,40,map,nil,nil,nil,nil,true,true,true,show_chest_3_1,true,nil,nil,nil"
  }
)
room(
  3, 2, {
    { name = "BASEMENT OF THE FLIES", flags = rf { pit = true } }
  }
)
room(
  3, 3, {
    { name = "NEEDS A NAME", flags = rf { dungeon = true } }
  }
)
room(
  4, 0, {
    { name = "𝘳𝘦𝘴𝘵𝘪𝘯𝘨 𝘱𝘰𝘪𝘯𝘵", flags = rf { dungeon = true } },
    obj "arch,64,120,true,nil,true,true,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "door,64,112,nil,nil,false,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "light,56,120,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,87,120,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_back,80,32,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,88,36,nil,30,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "vase,80,8,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,16,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,32,96,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "vase,16,80,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil"
  }
)
room(
  4, 1, {
    { name = "𝘮𝘺𝘴𝘵𝘦𝘳𝘺 𝘬𝘦𝘺 𝘳𝘰𝘰𝘮", flags = rf { dungeon = true } },
    obj "door,64,0,nil,nil,false,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,64,0,true,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,56,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,87,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "sign,34,6,nil,nil,nil,nil,nil,true,true,nil,4,nil,nil,nil,nil",
    obj "key,56,64,nil,nil,nil,nil,nil,true,true,nil,1,nil,nil,nil,nil"
  }
)
room(
  4, 2, {
    { name = "BASEMENT OF THE FLIES", flags = rf { pit = true } },
    obj "button,84,9,nil,nil,nil,4,nil,nil,nil,nil,three_button_stairs_4_2,nil,nil,nil,nil",
    obj "stairs_up,96,96,3,8,148,295,true,nil,nil,nil,three_button_stairs_4_2,false,nil,nil,nil"
  }
)
room(
  4, 3, {
    { name = "𝘩𝘢𝘭𝘭 𝘰𝘧 𝘴𝘱𝘪𝘬𝘦𝘴", flags = rf { dungeon = true } },
    obj "spike,15,95,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "spike,47,79,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "spike,63,79,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "spike,95,95,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  5, 0, {
    { name = "𝘰𝘶𝘵𝘦𝘳 𝘸𝘢𝘭𝘭𝘴 𝘷𝘪𝘦𝘸", flags = rf { dungeon = true } },
    obj "vase,16,8,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "rock,32,16,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "c_rock,48,32,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil",
    obj "rock,64,48,nil,nil,nil,nil,nil,nil,true,nil,nil,nil,nil,nil,nil"
  }
)
room(
  5, 1, {
    { name = "𝘵𝘩𝘦 𝘴𝘭𝘪𝘥𝘪𝘯𝘨 𝘧𝘭𝘰𝘰𝘳𝘴", flags = rf { dungeon = true } }
  }
)
room(
  5, 2, {
    { name = "𝘯𝘦𝘦𝘥 𝘯𝘢𝘮𝘦 𝘩𝘦𝘳𝘦", flags = rf { dungeon = true } },
    obj "s_shoot_h,47,36,nil,nil,nil,nil,false,nil,nil,nil,nil,true,1,60,1",
    obj "s_shoot_h,80,52,nil,nil,nil,nil,true,nil,nil,nil,nil,true,1,90,1",
    obj "s_shoot_h,47,84,nil,nil,nil,nil,false,nil,nil,nil,nil,true,1,90,1",
    obj "s_shoot_h,80,100,nil,nil,nil,nil,true,nil,nil,nil,nil,true,1,60,1"
  }
)
room(
  5, 3, {
    { name = "𝘯𝘦𝘦𝘥 𝘯𝘢𝘮𝘦 𝘩𝘦𝘳𝘦", flags = rf { dungeon = true } },
    obj "door,112,48,nil,nil,true,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,120,48,false,nil,true,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,38,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,68,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  6, 0, {
    { name = "𝘰𝘶𝘵𝘦𝘳 𝘤𝘰𝘶𝘳𝘵𝘺𝘢𝘳𝘥", flags = rf { sewer = true, rain = true } },
    obj "arch,80,120,true,nil,true,true,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "door,80,112,nil,nil,false,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "light,72,120,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,103,120,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "sign,105,53,nil,nil,nil,nil,nil,true,true,nil,5,nil,nil,nil,nil"
  }
)
room(
  6, 1, {
    { name = "𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj "door,80,0,nil,nil,false,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,80,0,true,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,72,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,103,8,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_fore,80,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,88,84,nil,15,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,80,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,32,32,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,48,48,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,64,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,96,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,112,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,32,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,64,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  7, 0, {
    { name = "𝘴𝘱𝘪𝘬𝘦𝘴 𝘰𝘧 𝘥𝘰𝘰𝘮", flags = rf { sewer = true, rain = true } },
    obj "button,20,9,nil,nil,nil,4,nil,nil,nil,nil,stop_shooter_1_7_0,nil,nil,nil,nil",
    obj "button,68,9,nil,nil,nil,4,nil,nil,nil,nil,stop_shooter_2_7_0,nil,nil,nil,nil",
    obj "button,116,9,nil,nil,nil,4,nil,nil,nil,nil,stop_shooter_3_7_0,nil,nil,nil,nil",
    obj "s_shoot_v,20,114,nil,nil,nil,nil,false,nil,nil,nil,stop_shooter_1_7_0,true,1,90,2.5",
    obj "s_shoot_v,68,114,nil,nil,nil,nil,false,nil,nil,nil,stop_shooter_2_7_0,true,1,95,2.5",
    obj "s_shoot_v,116,114,nil,nil,nil,nil,false,nil,nil,nil,stop_shooter_3_7_0,true,1,85,2.5",
    obj "floor_tile,48,72,nil,nil,nil,nil,nil,true,true,nil,nil,false,nil,nil,nil",
    obj "floor_tile,96,72,nil,nil,nil,nil,nil,true,true,nil,nil,false,nil,nil,nil"
  }
)
room(
  7, 1, {
    { name = "𝘮𝘰𝘳𝘦 𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj "bat,40,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,90,50,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,64,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)
room(
  8, 0, {
    { name = "𝘮𝘰𝘳𝘦 𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { sewer = true, rain = true } },
    obj "door,112,64,nil,nil,true,false,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,120,64,false,nil,true,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,54,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,118,84,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "chest,96,16,health_potion,nil,nil,nil,nil,true,true,true,nil,true,nil,nil,nil",
    obj "button,36,9,nil,nil,nil,4,nil,nil,nil,nil,stop_shooter_1_8_0,nil,nil,nil,nil",
    obj "s_shoot_v,36,106,nil,nil,nil,nil,false,nil,nil,nil,stop_shooter_1_8_0,true,1,90,2.5"
  }
)
room(
  8, 1, {
    { name = "𝘳𝘦𝘢𝘭𝘭𝘺 𝘤𝘳𝘶𝘮𝘣𝘭𝘪𝘯𝘨 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj "bat,40,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,90,50,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,64,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
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
    obj "door,0,64,nil,nil,true,true,nil,true,true,true,nil,nil,nil,nil,nil",
    obj "arch,0,64,false,nil,false,false,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,8,54,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,8,84,nil,12,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,88,100,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,54,20,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_fore,80,94,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_back,48,16,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,112,32,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,112,48,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,112,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,112,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,112,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,80,32,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "rat,80,48,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)

room(
  9, 1, {
    { name = "𝘤𝘳𝘶𝘮𝘣𝘭𝘦𝘥 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj "bat,40,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,90,50,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,64,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "key,100,6,nil,nil,nil,nil,nil,true,true,nil,1,nil,nil,nil,nil"
  }
)

room(
  10, 0, {
    { name = "𝘵𝘩𝘦 𝘭𝘪𝘨𝘩𝘵𝘭𝘦𝘴𝘴 𝘱𝘪𝘵", flags = rf { pit = true } },
    obj "flames_fore,48,96,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,56,100,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "flames_back,64,32,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "light,72,36,nil,20,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)

room(
  10, 1, {
    { name = "𝘤𝘳𝘶𝘮𝘣𝘭𝘦𝘥 𝘨𝘳𝘰𝘵𝘵𝘰", flags = rf { dungeon = true } },
    obj "bat,40,80,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,80,50,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil",
    obj "bat,64,64,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil,nil"
  }
)

--

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
          tb_init(15, sign_dialog(o.text))
        end
        if flag.sign then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.health_potion then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.map then sspr(24, 80, 5, 7, p.x + 8, p.y - 8) end
        if flag.key then
          sspr(29, 80, 3, 7, p.x + 8, p.y - 8)
          if btnp(BTN_O) then
            p.keys = (p.keys or 0) + 1
            chest_alert("KEY ADDED")
            del(active_objects, o)
            sfx(18, 3)
          end
        end
        if flag.chest then
          if o.active and o.locked then
            sspr(29, 80, 3, 7, p.x + 8, p.y - 8)
            if btnp(BTN_O) and o.locked then
              sfx(51, 3)

              boom(o.x + mapx, o.y + mapy, 9, 8, 7, 12, rnd({ 1, 2, 3 }))

              del(active_objects, o)

              chest_alert("DISCOVERED A " .. o.vori)

              add(
                active_objects, obj("" .. o.vori .. "," .. o.x .. "," .. o.y + 4 .. ", nil, nil, nil, nil, nil, true, false, nil, nil, nil, nil, nil, nil")
              )
              if btnp(BTN_O) then return end
              -- o.locked = false
            end
          end
        end
        if flag.door and flag.solid then
          if p.keys > 0 then sspr(113, 96, 5, 8, p.x + 8, p.y - 8) end
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
    local flag, ax, ay, afx, afy = a_obj.flags, a_obj.x, a_obj.y, a_obj.flx, a_obj.fly
    if flag.rain ~= nil then raindrops = flag.rain end
    if flag.sewer then
      palette(sewer)
    elseif flag.dungeon then
      palette(dungeon)
    elseif flag.pit then
      palette(pit)
    end
    if flag.vase then spr(172, mapx + ax, mapy + ay, 2, 2) end
    if flag.sign then spr(170, mapx + ax, mapy + ay, 2, 2) end
    if flag.key then spr(254, mapx + ax, mapy + ay, 2, 1) end
    if flag.map then spr(61, mapx + ax + 4, mapy + ay, 1, 1) end
    if flag.health_potion then spr(45, mapx + ax + 4, mapy + ay, 1, 1) end
    if flag.door then
      if a_obj.flp then
        if a_obj.locked then spr(168, mapx + ax, mapy + ay, 2, 2, afy, afx) end
      else
        if a_obj.locked then spr(128, mapx + ax, mapy + ay, 2, 2, afx, afy) end
      end
      door_lights(mapx + ax, mapy + ay, afx, afy, a_obj.flp)
    end
    if flag.coin then
      sspr(112, 104, 8, 6, mapx + ax, mapy + ay)
    end
    if flag.chest then
      if a_obj.active then
        a_obj.flags.interactable = true
        if a_obj.locked then
          spr(13, mapx + ax, mapy + ay, 2, 2)
          -- else
          -- spr(45, mapx + ax, mapy + ay, 2, 2)
          -- a_obj.flags.interactable = false
        end
      end
    end
    if flag.rock then spr(134, mapx + ax, mapy + ay, 2, 2) end
    if flag.stairs_down then
      spr(130, mapx + ax, mapy + ay, 2, 2)
      if stairs_trigger(a_obj) then
        use_transition(a_obj)
      end
    end
    if flag.stairs_up then
      if a_obj.active then
        spr(132, mapx + ax, mapy + ay, 2, 2, a_obj.flp, false)
        if stairs_trigger(a_obj) then
          use_transition(a_obj)
        end
      end
    end
    if flag.c_rock then spr(136, mapx + ax, mapy + ay, 2, 2) end
    if flag.spike then animate_spikes(a_obj) end
    if flag.button then
      if a_obj.pressed then
        spr(111, mapx + ax, mapy + ay, 1, 1)
      else
        spr(95, mapx + ax, mapy + ay, 1, 1)
      end
    end
    if flag.flames_back then flames(mapx + ax, mapy + ay) end
    if flag.s_shoot_v or flag.s_shoot_h then
      local v = flag.s_shoot_v
      sspr(112, v and 56 or 48, v and 8 or 5, v and 5 or 8, mapx + a_obj.x, mapy + a_obj.y, v and 8 or 5, v and 5 or 8, v and false or a_obj.flp, v and a_obj.flp or false)
      if not a_obj.added then
        add(get_room_shooters(cur_room_x, cur_room_y), a_obj) a_obj.added = true
      end
    end
    if flag.floor_tile then
      if not a_obj.active then
        spr(43, mapx + ax - 16, mapy + ay, 2, 2)
        spr(43, mapx + ax, mapy + ay, 2, 2)
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
    local flag, ax, ay = a_obj.flags, a_obj.x, a_obj.y

    if flag.bat and not a_obj.spawned then
      add(baddie_m.baddies, bat(mapx + ax, mapy + ay)) a_obj.spawned = true
    end

    if flag.rat and not a_obj.spawned then
      add(baddie_m.baddies, rat(mapx + ax, mapy + ay)) a_obj.spawned = true
    end

    if flag.blob and not a_obj.spawned then
      add(baddie_m.baddies, blob(mapx + ax, mapy + ay)) a_obj.spawned = true
    end

    if flag.arch then
      if a_obj.vori then
        if a_obj.flp == false then rectfill(mapx + ax - 4, mapy + ay + 2, mapx + ax + 19, mapy + ay - 6, 0) end
        if a_obj.flp == true then rectfill(mapx + ax - 4, mapy + ay + 5, mapx + ax + 19, mapy + ay + 13, 0) end
        spr(49, mapx + ax + 8, mapy + ay, 1, 1, false, a_obj.flp)
        spr(49, mapx + ax, mapy + ay, 1, 1, true, a_obj.flp)
      else
        spr(51, mapx + ax, mapy + ay, 1, 1, a_obj.flp, true)
        spr(51, mapx + ax, mapy + ay + 8, 1, 1, a_obj.flp, false)
      end
    end

    if flag.flames_fore then
      flames(mapx + ax, mapy + ay)
    end

    -- if flag.chest and not a_obj.locked then
    --   reading = true
    --   chest_modal(a_obj.vori)
    -- end
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

--

room_shooters = {}

function get_room_shooters(x, y)
  local key = x .. "_" .. y
  if not room_shooters[key] then room_shooters[key] = {} end
  return room_shooters[key]
end

function spawn_arrow(shooter)
  local direction, vx, vy
  if shooter.flags.s_shoot_v then
    direction = shooter.flp and 1 or 0
    dx = 0
    dy = shooter.speed * (direction == 1 and 1 or -1)
  else
    direction = shooter.flp and 3 or 2
    dy = 0
    dx = shooter.speed * (direction == 2 and 1 or -1)
  end
  add(
    arrows, {
      x = mapx + shooter.x,
      y = mapy + shooter.y,
      dx = dx,
      dy = dy,
      d = direction
    }
  )
  sfx(19, 3)
end

function update_shooters()
  local shooters = get_room_shooters(cur_room_x, cur_room_y)

  for s in all(shooters) do
    if s.active then
      s.delay -= t_increment
      if s.delay <= 0 then
        spawn_arrow(s)
        s.delay = s.timing
      end
    end
  end
end

function update_arrows()
  for arrow in all(arrows) do
    -- move the arrow
    arrow.x += arrow.dx * t_increment
    arrow.y += arrow.dy * t_increment

    if solid(arrow.x, arrow.y) then
      del(arrows, arrow)
    end

    -- collision with player
    if spr_coll(arrow) then
      arrow.stagger = 10
      player_hit()
      del(arrows, arrow)
    end

    -- arrow leaves the screen
    if arrow.x < mapx or arrow.x > mapx + 127 or arrow.y < mapy or arrow.y > mapy + 127 then
      del(arrows, arrow)
    end
  end
end

local adraw = {
  { 117, 48, 3, 8, false, false, 2, -4 }, -- 𝘥𝘰𝘸𝘯 to 𝘶𝘱 -- 𝘥𝘰𝘯𝘦
  { 117, 48, 3, 8, false, true, 2, -6 }, -- 𝘶𝘱 to 𝘥𝘰𝘸𝘯
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