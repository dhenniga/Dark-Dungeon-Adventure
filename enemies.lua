-- enemies

function angle_between(pl,b)
	local res=flr(atan2(b.y-pl.y,b.x-pl.x)*12/3.1415926535)
	if (res==0) return 2
	if (res==1) return 1
	if (res==2) return 3
	if (res==3) return 0
	return res
end

-----------------------------------------

-- frb=1
-- function bat(x,y,d)
-- 	local f_bat={236,234,232}
--   local dir=false
--   if (d==1) dir=false
--   if (d==0) dir=true
-- 	if frb<3.8 then frb=frb+0.10*t_increment else frb=1 end	
-- 	-- if (frb>3 and frb<3.1) sfx(12,2)
-- 	-- spr(162,x,y,1,1,dir)
--   spr(f_bat[flr(frb)],x,y,2,2,dir)
-- end

-----------------------------------------

frr=1
function rat(x,y,d)
	local f_rat={228,230}
  local dir=false
  if (d==1) dir=false
  if (d==0) dir=true
	if frr<2.8 then frr=frr+0.1*t_increment else frr=1 end
	spr(f_rat[flr(frr)],x,y,2,2,dir)
end

-----------------------------------------

function blob(x,y,d)
	spr(226,x,y,2,2,d)
end

-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------
-----------------------------------------

function new_bat(x,y)
  return {
    fr={236,234,232},
    x=x,
    y=y,
    dx=0,
    dy=0,
    w=8,
    h=8,
    can_fly=true,
    prox=0.2,
    angle=0,
    speed=0.5,
    att_speed=0.9,
    direction=3,
    state="init",
    ttl=0,
  }
end

function new_rat(x,y)
  return {
    fr={228,230},
    x=x,
    y=y,
    dx=0,
    dy=0,
    w=8,
    h=8,
    can_fly=false,
    prox=0.2,
    angle=0,
    speed=0.5,
    att_speed=0.9,
    direction=3,
    state="init",
    ttl=0,
  }
end

function new_blob(x,y)
  return {
    fr={226},
    x=x,
    y=y,
    dx=0,
    dy=0,
    w=8,
    h=8,
    can_fly=false,
    prox=0.2,
    angle=0,
    speed=0.5,
    att_speed=0.9,
    direction=3,
    state="init",
    ttl=0,
  }
end

baddie_m={
  baddies={}
}


baddie_m.update = function()
  foreach(baddie_m.baddies, function(b) baddie_update(b) end)
end

baddie_m.draw = function()
  foreach(baddie_m.baddies, function(b) 
    baddie_draw(b) 
  end)
end

baddie_m.map = function()
  foreach(baddie_m.baddies, function(b) 
    if b.state=="ATTACK" then
    place_on_map(b,3)
    else
      place_on_map(b,14)
    end
  end)
end


frb=1
function baddie_draw(b)
    local dir=false
    if (b.direction==1) dir=false
    if (b.direction==0) dir=true

    if frb<#b.fr+0.9 then frb=frb+0.10*t_increment else frb=1 end	
    spr(b.fr[flr(frb)],b.x-4,b.y-4,2,2,dir)

end

function baddie_update(b)
  b.ttl-=1

  local new_x, new_y = b.x,b.y
  new_x += b.dx*t_increment
  new_y += b.dy*t_increment

  local can_move_func = b.can_fly and flying_enemy_can_move or ground_enemy_can_move
  
  if not can_move_func(b) then
    if b.direction==BTN_R then
      b.direction=BTN_L
      left(b,b.speed)
    elseif b.direction == BTN_L then
      b.direction=BTN_R
      right(b,b.speed)
    elseif b.direction==BTN_U then
      b.direction=BTN_D
      down(b,b.speed)
    elseif b.direction==BTN_D then
      b.direction=BTN_U
      up(b,b.speed)
    end
    b.state="BOUNCE"
  else
    b.x+=b.dx*t_increment
    b.y+=b.dy*t_increment
  end

 	-- if sprite_collision(p, b) then
	-- 	q.add_event("collision")
	-- end
  
  
  if b.ttl<=0 then
    if sees(b,l_rad*1.5,0,1,1,0) then
      b.state="ATTACK"
      sset(76,119,3)
      sset(74,120,3)
      sset(92,118,3)
      sset(90,119,3)
      sset(108,117,3)
      sset(106,118,3)

      b.direction=angle_between(p,b)
      if b.direction==BTN_U then
          up(b,b.att_speed)
        elseif b.direction==BTN_D then
          down(b,b.att_speed)
        elseif b.direction==BTN_R then
          right(b,b.att_speed)
        elseif b.direction==BTN_L then
          left(b,b.att_speed)
      end
  
    elseif rnd()>0.2 then
    b.state="WALK"
    sset(76,119,9)
    sset(74,120,9)
    sset(92,118,9)
    sset(90,119,9)
    sset(108,117,9)
    sset(106,118,9)
    b.ttl=ceil(rnd(120)+30)
    b.direction = flr(rnd(4))

    if b.direction==BTN_U then
      up(b,b.speed)
      elseif b.direction==BTN_D then
        down(b,b.speed)
      elseif b.direction==BTN_R then
        right(b,b.speed)
      elseif b.direction==BTN_L then
        left(b,b.speed)
    end   
    else
      b.state="STOP"
      b.dx=0
      b.dy=0
      b.ttl = ceil(rnd(150)+15)
    end
  end
end

function up(b,s) b.dx=0 b.dy=-s end
function right(b,s) b.dx=s b.dy=0 b.direction=1 end
function left(b,s) b.dx=-s b.dy=0 b.direction=0 end
function down(b,s) b.dx=0 b.dy=s end