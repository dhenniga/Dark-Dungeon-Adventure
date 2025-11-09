-- rooms
active_objects = {}

f={
  door={door=true,solid=true},
  arch={door_arches=true},
  light={light=true},
  rock={standard_rock=true,solid=true},
  c_rock={cracked_rock=true,solid=true},
  spike={spike_tile=true},
  vase={vase=true,solid=true},
  bat={bat=true},
  rat={rat=true},
  sign={sign=true,interactable=true,solid=true},
  key={key=true,interactable=true},
  flame_b={flames_back=true},
  flame_f={flames_fore=true},
  flame={flames=true},
}

function obj(x,y,fl)return{x=x,y=y,flags=fl}end
function light(x,y,r)return{x=x,y=y,r=r,flags=f.light}end

function door(x,y,flx,fly,solid)
  local o={x=x,y=y,flags={door=true,solid=solid}}
  o.flx=flx o.fly=fly o.flp=flx o.fx=flx o.fy=fly
  return o
end

function arch(x,y,vori,flx,fly)
  local o={x=x,y=y,vori=vori,flags=f.arch}
  o.flx=flx o.fly=fly o.flp=flx o.fx=flx o.fy=fly
  return o
end

function sign(x,y,sprite,txt)return{x=x,y=y,sprite=sprite,text=txt,flags=f.sign}end
function room(x,y,t)room_objects[x.."_"..y]=t end

room_objects={}

room(0,0,{
  {name="CASTLE ENTRANCE",flags={name=true,dungeon=true,zoom=false,rain=false}},
  door(64,0,false,false,true),
  arch(64,0,true,false,false),
  light(56,8,15),light(79,8,15),
  sign(33,5,170,{
    "WELCOME TO THE DARK\nDUNGEONS OF THE SPOOKY\nCASTLE OF NAME. CONTAINED\nWITHIN THESE DANK WALLS ARE\nSECRETS, TRIALS...",
    "...AND TREASURES BEYOND\nYOUR WILDEST IMAGINATION.\n\nARMED ONLY WITH A SWORD AND\nYOUR ELVEN POWER OF...",
    "ILLUMINATION, YOU MUST\nBRAVE THE TERRORS IN THE\nDARK.\nMAY GOD HAVE MERCY\nON YOUR SOUL!"
  }),
  obj(64,64,f.rock),obj(80,64,f.rock),
  obj(16,16,f.flame_b),light(24,20,20),
  obj(96,16,f.flame_b),light(104,20,20),
  arch(64,120,true,true,true),
  door(64,112,false,true,false),
  obj(80,80,f.bat)
})

room(0,1,{
  {name="CASTLE GARDEN STORAGE",flags={name=true,sewer=true,rain=true}},
  door(64,0,false,false,false),
  arch(64,0,true,false,false),
  light(56,8,15),light(87,8,15),
  obj(112,96,f.vase),obj(112,80,f.vase),
  obj(96,96,f.vase),obj(96,80,f.vase),
  obj(20,90,f.bat),obj(100,40,f.rat)
})

room(0,2,{
  arch(64,120,true,false,true),
  obj(16,16,f.flame_b),light(24,20,20),
  obj(96,16,f.flame_b),light(104,20,20),
  obj(16,96,f.flame_f),light(24,100,20),
  obj(96,96,f.flame_f),light(104,100,20)
})

room(0,3,{
  door(64,0,false,false,false),
  arch(64,0,true,false,false),
  light(56,8,15),light(87,8,15),
  obj(32,16,f.flame_f),light(40,20,20),
  obj(80,16,f.flame_f),light(88,20,20),
  sign(18,70,170,{
    "AHEAD LIES YOUR GREATEST\nCHALLENGE SO FAR...\n\n...THE DREADED BOSSNAME",
    "HE'S TOUGH AND FAST BUT HE\nDOESN'T SEE TOO WELL IN\nTHE DARK. THAT COULD MAKE\nALL THE DIFFERENCE."
  })
})

