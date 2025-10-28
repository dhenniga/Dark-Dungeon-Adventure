--inventory code
local inv_timer=0
function draw_inventory()
 for i=1,p.total_hearts do
  local full=p.remaining_hearts>=i
  if zoom_view then
   sspr(full and 96 or 101,8,3,3,p.x+shl(i,2)-32,p.y+29)
  else
   spr(full and 238 or 239,mapx+shl(i,3)-8,mapy+118,1,1)
  end
 end
 if btn(BTN_X) then
  t_increment=0.05
  if inv_timer<50 then inv_timer+=1 end
  if inv_timer==1 then sfx(13) end
  p.dx,p.dy=0,0
  allow_movement=false
  show_inventory()
 else
  t_increment=1
  inv_timer=0
  allow_movement=true
 end
end
item_selected=1
local top_item=0
local bottom_item=0
local left_item=0
local right_item=0
function curr_item()
 if item_selected==1 then spr(207,mapx+8,mapy+4,1,2) end
 if item_selected==4 then spr(72,mapx+4,mapy+4,2,2) end
end
function p4bonus(s,x,y,c,o)
 color(o)
 ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
 ?s,x,y,c
end
function show_inventory()
 for obj in all(active_objects) do
  if obj.flags.name and not reading then
   p4bonus(obj.name,mapx,mapy+112,11,0)
  end
 end
 local dirs={BTN_U,BTN_D,BTN_L,BTN_R}
 for i=1,4 do
  if btnp(dirs[i]) then item_selected=i sfx(11,3) end
 end
 local pos={{p.x+2,p.y-20},{p.x+2,p.y+20},{p.x-19,p.y},{p.x+23,p.y}}
 for i=1,4 do
  fillp(0x0000)
  circfill(pos[i][1],pos[i][2],outelastic(inv_timer,0,10+(item_selected==i and 7 or 0),50),item_selected==i and 7 or 0)
 end
 fillp(0x0000)
 circfill(p.x+2,p.y,outelastic(inv_timer,0,25,25),5)
 circ(p.x+2,p.y,outelastic(inv_timer,0,25,25),0)
 spr(192,p.x-4,p.y-8,2,2,p.direction)
 if p.keys==1 then
  fillp(█)
  circfill(mapx+121,mapy+6,6,3)
  spr(206,mapx+118,mapy+3,1,1)
 end
 fillp(0x0000)
 circfill(p.x+2,p.y-20,outelastic(inv_timer,0,9,50),5)
 spr(207,p.x-1,outelastic(inv_timer,p.y,-25,25),1,2)
 fillp(0x0000)
 circfill(p.x+23,p.y,outelastic(inv_timer,0,9,50),5)
 spr(72,outelastic(inv_timer,p.x,16,25),p.y-8,2,2)
 fillp(0x0000)
 circfill(p.x+2,p.y+20,outelastic(inv_timer,0,9,50),5)
 fillp(0x0000)
 circfill(p.x-19,p.y,outelastic(inv_timer,0,9,50),5)
end