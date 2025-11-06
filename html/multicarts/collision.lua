-- collision

function sprite_collision(s0, s1)
  if (s0.x<(s1.x+8) and (s0.x+8)>s1.x and (s0.y+8)>s1.y and s0.y<(s1.y+8)) then

      
      if s0.x<(s1.x+8) then p.recoil="left" end
      if (s0.x+8)>s1.x then p.recoil="right" end
      if (s0.y+8)>s1.y then p.recoil="up" end
      if s0.y<(s1.y+8) then p.recoil="down" end
  
      if p.recoil=="left" then s1.dx-=8 s0.dx+=8 end
      if p.recoil=="right" then s1.dx+=8 s0.dx-=8 end
      if p.recoil=="up" then s1.dy-=8 s0.dy+=8 end
      if p.recoil=="down" then s1.dy+=8 s0.dy-=8 end

      sfx(10,3) --done
      return true
  end
  return false
end

--

function sees(b, dist, facing, sweep, incr, obst)
  local d=dist or 128
  local fac=facing or 0
  local swp=sweep or 1
  local incr=incr or 1
  local obst=obst or 0
  if d<=1 or incr<1 or swp==0 then return end -- Invalid arguments / blind
  
  local dx,dy=b.x-p.x,b.y-p.y
  local adx,ady=abs(dx),abs(dy)
  if adx>d or ady>d then return end -- Too far on any axis
  if (dx/d)^2+(dy/d)^2>1 then return end -- Fails distance check

  local adif=abs(fac-atan2(dx, dy))%1
  if adif>swp and (1-adif)>swp then return end -- Facing away

  local function is_obstacle(x, y)
    -- Metatile system collision detection
    local mt_x,mt_y=shr(x,4),shr(y,4)
    local metatile_num= mget(mt_x,mt_y)
    local sub_x,sub_y= flr((x%16)/8),flr((y%16)/8)
    local sub_tiles=decoded_tiles[metatile_num]

    if sub_tiles then
      local sub_tile=sub_tiles[sub_y*2+sub_x+1]
      if sub_tile and fget(sub_tile.sp,obst) then
        return true
      end
    end
    return false
  end

  if adx>ady then
    for i=0,dx,incr*sgn(dx) do
      local x,y=p.x+i,p.y+i*dy/dx
      if is_obstacle(x,y) then return end
    end
  else
    for i=0,dy,incr*sgn(dy) do
      local x,y=p.x+i*dx/dy,p.y+i
      if is_obstacle(x,y) then return end
    end
  end

  return true
end


 --

 function ground_enemy_can_move(a)
  local nx_l,nx_r,ny_t,ny_b=a.x+a.dx,a.x+a.dx+a.w,a.y+a.dy,a.y+a.dy+a.h

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
  local nx_l,nx_r,ny_t,ny_b=a.x+a.dx,a.x+a.dx+a.w,a.y+a.dy,a.y+a.dy+a.h

  if solid(nx_l+2,ny_t+4) or solid(nx_r-2,ny_t+4) or
     solid(nx_l+2,ny_b-2) or solid(nx_r-2,ny_b-2) then
    return false
  end

  return true
end


function player_can_move(a)
--  local nx_l,nx_r=a.x+a.dx,a.x+a.dx+a.w
--  local ny_t,ny_b=a.y+a.dy,a.y+a.dy+a.h
--  local fall_checks={
--   {nx_l+4,ny_t+6},
--   {nx_r-4,ny_t+6},
--   {nx_l+4,ny_b-2},
--   {nx_r-4,ny_b-2}
--  }
--  for i=1,4 do
--   local pos=fall_checks[i]
--   if is_fall_tile(pos[1],pos[2]) then
--    sfx(11,3) --done
--    determine_fall_direction(p)
--    return false
--   end
--  end
--  local solid_checks={
--   {nx_l+2,ny_t+4},
--   {nx_r-2,ny_t+4},
--   {nx_l+2,ny_b-2},
--   {nx_r-2,ny_b-2}
--  }
--  for i=1,4 do
--   local pos=solid_checks[i]
--   if solid(pos[1],pos[2]) then
--    return false
--   end
--  end
 return true
end

--

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

--

function solid(x, y)
  -- Metatiles
  local mt_x,mt_y=shr(x,4),shr(y,4)
  local metatile_num=mget(mt_x, mt_y)
  local sub_x,sub_y=flr((x%16)/8),flr((y%16)/8)
  local sub_tiles=decoded_tiles[metatile_num]

  if sub_tiles then
    local sub_tile=sub_tiles[sub_y*2+sub_x+1]
    if sub_tile and fget(sub_tile.sp,0) then
      return true 
    end
  end

  -- sprites
  for obj in all(active_objects) do
    if obj.flags.solid then
      local sx,sy=mapx+obj.x,mapy+obj.y
      if x>=sx and x<sx+16 and y>=sy and y<sy+16 then
        return true 
      end
    end
  end
  return false
end

--

-- Add fall tile check
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







