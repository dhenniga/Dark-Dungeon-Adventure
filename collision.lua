-- collision

function spr_coll(a,b)
 if a.x<b.x+8 and a.x+8>b.x and a.y<b.y+8 and a.y+8>b.y then
  local dx=a.x-b.x dy=a.y-b.y
  local d=sqrt(dx*dx+dy*dy) if d<1 then d=1 end
  dx/=d dy/=d
  a.dx+=dx*2 a.dy+=dy*2
  b.dx-=dx b.dy-=dy
  sfx(16,3)
  return true
 end
end

function sees(b,max_dist)
 local dx,dy=p.x-b.x,p.y-b.y
 local dsq=dx*dx+dy*dy
 max_dist=max_dist or 128
 if dsq>max_dist*max_dist then return false end

 local dist_sqrt=sqrt(dsq)
 local steps=mid(1,flr(dist_sqrt*0.25),16) -- min 1 step, max 16
 for i=1,steps do
  local t=i/steps
  if solid(b.x+t*dx,b.y+t*dy) then return false end
 end

 return true
end



-- function sees(b, max_dist, facing, sweep)
--     local max_dist, facing, sweep, dx, dy = max_dist or 128, facing or 0, sweep or 1, p.x - b.x, p.y - b.y
--     local dist_sq = dx*dx + dy*dy
--     if dist_sq > max_dist*max_dist then return false end -- too far

--     -- facing check
--     local ang_to_player = atan2(dy, dx)
--     if ang_to_player < 0 then ang_to_player += 1 end
--     local diff = abs(ang_to_player - facing) % 1
--     if diff > sweep and (1 - diff) > sweep then return false end -- facing away

--     -- obstacle check (simple step along line)
--     local steps = flr(sqrt(dist_sq) / 4)  -- every 4 pixels
--     for i = 1, steps do
--       local t = i / steps
--       local x = b.x + dx * t
--       local y = b.y + dy * t
--       if solid(x, y) then return false end
--     end

--     return true
-- end

function enemy_can_move(a)
  local xl,xr,yt,yb=a.x+a.dx,a.x+a.dx+8,a.y+a.dy,a.y+a.dy+8
  if not a.can_fly 
    and (is_fall_tile(xl+4,yt+6) 
    or is_fall_tile(xr-4,yt+6) 
    or is_fall_tile(xl+4,yb-2) 
    or is_fall_tile(xr-4,yb-2)
  ) 
    then 
      return false 
    end
    
    return not(solid(xl+2,yt+4) 
    or solid(xr-2,yt+4) 
    or solid(xl+2,yb-2) 
    or solid(xr-2,yb-2)
  )
end

function player_can_move(a)
  if collision_state then
    local xl,xr,yt,yb=a.x+a.dx,a.x+a.dx+8,a.y+a.dy,a.y+a.dy+8
    for i=1,4 do
      local x,y=i<3 and xl+4 or xr-4,(i%2<1)and yt+6 or yb-2
      if is_fall_tile(x,y)then
      sfx(11,3)determine_fall_direction(p)return false
      end
      x,y=i<3 and xl+2 or xr-2,(i%2<1)and yt+4 or yb-2
      if solid(x,y)then return false end
    end
  end
 return true
end

function determine_fall_direction(a)
  a.curr_speed=3
  -- allow_movement=false
  if a.dx > 0 then
    a.fall_dir = "right"
    a.x+=6
  elseif a.dx < 0 then
    a.fall_dir = "left"
    a.x-=6
  elseif a.dy > 0 then
    a.fall_dir = "down"
    a.y+=8
  elseif a.dy < 0 then
    a.fall_dir = "up"
  end
end

function solid(x,y)
  local s=decoded_tiles[mget(shr(x,4),shr(y,4))]
  if s then
    local t=s[flr(band(y,15)/8)*2+flr(band(x,15)/8)+1]
    if t and fget(t.sp,0) then return true end
  end
  for o in all(active_objects)do
    if o.flags.solid and x>=mapx+o.x and x<mapx+o.x+16 and y>=mapy+o.y and y<mapy+o.y+16 then return true end
  end
end

function is_fall_tile(x,y)
  local mt_x,mt_y=shr(x,4),shr(y,4)
  local metatile_num=mget(mt_x,mt_y)
  local sub_x,sub_y=flr((x%16)/8),flr((y%16)/8)
  local sub_tiles=decoded_tiles[metatile_num]

  if sub_tiles then
    local sub_tile=sub_tiles[sub_y*2+sub_x+1]
    if sub_tile and fget(sub_tile.sp,2) then
      return true
    end
  end
  return false
end