room(1,0,{
  {name="ENTRANCE LOBBY INNER",flags={name=true,dungeon=true}},
  door(112,32,true,false,false),
  light(118,22,15),light(118,52,15),
  arch(120,32,false,true,false),
  obj(32,96,f.rock),obj(96,96,f.rock),
  obj(80,80,f.bat)
})

room(1,1,{
  {name="CASTLE GARDEN STORAGE",flags={name=true,sewer=true,zoom=false,rain=true}},
  door(112,32,true,true,false),
  light(118,22,15),light(118,52,15),
  arch(120,32,false,true,false),
  obj(16,96,f.vase),obj(16,80,f.vase),obj(32,80,f.vase),
  obj(0,80,f.vase),obj(0,96,f.vase),
  obj(96,16,f.vase),obj(96,48,f.vase),
  obj(16,16,f.vase),obj(32,16,f.vase)
})

room(1,2,{
  {name="THE PIT MAZE",flags={name=true,pit=true,zoom=false,rain=false}},
  obj(16,16,{stairs_down=true,solid=true}),

  obj(16,64,f.spike),obj(32,96,f.spike),obj(48,64,f.spike),
    sign(48,5,170,{
    "THREE BUTTONS MUST BE\nPRESSED TO REVEAL THE\nHIDDEN STAIRCASE.\n\nWHERE COULD THEY BE?"
  }),
  obj(100,73,{wall_button=true}),
  -- obj(100,40,f.rat)
})

room(2,0,{
  {name="THE BOTTOMLESS PATHS - WEST",flags={name=true}},
  arch(0,32,false,false,false),
  arch(48,120,true,false,true),
  light(8,22,15),light(8,52,15),
  {x=18,y=100,sprite=254,flags=f.key},
  obj(80,80,f.bat),obj(60,20,f.bat)
})

room(2,1,{
  door(0,32,false,false,false),
  light(8,22,15),light(8,52,15),
  arch(0,32,false,false,false),
  arch(48,0,true,false,false),
  {flags={dungeon=true,zoom=true,rain=false}}
})

room(2,2,{
  {name="THE PIT MAZE",flags={name=true,pit=true,zoom=false,rain=false}},
  obj(20,41,{wall_button=true}),
})

room(3,0,{
  {name="THE BOTTOMLESS PATHS - EAST",flags={name=true}}
})

room(3,1,{
  {name="THE BOTTOMLESS PATHS - SOUTH",flags={name=true,zoom=false}},
  {sprite=13,x=70,y=40,w=2,h=2,flags={chest=true,solid=true,interactable=true}}
})

room(3,2,{
  {name="THE PIT MAZE",flags={name=true,pit=true,zoom=false,rain=false}},
})

room(4,0,{
  {name="RESTING POINT",flags={name=true}},
  door(64,112,false,true,true),
  arch(64,120,true,true,true),
  light(56,120,15),light(87,120,15),
  obj(80,32,f.flame),light(88,36,30),
  obj(80,32,f.flame_b)
})

room(4,1,{
  {name="MYSTERY KEY ROOM",flags={name=true}},
  arch(64,0,true,false,false),
  sign(34,6,170,{
    "THE KEY ON THE TABLE\nUNLOCKS A DOOR ON THIS\nFLOOR...\n\nBUT WHICH ONE?"
  }),
  {x=56,y=64,sprite=254,flags=f.key}
})

room(4,2,{
  {name="THE PIT MAZE",flags={name=true,pit=true,zoom=false,rain=false}},
  obj(84,9,{wall_button=true}),
})

room(4,3,{
  {name="HALL OF SPIKES",flags={name=true,zoom=false}},
  obj(15,95,f.spike),obj(47,79,f.spike),
  obj(63,79,f.spike),obj(95,95,f.spike)
})

