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

baddie_m.update = function()
  foreach(baddie_m.baddies, function(b)
    -- Only update if on screen
    if b.x >= mapx and b.x <= mapx + 127 and b.y >= mapy and b.y <= mapy + 127 then
      baddie_update(b)
    end
  end)
end

baddie_m.draw = function()
  foreach(baddie_m.baddies, function(b)
    -- Only draw if on screen
    if b.x >= mapx and b.x <= mapx + 127 and b.y >= mapy and b.y <= mapy + 127 then
      baddie_draw(b)
    end
  end)
end

--


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
  local can_move = (b.can_fly and flying_enemy_can_move or ground_enemy_can_move)(b)
  if not can_move then
    local dir_swap = {[BTN_R]=BTN_L,[BTN_L]=BTN_R,[BTN_U]=BTN_D,[BTN_D]=BTN_U}
    local move_func = {[BTN_R]=left,[BTN_L]=right,[BTN_U]=down,[BTN_D]=up}
    b.direction=dir_swap[b.direction] or b.direction
    (move_func[b.direction] or function()end)(b,b.speed)
    b.state="BOUNCE"
  else
    b.x+=b.dx*t_increment
    b.y+=b.dy*t_increment
  end

   	if sprite_collision(p, b) then
		q.add_event("collision")
	end

  if b.ttl<=0 then
    if sees(b,l_rad*1.5,0,1,1,0) then
      b.state="ATTACK"
      for i=0,2 do sset(76+i*16,119-i,3) sset(74+i*16,120-i,3) end
      b.direction=angle_between(p,b)
      local move={[BTN_U]=up,[BTN_D]=down,[BTN_R]=right,[BTN_L]=left}
      (move[b.direction] or function()end)(b,b.att_speed)
    elseif rnd()>0.2 then
      b.state="WALK"
      for i=0,2 do sset(76+i*16,119-i,9) sset(74+i*16,120-i,9) end
      b.ttl=ceil(rnd(120)+30)
      b.direction=flr(rnd(4))
      local move={[BTN_U]=up,[BTN_D]=down,[BTN_R]=right,[BTN_L]=left}
      (move[b.direction] or function()end)(b,b.speed)
    else
      b.state="STOP"
      b.dx,b.dy=0,0
      b.ttl=ceil(rnd(150)+15)
    end
  end
end

function up(b,s) b.dx=0 b.dy=-s end
function right(b,s) b.dx=s b.dy=0 b.direction=1 end
function left(b,s) b.dx=-s b.dy=0 b.direction=0 end
function down(b,s) b.dx=0 b.dy=s end
