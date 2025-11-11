--inv
local it=0
item_selected=1
function draw_inventory()
 for i=1,p.total_hearts do
  local f=p.remaining_hearts>=i
  if zoom_view then
   sspr(f and 96 or 101,8,3,3,p.x+shl(i,2)-32,p.y+29)
  else
   spr(f and 238 or 239,mapx+shl(i,3)-8,mapy+118,1,1)
  end
 end
 if btn(BTN_X) then
  t_increment=.05
  if it<50 then it+=1 end
  if it==1 then sfx(12,3) end
  p.dx,p.dy=0,0 allow_movement=false
  show_inventory()
 else
  t_increment=1 it=0 allow_movement=true
 end
end
function curr_item()
 if item_selected==1 then spr(207,mapx+8,mapy+4,1,2)
 elseif item_selected==4 then spr(72,mapx+4,mapy+4,2,2) end
end
function pb(s,x,y,c,o)
 color(o)
 ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
 ?s,x,y,c
end
function show_inventory()
 for o in all(active_objects)do
  if o.flags.name and not reading then pb(o.name,mapx,mapy+112,11,0)end
 end
 local d={BTN_U,BTN_D,BTN_L,BTN_R}
 for i=1,4 do if btnp(d[i])then item_selected=i sfx(10,3)end end
 local pos={{p.x+2,p.y-20},{p.x+2,p.y+20},{p.x-19,p.y},{p.x+23,p.y}}
 local outs={}
 for i=1,4 do outs[i]=outelastic(it,0,10+(item_selected==i and 7 or 0),50)end
 local big=outelastic(it,0,25,25)
 local knob=outelastic(it,0,9,50)
 fillp(0x0000)
 for i=1,4 do
  circfill(pos[i][1],pos[i][2],outs[i],item_selected==i and 7 or 0)
 end
 circfill(p.x+2,p.y,big,5)
 circ(p.x+2,p.y,big,0)
 spr(192,p.x-4,p.y-8,2,2,p.direction)
if p.keys>0 then
 for i=1,min(p.keys,5) do
  local x=mapx+121-(i-1)*13
  fillp(█)
  circfill(x,mapy+6,6,3)
  spr(206,x-3,mapy+3)
 end
end

 circfill(p.x+2,p.y-20,knob,5)
 spr(207,p.x-1,outelastic(it,p.y,-25,25),1,2)
 circfill(p.x+23,p.y,knob,5)
 spr(72,outelastic(it,p.x,16,25),p.y-8,2,2)
 circfill(p.x+2,p.y+20,knob,5)
 circfill(p.x-19,p.y,knob,5)
end
