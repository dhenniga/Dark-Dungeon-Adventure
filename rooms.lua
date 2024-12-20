-- rooms
active_objects = {}

--

room_objects = {
  ["0_0"] = {
    {x=64, y=0,flp=false,flags={door=true, solid=true}}, --doortop
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top
    {x=56,y=8,r=15,flags={light=true}},{x=79,y=8,r=15,flags={light=true}}, --side lights
    
    --{x=64, y=112,flp=false,fy=1,flags={door=true, solid=true}}, --doorbottom
    {x=64,y=120,vori=true,flp=true,flags={door_arches=true}}, --door arch bottom
    {x=56,y=120,r=15,flags={light=true}},{x=79,y=120,r=15,flags={light=true}}, --side lights
    
    {x=33,y=5,sprite=170,text={
      "WELCOME TO THE DARK\nDUNGEONS OF THE SPOOKY\nCASTLE OF NAME. CONTAINED\nWITHIN THESE DANK WALLS ARE\nSECRETS, TRIALS...",
      "...AND TREASURES BEYOND\nYOUR WILDEST IMAGINATION.\n\nARMED ONLY WITH A SWORD AND\nYOUR ELVEN POWER OF...",
      "ILLUMINATION, YOU MUST\nBRAVE THE TERRORS IN THE\nDARK.\nMAY GOD HAVE MERCY\nON YOUR SOUL!"},
    flags={sign=true, interactable=true, solid=true}}, --sign

    --Flames
    {x=16, y=16,flags={flames=true}},{x=16+8,y=16+4,r=20,flags={light=true}},
    {x=96, y=16,flags={flames=true}},{x=96+8,y=16+4,r=20,flags={light=true}},
 
    --Baddies
    {x=80,y=80,flags={bat=true}},-- Bat

    {flags={dungeon=true}},

  },
  ["0_1"] = {
    {x=64,y=0,flp=false,flags={door=true}}, --doortop
    {x=56,y=8,r=15,flags={light=true}},{x=87,y=8,r=15,flags={light=true}},
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top

    {x=112,y=96,flags={vase=true, solid=true}},
    {x=112,y=80,flags={vase=true, solid=true}},
    {x=96,y=96,flags={vase=true, solid=true}},
    {x=96,y=80,flags={vase=true, solid=true}},
  
    {x=20,y=90,flags={bat=true}}, -- Bat
    -- {x=100,y=40,flags={rat=true}}, -- Rat

    {flags={sewer=true}},

  },
  ["0_2"] = {
    {x=64,y=120,vori=true,flp=true,flags={door_arches=true}}, --door arch bottom
    {x=16, y=16,flags={flames=true}},{x=16+8,y=16+4,r=20,flags={light=true}}, -- flame block
    {x=96, y=16,flags={flames=true}},{x=96+8,y=16+4,r=20,flags={light=true}}, -- flame block
    {x=16, y=96,flags={flames=true}},{x=16+8,y=96+4,r=20,flags={light=true}}, -- flame block
    {x=96, y=96,flags={flames=true}},{x=96+8,y=96+4,r=20,flags={light=true}}, -- flame block
  },
  ["0_3"] = {
    {x=64,y=0,flp=false,flags={door=true}}, --doortop
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top
    {x=56,y=8,r=15,flags={light=true}},{x=87,y=8,r=15,flags={light = true}}, --side lights

    {x=32, y=16,flags={flames=true}},{x=32+8,y=16+4,r=20,flags={light=true}}, -- flame block
    {x=80, y=16,flags={flames=true}},{x=80+8,y=16+4,r=20,flags={light=true}}, -- flame block
    {x=18,y=70,sprite=170,text={"AHEAD LIES YOUR GREATEST\nCHALLENGE SO FAR...\n\n...THE DREADED BOSSNAME","HE'S TOUGH AND FAST BUT HE\nDOESN'T SEE TO WELL IN\nTHE DARK.  THAT COULD MAKE\nALL THE DIFFERENCE."},flags={sign=true, interactable=true}}, --sign

  },
  ["1_0"] = {
    {x=112,y=32,flp=true,flags={door=true, solid=true}}, --doorright
    {x=118,y=22,r=15,flags={light=true}},{x=118,y=52,r=15,flags={light = true}}, --lights
    {x=120,y=32,vori=false,flp=true,flags={door_arches=true}}, --door arch
  },
  ["1_1"] = {
    {x=112,y=32,flp=true,flags={door=true}}, --doorright
    {x=118,y=22,flp=true,r=15,flags={light=true}},{x=118,y=52,r=15,flags={light = true}}, --lights
    {x=120,y=32,vori=false,flp=true,flags={door_arches=true}}, --door arch

    {x=16,y=96,flags={vase=true, solid=true}},
    {x=16,y=80,flags={vase=true, solid=true}},
    {x=32,y=80,flags={vase=true, solid=true}},
    {x=0,y=80,flags={vase=true, solid=true}},
    {x=0,y=96,flags={vase=true, solid=true}},

    {flags={sewer=true}},
  },
  ["1_2"] = {
      {x = 24, y = 24, sprite = 18, flags = {interactable = true}}
  },
  ["2_0"] = {
    {x=0,y=32,vori=false,flp=false,flags={door_arches=true}}, --door arch
    {x=48,y=120,vori=true,flp=true,flags={door_arches=true}}, --door arch bottom
    {x=18,y=100,sprite=254,flags={key=true, interactable=true}} -- key

  },
  ["2_1"] = {
    {x=0,y=32,flp=true,fx=true,flags={door=true}}, --doorleft
    {x=8,y=22,r=15,flags={light=true}},{x=8,y=52,r=15,flags={light = true}}, --lights
    {x=0,y=32,vori=false,flp=false,flags={door_arches=true}}, --door arch

    {x=48,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top

    {flags={dungeon=true}},


  },
  ["3_1"] = {
    {sprite=13, x=50,y=40,w=2,h=2, flags={chest=true}}
  },
  ["4_0"] = {
    {x=64, y=112,flp=false,fy=1,flags={door=true}}, --doorbottom
    {x=64,y=120,vori=true,flp=true,flags={door_arches=true}}, --door arch bottom
    {x=56,y=120,r=15,flags={light=true}},{x=87,y=120,r=15,flags={light=true}}, --side lights

    {x=80, y=32,flags={flames=true}},{x=80+8,y=32+4,r=30,flags={light=true}}, -- flame block
  },
  ["4_1"] = {
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch bottom
    {x=34,y=6,sprite=170,text={"THE KEY ON THE TABLE\nUNLOCKS A DOOR ON THIS\nFLOOR...\n\nBUT WHICH ONE?"},flags={sign=true, interactable=true}}, --sign
    {x=56,y=64,sprite=254,flags={key=true, interactable=true}} -- key

  }
}

--

function draw_sign_dialog()
  for obj in all(active_objects) do
    if obj.flags.interactable then
      
      if obj.flags.sign then
        local len = abs(mapx+obj.x-p.x)+abs(mapy+obj.y-p.y+6)
          
        if len<20 and len>0 then
          sspr(24,80,5,7,p.x+8,p.y-8)
          if btn(BTN_O) and reading==false and val==0 then
            dset(0, flr(p.x))
            dset(1, flr(p.y))
            t_increment=0.05		
            tb_init(14,obj.text)
          end
        else
          reading=false
          val=0
        end
      end

      if obj.flags.key then
        local len = abs(mapx+obj.x-p.x)+abs(mapy+obj.y-p.y+6)
        if len<20 and len>0 then
          sspr(29,80,3,7,p.x+8,p.y-8)
        end
      end

    end
  end
end


function draw_background_sprites()
  for obj in all(active_objects) do

    if obj.flags.sewer then
     pallette(sewer)
    end

    if obj.flags.dungeon then
      pallette(dungeon)
     end

    if obj.flags.vase then 
      spr(172,mapx+obj.x,mapy+obj.y,2,2)
    end
    
    if obj.flags.sign then
      spr(obj.sprite,mapx+obj.x,mapy+obj.y,2,2)
    end

    if obj.flags.key then
      if not btn(BTN_O) then
      spr(obj.sprite,mapx+obj.x,mapy+obj.y,2,1)
      end
    end

    if obj.flags.door then
      if obj.flp then
        spr(168,mapx+obj.x, mapy+obj.y,2,2,obj.fx, obj.fy)
        door_lights(mapx+obj.x,mapy+obj.y,obj.fx,obj.fy,obj.flp)
      else
        spr(128, mapx+obj.x, mapy+obj.y,2,2, obj.fx, obj.fy)
        door_lights(mapx+obj.x,mapy+obj.y,obj.fx,obj.fy,obj.flp)
      end
    end

    if obj.flags.chest then
      spr(obj.sprite, mapx+obj.x, mapy+obj.y, obj.w, obj.h, obj.fx, obj.fy)
    end

    --

  end
end

--

function draw_foreground_sprites()
  for obj in all(active_objects) do

    -- Baddies - Bat
    if obj.flags.bat and not obj.spawned then
      add(baddie_m.baddies, new_bat(mapx+obj.x, mapy+obj.y))
      obj.spawned=true
    end

    -- Baddies - Rat
    if obj.flags.rat and not obj.spawned then
      add(baddie_m.baddies, new_rat(mapx+obj.x, mapy+obj.y))
      obj.spawned=true
    end

    -- Baddies - Blob
    if obj.flags.blob and not obj.spawned then
      add(baddie_m.baddies, new_blob(mapx+obj.x, mapy+obj.y))
      obj.spawned=true
    end

    -- Door Arches
    if obj.flags.door_arches then
      if obj.vori then
        spr(49,mapx+obj.x+8,mapy+obj.y,1,1,false,obj.flp)
        spr(12,mapx+obj.x,mapy+obj.y,1,1,false,obj.flp)
      else
        spr(28,mapx+obj.x,mapy+obj.y,1,1,obj.flp,false)
        spr(51,mapx+obj.x,mapy+obj.y+8,1,1,obj.flp,false)
      end
    end

    --

    -- Flames
    if obj.flags.flames then
      flames(mapx+obj.x,mapy+obj.y) 
    end
  end
end

--

function flames(x,y) 
	local flame_block_anim={166,167,167,166}
 local frame_index=flr(time()*6*t_increment%#flame_block_anim)+1
 local flip = frame_index>2
 return spr(flame_block_anim[frame_index],x+4,y-8,1,2,flip,false)
end

--

function get_current_room()
  local room_x = flr(p.x / 128)
  local room_y = flr(p.y / 128)
  return room_x .. "_" .. room_y
end

--

function load_room_objects(room_id)
    active_objects = room_objects[room_id] or {} -- Load objects or default to empty
end

--

local current_room = {}

function check_room_change()
  local new_room = get_current_room()
  if new_room ~= current_room then
      current_room = new_room
      active_objects={}
      load_room_objects(current_room)
  end
end

--
 
function draw_torch_light()
  for obj in all(active_objects) do
      if obj.flags.light then
        fillp(░)
        circfill(mapx+obj.x,mapy+obj.y,obj.r+rnd(3)+10,14)
        fillp(▒)
        circfill(mapx+obj.x,mapy+obj.y,obj.r+rnd(3)+6,14) 
        fillp(0x0000)
        circfill(mapx+obj.x,mapy+obj.y,obj.r+rnd(3)+3,14)  
      end
  end
end

--

function draw_flames()
  for obj in all(active_objects) do
      if obj.flags.flames then
        flames(obj.x,obj.y) 
      end
  end
end

--
