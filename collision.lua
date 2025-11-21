-- collision

function sprite_collision(o1,o2)
 if o1.x<(o2.x+8) 
 and (o1.x+8)>o2.x 
 and (o1.y+8)>o2.y 
 and o1.y<(o2.y+8) then
  local dx, dy = o1.x - o2.x, o1.y - o2.y
  local dist = sqrt(dx*dx + dy*dy)
  dx /= dist
  dy /= dist

  -- bounce strengths
  local pk = 2     -- player knockback
  local bk = 1   -- baddie knockback (slightly stronger)

  -- push both entities apart
  o1.dx += dx * pk
  o1.dy += dy * pk
  o1.dx -= dx * bk
  o2.dy -= dy * bk

  sfx(16,3)
  return true
 end
 return false
end

--

function sees(b, max_dist, facing, sweep)
    local max_dist, facing, sweep, dx, dy = max_dist or 128, facing or 0, sweep or 1, p.x - b.x, p.y - b.y
    local dist_sq = dx*dx + dy*dy
    if dist_sq > max_dist*max_dist then return false end -- too far

    -- facing check
    local ang_to_player = atan2(dy, dx)
    if ang_to_player < 0 then ang_to_player += 1 end
    local diff = abs(ang_to_player - facing) % 1
    if diff > sweep and (1 - diff) > sweep then return false end -- facing away

    -- obstacle check (simple step along line)
    local steps = flr(sqrt(dist_sq) / 4)  -- every 4 pixels
    for i = 1, steps do
      local t = i / steps
      local x = b.x + dx * t
      local y = b.y + dy * t
      if solid(x, y) then return false end
    end

    return true
end

--

 function ground_enemy_can_move(a)
  local nx_l,nx_r,ny_t,ny_b=a.x+a.dx,a.x+a.dx+8,a.y+a.dy,a.y+a.dy+8

  if is_fall_tile(nx_l+4,ny_t+6) or is_fall_tile(nx_r-4, ny_t+6) or
     is_fall_tile(nx_l+4,ny_b-2) or is_fall_tile(nx_r-4, ny_b-2) then
   return false
  end

  if solid(nx_l+2,ny_t+4) or solid(nx_r-2,ny_t+4) or
     solid(nx_l+2,ny_b-2) or solid(nx_r-2,ny_b-2) then
    return false
  end

  return true
end

function flying_enemy_can_move(a)
  local nx_l,nx_r,ny_t,ny_b=a.x+a.dx,a.x+a.dx+8,a.y+a.dy,a.y+a.dy+8

  if solid(nx_l+2,ny_t+4) or solid(nx_r-2,ny_t+4) or
     solid(nx_l+2,ny_b-2) or solid(nx_r-2,ny_b-2) then
    return false
  end

  return true
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
  local mt=mget(shr(x,4),shr(y,4))
  local st=decoded_tiles[mt]
  if st then
    local i=flr((y%16)/8)*2+flr((x%16)/8)+1
    local t=st[i]
    if t and fget(t.sp,0) then return true end
  end

  for o in all(active_objects) do
    if o.flags.solid then
      local sx,sy=mapx+o.x,mapy+o.y
      if x>=sx and x<sx+16 and y>=sy and y<sy+16 then
        return true
      end
    end
  end

  return false
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







