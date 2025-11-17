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
  if toggle_collision then
    local xl,xr,yt,yb=a.x+a.dx,a.x+a.dx+a.w,a.y+a.dy,a.y+a.dy+a.h
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







