--map
decoded_tiles={}

function decode_tiles()
 for num=0,128 do
  local sx,sy=num%16,flr(num/16)
  local tile={}
  for i=0,1 do
   for j=0,1 do
    local s=(shl(sx,3)+shl(i,2))+(shl(sy,8)+shl(j,7))
    local sp=tonum("0x"..sub(tiledat,1+s,2+s))
    local hf=sub(tiledat,3+s,3+s)=="1"
    local vf=sub(tiledat,4+s,4+s)=="1"
    add(tile,{sp=sp,x_offset=i*8,y_offset=j*8,hf=hf,vf=vf})
   end
  end
  decoded_tiles[num]=tile
 end
end

--

function spr_ex(tile,x,y)
 for t in all(tile) do
  spr(t.sp,x+t.x_offset,y+t.y_offset,1,1,t.hf,t.vf)
 end
end

--

function map_ex(atx,aty,m_x,m_y)
 local start_x,start_y=m_x,m_y
 local end_x,end_y=m_x+8,m_y+8
 for map_x=start_x,end_x-1 do
  for map_y=start_y,end_y-1 do
   local s=mget(map_x,map_y)
   local tile=decoded_tiles[s]
   if tile then
    spr_ex(tile,shl(map_x-m_x,4)+atx,shl(map_y-m_y,4)+aty)
   end
  end
 end
end

--

function update_map()
	local new_mapx,new_mapy=band(p.x,0xFFFFFF80),band(p.y,0xFFFFFF80)
	if new_mapx~=mapx or new_mapy~=mapy then
	 mapx,mapy=new_mapx,new_mapy
	end

	local offset=0
	local time_val=flr(time()*0.1)
	if (quake) offset=(16-rnd(512))*0.001
	poke(0x5f2c,zoom_view and 3 or 0)
	camera(
		(zoom_view and (p.x-29+offset) or (mapx+offset*time_val)),
		(zoom_view and (p.y-31+offset) or (mapy+offset*time_val))
	)
end 

function draw_map()
 map_ex(mapx,mapy,shr(mapx,4),shr(mapy,4))
end

--

function darkroom()
	memcpy(0xa000,0,0x2000)
	memcpy(0x0,0x6000,0x2000)
	poke(0x5f55,0x0)
	fillp(rnd({▒,░,…}))
	rectfill(mapx,mapy,mapx+128,mapy+128,0)
	draw_torch_light()
	draw_character_light()
	if (raindrops) draw_rain()
	poke(0x5f55,0x60)
	pal({1,0,1,0,1,0,0,1,1,1,1,1,0,0,0,0})
	if zoom_view then
		sspr(0,0,64,64,p.x-29,p.y-31)
	else
		sspr(0,0,128,128,mapx,mapy)
	end
	pal(0)	
	palt(14,true)
	palt(0,false)
	memcpy(0,0xa000,0x2000)
end




r = {}

function init_rain()
	for i=1,100 do
		r[i]={x=rnd(256)-128,y=rnd(128),v=1+flr(rnd(2))}
	end
end

function update_rain()
	for raindrop in all(r) do
		local speed_factor=3/raindrop.v*t_increment
		raindrop.x+=speed_factor
		raindrop.y+=speed_factor
		
		if raindrop.y>=134 then
			raindrop.x,
			raindrop.y,
			raindrop.v=rnd(256)-127,-6,1+flr(rnd(2))
		end
	end
end

function draw_rain()
	for raindrop in all(r) do
		local length = raindrop.v==1 and 2 or 1
		local color=12-11*(raindrop.v-1)
		line(
			mapx+raindrop.x,
			mapy+raindrop.y,
			mapx+raindrop.x-length,
			mapy+raindrop.y-length,
			color
		)
    end
end