room(5,0,{
  obj(32,16,f.rock),
  obj(48,32,f.c_rock),
  obj(64,48,f.rock)
})

room(6,0,{
  {name="OUTER COURTYARD",flags={name=true,sewer=true,rain=true}},
  sign(105,53,170,{
    "THE NEXT ROOM HAS SPIKES\nTHAT SHOOT FROM BOTTOM TO\nTOP. YOU HAVE TO PRESS THE\nBUTTON AT THE TOP TO STOP\nTHE SPIKES AND CLOSE...",
    "THE PITS DOORS."
  }),
  door(80,112,false,true,true),
  arch(80,120,true,true,false),
  light(72,120,15),light(103,120,15)
})

room(6,1,{
  {name="CRUMBLING GROTTO",flags={name=true,dungeon=true,rain=false}},
  obj(80,80,f.flame),light(88,84,30),
  obj(80,80,f.flame_b),
  obj(40,80,f.bat),obj(90,50,f.bat)
})

room(7,0,{
  {name="SPIKES OF DOOM",flags={name=true}},
  obj(20,9,{wall_button=true}),
  obj(68,9,{wall_button=true}),
  obj(116,9,{wall_button=true})
})

room(7,1,{
  {name="MORE CRUMBLING GROTTO",flags={name=true}},
  obj(40,80,f.bat),obj(90,50,f.bat),obj(64,64,f.bat)
})

room(8,1,{
  {name="REALLY CRUMBLING GROTTO",flags={name=true}},
  obj(40,80,f.bat),obj(90,50,f.bat),obj(64,64,f.bat)
})

function door_lights(x,y,fx,fy,flp)
	local flames_anim=flp and {240,241,241,240} or {224,225,225,224}
	local frame_index=flr(time()*(4*t_increment)%4)+1
	local flip=frame_index>2

	if flp then
			spr(flames_anim[frame_index],x+4,y-12,1,1,fx,flip)
			spr(flames_anim[frame_index],x+4,y+20,1,1,fx,flip)
	else
			spr(flames_anim[frame_index],x-12,y+4,1,1,flip,fy)
			spr(flames_anim[frame_index],x+20,y+4,1,1,flip,fy)
	end
end

function normalize_obj_list(t)
  for o in all(t) do
    if o.flx~=nil or o.fly~=nil then
      o.flp=o.flx or false
      o.fx=o.flx or false
      o.fy=o.fly or false
    end
  end
end

function draw_sign_dialog()
  for obj in all(active_objects) do
    local f=obj.flags
    if f.interactable then
      local ox,oy=mapx+obj.x,mapy+obj.y
      local len=abs(ox-p.x)+abs(oy-p.y+6)
      if len<20 and len>0 then
        if f.sign then
          sspr(24,80,5,7,p.x+8,p.y-8)
          if btn(BTN_O) and not reading and val==0 then
            dset(0,flr(p.x)) dset(1,flr(p.y)) dset(2,p.remaining_hearts)
            t_increment=0.05 tb_init(15,obj.text)
          end
        elseif f.key or f.chest then
          sspr(29,80,3,7,p.x+8,p.y-8)
        end
      elseif f.sign then
        reading=false val=0
      end
    end
  end
end

