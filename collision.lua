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

      sfx(11)
      return true
  end
  return false
end

--

--by koz, cc0 (free to use)
--sees: return true if point at x1,y1 can "see" x2,y2 (nil otherwise)
-- dist: max distance (>1)
-- facing: center angle of field-of-view
-- sweep : angle extent of fov from center (.25=180deg fov)
-- incr: maximum number of pixels to progress by during check
-- obst: tile flag for obstacles to sight
function sees(pl, b, dist, facing, sweep, incr, obst)
  local d=dist or 128
  local fac=facing or 0
  local swp=sweep or 1
  local incr=incr or 1
  local obst=obst or 0
  if (d<=1 or incr<1 or swp==0) return --invalid arguments / blind
  local dx,dy=b.x-pl.x,b.y-pl.y
  local adx,ady=abs(dx),abs(dy)
  if (adx>d or ady>d) return --too far on any axis
  if (dx/d*dx/d+dy/d*dy/d>1) return --fails mot's "within dist"
  adif=abs(fac-atan2(dx, dy))%1
  if (adif>swp and (1-adif)>swp) return --facing away
  if (adx>ady) then
   for i=0,dx,incr*sgn(dx) do
    if (fget(mget((pl.x+i)/8, (pl.y+i*dy/dx)/8),obst)) return
   end
  else
   for i=0,dy,incr*sgn(dy) do
    if (fget(mget((pl.x+i*dx/dy)/8, (pl.y+i)/8),obst)) return
   end
  end
  return true
 end

 --

 function can_move(a, dx, dy)
  local nx_l, nx_r, ny_t, ny_b = a.x + dx, a.x + dx + a.w, a.y + dy, a.y + dy + a.h
  if solid(nx_l, ny_t) or solid(nx_r, ny_t) or
     solid(nx_l, ny_b) or solid(nx_r, ny_b) then
    return false
  end
  return true
end

--

function solid(x, y)
  -- Metatiles
  local mt_x,mt_y=shr(x,4),shr(y,4)
  local metatile_num = mget(mt_x, mt_y)
  local sub_x,sub_y = flr((x % 16) / 8),flr((y % 16) / 8)
  local sub_tiles = decoded_tiles[metatile_num]

  if sub_tiles then
    local sub_tile = sub_tiles[sub_y * 2 + sub_x + 1]
    if sub_tile and fget(sub_tile.sp, 0) then
      return true 
    end
  end

  -- sprites
  for obj in all(active_objects) do
    if obj.flags.solid then
      local sx,sy = mapx+obj.x,mapy+obj.y
      if x>=sx and x<sx+16 and y>=sy and y<sy+16 then
        return true 
      end
    end
  end

  return false
end

--

function is_fall_tile(x, y)
  local metatile_x = flr(x / 16)
  local metatile_y = flr(y / 16)
  local sub_x = flr((x % 16) / 8)
  local sub_y = flr((y % 16) / 8)
  local metatile_num = mget(metatile_x, metatile_y)
  local sub_tiles = decoded_tiles[metatile_num]

  if sub_tiles then
    local sub_tile = sub_tiles[sub_y * 2 + sub_x + 1]
    if sub_tile and fget(sub_tile.sp, 2) then
      return true -- Tile has flag 2 (fall tile)
    end
  end

  return false
end










