-- rooms
active_objects = {}

--

room_objects = {
  ["0_0"] = {
    {name="CASTLE ENTRANCE", flags={name=true}},   
    {x=64, y=0,flp=false,flags={door=true, solid=true}}, --doortop
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top
    {x=56,y=8,r=15,flags={light=true}},{x=79,y=8,r=15,flags={light=true}}, --side lights
    
    -- {x=64, y=112,flp=false,fy=1,flags={door=true, solid=true}}, --doorbottom
    {x=64,y=120,vori=true,flp=true,flags={door_arches=true, exit_room=true}}, --door arch bottom
    -- {x=56,y=120,r=15,flags={light=true}},{x=79,y=120,r=15,flags={light=true}}, --side lights
    
    {x=33,y=5,sprite=170,text={
      "WELCOME TO THE DARK\nDUNGEONS OF THE SPOOKY\nCASTLE OF NAME. CONTAINED\nWITHIN THESE DANK WALLS ARE\nSECRETS, TRIALS...",
      "...AND TREASURES BEYOND\nYOUR WILDEST IMAGINATION.\n\nARMED ONLY WITH A SWORD AND\nYOUR ELVEN POWER OF...",
      "ILLUMINATION, YOU MUST\nBRAVE THE TERRORS IN THE\nDARK.\nMAY GOD HAVE MERCY\nON YOUR SOUL!"},
    flags={sign=true, interactable=true, solid=true}}, --sign

    {x=64,y=64,flags={standard_rock=true, solid=true}},
    {x=80,y=64,flags={standard_rock=true, solid=true}},

    --Flames
    {x=16, y=16,flags={flames=true}},{x=16+8,y=16+4,r=20,flags={light=true}},
    {x=96, y=16,flags={flames=true}},{x=96+8,y=16+4,r=20,flags={light=true}},
 
    --Baddies
    {x=80,y=80,flags={bat=true}},-- Bat

    {flags={dungeon=true, zoom=false, rain=false}},

  },
  ["0_1"] = {
    {name="CASTLE GARDEN STORAGE", flags={name=true}},
    -- {x=64,y=0,flp=false,flags={door=true}}, --doortop
    -- {x=56,y=8,r=15,flags={light=true}},{x=87,y=8,r=15,flags={light=true}},
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top

    {x=112,y=96,flags={vase=true, solid=true}},
    {x=112,y=80,flags={vase=true, solid=true}},
    {x=96,y=96,flags={vase=true, solid=true}},
    {x=96,y=80,flags={vase=true, solid=true}},
  
    {x=20,y=90,flags={bat=true}}, -- Bat
    {x=100,y=40,flags={rat=true}}, -- Rat

    {flags={sewer=true, rain=true}},

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
    {name="ENTRANCE LOBBY INNER", flags={name=true}},
    -- {x=112,y=32,flp=true,flags={door=true, solid=true}}, --doorright
    {x=118,y=22,r=15,flags={light=true}},{x=118,y=52,r=15,flags={light = true}}, --lights
    {x=120,y=32,vori=false,flp=true,flags={door_arches=true}}, --door arch

    {x=32,y=96,flags={standard_rock=true, solid=true}},
    {x=96,y=96,flags={standard_rock=true, solid=true}},

        --Baddies
        {x=80,y=80,flags={bat=true}},-- Bat

  },
  ["1_1"] = {
    {name="CASTLE GARDEN STORAGE", flags={name=true}},
    {x=112,y=32,flp=true,flags={door=true}}, --doorright
    {x=118,y=22,flp=true,r=15,flags={light=true}},{x=118,y=52,r=15,flags={light = true}}, --lights
    {x=120,y=32,vori=false,flp=true,flags={door_arches=true}}, --door arch

    {x=16,y=96,flags={vase=true, solid=true}},
    {x=16,y=80,flags={vase=true, solid=true}},
    {x=32,y=80,flags={vase=true, solid=true}},
    {x=0,y=80,flags={vase=true, solid=true}},
    {x=0,y=96,flags={vase=true, solid=true}},

    {x=96,y=16,flags={vase=true, solid=true}},
    {x=96,y=48,flags={vase=true, solid=true}},

    {x=16,y=16,flags={vase=true, solid=true}},
    {x=32,y=16,flags={vase=true, solid=true}},

    -- {x=100,y=40,flags={rat=true}}, -- Rat

    {flags={sewer=true, zoom=false, rain=true}},
  },
  ["1_2"] = {
      {name="THE PIT MAZE", flags={name=true, pit=true, zoom=false, rain=false}},

      {x=16,y=16,flags={stairs_down=true, solid=true}},

      {x=32,y=16,flags={standard_rock=true, solid=true}},
      {x=32,y=32,flags={standard_rock=true, solid=true}},
      {x=32,y=48,flags={standard_rock=true, solid=true}},
      {x=32,y=64,flags={standard_rock=true, solid=true}},
      {x=32,y=80,flags={standard_rock=true, solid=true}},

      {x=16,y=64,flags={spike_tile=true}},
      {x=32,y=96,flags={spike_tile=true}},
      {x=48,y=64,flags={spike_tile=true}},

      {x=64,y=16,flags={cracked_rock=true, solid=true}},
      {x=64,y=32,flags={standard_rock=true, solid=true}},
      {x=64,y=48,flags={standard_rock=true, solid=true}},
      {x=64,y=64,flags={standard_rock=true, solid=true}},
      {x=64,y=80,flags={standard_rock=true, solid=true}},
      {x=64,y=96,flags={standard_rock=true, solid=true}},

      {x=100,y=40,flags={rat=true}}, -- Rat

      -- {x=16,y=96,flags={vase=true, solid=true}},
  },
  ["2_0"] = {
    {name="THE BOTTOMLESS PATHS - WEST", flags={name=true}},
    {x=0,y=32,vori=false,flp=false,flags={door_arches=true}}, --door arch
    {x=48,y=120,vori=true,flp=true,flags={door_arches=true}}, --door arch bottom
    {x=18,y=100,sprite=254,flags={key=true, interactable=true}}, -- key

    --Baddies
    {x=80,y=80,flags={bat=true}},-- Bat
    {x=60,y=20,flags={bat=true}},-- Bat
  },
  ["2_1"] = {
    {x=0,y=32,flp=true,fx=true,flags={door=true}}, --doorleft
    {x=8,y=22,r=15,flags={light=true}},{x=8,y=52,r=15,flags={light = true}}, --lights
    {x=0,y=32,vori=false,flp=false,flags={door_arches=true}}, --door arch

    {x=48,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch top

    {flags={dungeon=true, zoom=true, rain=false}},


  },
  ["3_0"] = {
    {name="THE BOTTOMLESS PATHS - EAST", flags={name=true}},
  },
  ["3_1"] = {
    {name="THE BOTTOMLESS PATHS - SOUTH", flags={name=true, zoom=false}},
    {sprite=13, x=70,y=40,w=2,h=2, flags={chest=true, solid=true, interactable={true}}}
  },
  ["4_0"] = {
    {x=64, y=112,flp=false,fy=1,flags={door=true}}, --doorbottom
    {x=64,y=120,vori=true,flp=true,flags={door_arches=true}}, --door arch bottom
    {x=56,y=120,r=15,flags={light=true}},{x=87,y=120,r=15,flags={light=true}}, --side lights

    {x=80, y=32,flags={flames=true}},{x=80+8,y=32+4,r=30,flags={light=true}}, -- flame block
  },
  ["4_1"] = {
    {name="MYSTERY KEY ROOM", flags={name=true}},
    {x=64,y=0,vori=true,flp=false,flags={door_arches=true}}, --door arch bottom
    {x=34,y=6,sprite=170,text={"THE KEY ON THE TABLE\nUNLOCKS A DOOR ON THIS\nFLOOR...\n\nBUT WHICH ONE?"},flags={sign=true, solid=true, interactable=true}}, --sign
    {x=56,y=64,sprite=254,flags={key=true, interactable=true}} -- key
  },
  ["4_3"] = {
    {name="HALL OF SPIKES", flags={name=true, zoom=false}},
    {x=15, y=95,flp=false,flags={spike_tile=true, solid=false}}, --spike tile
    {x=47, y=79,flp=false,flags={spike_tile=true, solid=false}}, --spike tile
    {x=63, y=79,flp=false,flags={spike_tile=true, solid=false}}, --spike tile
    {x=95, y=95,flp=false,flags={spike_tile=true, solid=false}}, --spike tile
  },
  ["5_0"] = {
    {x=32,y=16,flags={standard_rock=true, solid=true}},
    {x=48,y=32,flags={cracked_rock=true,solid=true}},
    {x=64,y=48,flags={standard_rock=true,solid=true}},
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
            dset(2, p.remaining_hearts)
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

      if obj.flags.chest then
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

    local f = obj.flags

    if f.zoom ~= nil then zoom_view = f.zoom end
    if f.rain ~= nil then raindrops = f.rain end

    if f.sewer then
      palette(sewer)
    elseif f.dungeon then
      palette(dungeon)
    elseif f.pit then
      palette(pit)
    end

    if f.vase then 
      spr(172,mapx+obj.x,mapy+obj.y,2,2)
    end
    
    if f.sign then
      spr(obj.sprite,mapx+obj.x,mapy+obj.y,2,2)
    end

    if f.key then
      if not btn(BTN_O) then
        spr(obj.sprite,mapx+obj.x,mapy+obj.y,2,1)
      end
    end

    if f.door then
      if obj.flp then
        spr(168,mapx+obj.x, mapy+obj.y,2,2,obj.fx, obj.fy)
        door_lights(mapx+obj.x,mapy+obj.y,obj.fx,obj.fy,obj.flp)
      else
        spr(128, mapx+obj.x, mapy+obj.y,2,2, obj.fx, obj.fy)
        door_lights(mapx+obj.x,mapy+obj.y,obj.fx,obj.fy,obj.flp)
      end
    end

    if f.chest then
      spr(obj.sprite, mapx+obj.x, mapy+obj.y, obj.w, obj.h, obj.fx, obj.fy)
    end

    --

    if f.standard_rock then
      spr(134,mapx+obj.x,mapy+obj.y,2,2)
    end

    --

    if f.stairs_down then
      spr(130,mapx+obj.x,mapy+obj.y,2,2)
    end

    if f.stairs_up then
      spr(132,mapx+obj.x,mapy+obj.y,2,2)
    end

    --

    if f.cracked_rock then
      spr(136,mapx+obj.x,mapy+obj.y,2,2)
    end

    if f.spike_tile then
      animate_spikes(obj)
    end

  end
end

--

function animate_spikes(o)
  local t = flr((time()*t_increment*3) % 4) + 1
  local f = ({78,79,94,79})[t]
  local x,y = mapx+o.x, mapy+o.y
  for i=0,1 do
    for j=0,1 do
      spr(f,x+i*8,y+j*8)
    end
  end
end


--

function draw_foreground_sprites()
  for obj in all(active_objects) do

    local f = obj.flags

    -- Baddies - Bat
    if f.bat and not obj.spawned then
      add(baddie_m.baddies, new_bat(mapx+obj.x, mapy+obj.y))
      obj.spawned=true
    end

    -- Baddies - Rat
    if f.rat and not obj.spawned then
      add(baddie_m.baddies, new_rat(mapx+obj.x, mapy+obj.y))
      obj.spawned=true
    end

    -- Baddies - Blob
    if f.blob and not obj.spawned then
      add(baddie_m.baddies, new_blob(mapx+obj.x, mapy+obj.y))
      obj.spawned=true
    end


    -- Door Arches
    if obj.flags.door_arches then
      if obj.vori then
          if (obj.flp==false) rectfill(mapx+obj.x-4,mapy+obj.y+2,mapx+obj.x+19,mapy+obj.y-6,0)
        if (obj.flp==true) rectfill(mapx+obj.x-4,mapy+obj.y+5,mapx+obj.x+19,mapy+obj.y+13,0) 
        spr(49,mapx+obj.x+8,mapy+obj.y,1,1,false,obj.flp)
        spr(49,mapx+obj.x,mapy+obj.y,1,1,true,obj.flp)
      else
        --SIDE ONES
        -- if (obj.flp==true) rectfill(mapx+obj.x+8,mapy+obj.y-16,mapx+obj.x+16,mapy+obj.y+8,9)
        -- if (obj.flp==false) rectfill(mapx+obj.x+8,mapy+obj.y-16,mapx+obj.x+16,mapy+obj.y,10)
        spr(51,mapx+obj.x,mapy+obj.y,1,1,obj.flp,true)
        spr(51,mapx+obj.x,mapy+obj.y+8,1,1,obj.flp,false)
      end
    end

    -- Flames
    if obj.flags.flames then
      flames(mapx+obj.x,mapy+obj.y) 
    end
  end



end

function draw_screen_wipe()
  for obj in all(active_objects) do
    if obj.flags.exit_room and p.y>obj.y then
      poke(0x5f34,0x2)
      if radius_thing>0 then
        for i=1,3 do
          radius_thing-=1*t_increment
          circfill(obj.x,obj.y,radius_thing,0|0x1800)
          if radius_thing==0 then radius_thing=128 end
        end
      end
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
    active_objects = room_objects[room_id] or {}
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