function draw_background_sprites()
  for obj in all(active_objects) do
    local f=obj.flags
    if f.zoom~=nil then zoom_view=f.zoom end
    if f.rain~=nil then raindrops=f.rain end
    if f.quake~=nil then quake=f.quake end
    if f.sewer then palette(sewer)
    elseif f.dungeon then palette(dungeon)
    elseif f.pit then palette(pit) end
    if f.vase then spr(172,mapx+obj.x,mapy+obj.y,2,2) end
    if f.sign then spr(obj.sprite,mapx+obj.x,mapy+obj.y,2,2) end
    if f.key then if not btn(BTN_O) then spr(obj.sprite,mapx+obj.x,mapy+obj.y,2,1) end end
    if f.door then
      if obj.flp then
        spr(168,mapx+obj.x,mapy+obj.y,2,2,obj.fx,obj.fy)
        door_lights(mapx+obj.x,mapy+obj.y,obj.fx,obj.fy,obj.flp)
      else
        spr(128,mapx+obj.x,mapy+obj.y,2,2,obj.fx,obj.fy)
        door_lights(mapx+obj.x,mapy+obj.y,obj.fx,obj.fy,obj.flp)
      end
    end
    if f.chest then spr(obj.sprite,mapx+obj.x,mapy+obj.y,obj.w,obj.h,obj.fx,obj.fy) end
    if f.standard_rock then spr(134,mapx+obj.x,mapy+obj.y,2,2) end
    if f.stairs_down then spr(130,mapx+obj.x,mapy+obj.y,2,2) end
    if f.stairs_up then spr(132,mapx+obj.x,mapy+obj.y,2,2) end
    if f.cracked_rock then spr(136,mapx+obj.x,mapy+obj.y,2,2) end
    if f.spike_tile then animate_spikes(obj) end
    if f.wall_button then spr(95,mapx+obj.x,mapy+obj.y,1,1) end
    if f.flames_back then flames(mapx+obj.x,mapy+obj.y) end
  end
end

function animate_spikes(o)
  local t=flr((time()*t_increment*3)%4)+1
  local f=({78,79,94,79})[t]
  local x,y=mapx+o.x,mapy+o.y
  for i=0,1 do
    for j=0,1 do
      spr(f,x+i*8,y+j*8)
    end
  end
end

function draw_foreground_sprites()
  for obj in all(active_objects) do
    local f=obj.flags
    if f.bat and not obj.spawned then
      add(baddie_m.baddies,new_bat(mapx+obj.x,mapy+obj.y)) obj.spawned=true
    end
    if f.rat and not obj.spawned then
      add(baddie_m.baddies,new_rat(mapx+obj.x,mapy+obj.y)) obj.spawned=true
    end
    if f.blob and not obj.spawned then
      add(baddie_m.baddies,new_blob(mapx+obj.x,mapy+obj.y)) obj.spawned=true
    end
    if f.door_arches then
      if obj.vori then
        if (obj.flp==false) rectfill(mapx+obj.x-4,mapy+obj.y+2,mapx+obj.x+19,mapy+obj.y-6,0)
        if (obj.flp==true) rectfill(mapx+obj.x-4,mapy+obj.y+5,mapx+obj.x+19,mapy+obj.y+13,0)
        spr(49,mapx+obj.x+8,mapy+obj.y,1,1,false,obj.flp)
        spr(49,mapx+obj.x,mapy+obj.y,1,1,true,obj.flp)
      else
        spr(51,mapx+obj.x,mapy+obj.y,1,1,obj.flp,true)
        spr(51,mapx+obj.x,mapy+obj.y+8,1,1,obj.flp,false)
      end
    end
    if f.flames_fore then flames(mapx+obj.x,mapy+obj.y) end
  end
end

function flames(x,y)
  local flame_block_anim={166,167,167,166}
  local frame_index=flr(time()*6*t_increment%#flame_block_anim)+1
  local flip=frame_index>2
  return spr(flame_block_anim[frame_index],x+4,y-8,1,2,flip,false)
end

function get_current_room()
  local room_x=flr(p.x/128)
  local room_y=flr(p.y/128)
  return room_x.."_"..room_y
end

function load_room_objects(room_id)
  active_objects=room_objects[room_id] or {}
  normalize_obj_list(active_objects)
end

local current_room={}

function check_room_change()
  local new_room=get_current_room()
  if new_room~=current_room then
    current_room=new_room
    active_objects={}
    load_room_objects(current_room)
  end
end

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

function draw_flames()
  for obj in all(active_objects) do
    if obj.flags.flames then flames(obj.x,obj.y) end
  end
end
