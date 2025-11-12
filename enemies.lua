-- enemies (minified)

function angle_between(a,b)
 return({[0]=2,1,3,0})[flr(atan2(b.y-a.y,b.x-a.x)*3.8197)]or 0
end

function nb(fr,x,y,fly)
 return{fr=fr,x=x,y=y,dx=0,dy=0,w=8,h=8,can_fly=fly or false,prox=.2,angle=0,
 speed=.5,att_speed=.9,direction=3,state="init",ttl=0}
end
function new_bat(x,y)return nb({236,234,232},x,y,true)end
function new_rat(x,y)return nb({228,230},x,y)end
function new_blob(x,y)return nb({226},x,y)end

baddie_m={baddies={}}

function baddie_m.update()
 for i=1,#baddie_m.baddies do
  local b=baddie_m.baddies[i]
  if b and b.x>=mapx and b.x<=mapx+127 and b.y>=mapy and b.y<=mapy+127 then
   baddie_update(b)
  end
 end
end

function baddie_m.draw()
 for i=1,#baddie_m.baddies do
  local b=baddie_m.baddies[i]
  if b and b.x>=mapx and b.x<=mapx+127 and b.y>=mapy and b.y<=mapy+127 then
   baddie_draw(b)
  end
 end
end

frb=1
function baddie_draw(b)
 local dir=b.direction==0
 frb=frb<#b.fr+.9 and frb+.1*t_increment or 1
 spr(b.fr[flr(frb)],b.x-4,b.y-4,2,2,dir)
end

function baddie_update(b)
 b.ttl-=1
 local f=b.can_fly and flying_enemy_can_move or ground_enemy_can_move
 if not f(b)then
  b.direction=(b.direction+2)%4
  move_dir(b,b.speed)
  b.state="bounce"
 else
  b.x+=b.dx*t_increment
  b.y+=b.dy*t_increment
 end

 -- 🔸 Screen-edge bounce
 if b.x<mapx or b.x>mapx+120 or b.y<mapy or b.y>mapy+120 then
  b.direction=(b.direction+2)%4
  move_dir(b,b.speed)
  b.x=mid(mapx+4,b.x,mapx+124)
  b.y=mid(mapy+4,b.y,mapy+124)
 end

 if sprite_collision(p,b)then q.add_event"collision"end
 if b.ttl<=0 then
  if sees(b,l_rad*1.5,0,1,1,0)then
   b.state="attack"
   for i=0,2 do
    sset(76+i*16,119-i,3)sset(74+i*16,120-i,3)
   end
   b.direction=angle_between(p,b)
   move_dir(b,b.att_speed)
  elseif rnd()>.2 then
   b.state="walk"
   for i=0,2 do
    sset(76+i*16,119-i,9)sset(74+i*16,120-i,9)
   end
   b.ttl=ceil(rnd(120)+30)
   b.direction=flr(rnd(4))
   move_dir(b,b.speed)
  else
   b.state="stop"
   b.dx,b.dy=0,0
   b.ttl=ceil(rnd(150)+15)
  end
 end
end


function move_dir(b,s)
 if b.direction==0 then b.dx=-s b.dy=0
 elseif b.direction==1 then b.dx=s b.dy=0
 elseif b.direction==2 then b.dx=0 b.dy=-s
 else b.dx=0 b.dy=s end
end
