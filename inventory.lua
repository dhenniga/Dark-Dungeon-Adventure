--inventory code

local inv_timer=0

function draw_inventory()	

	-- print(get_current_room(),mapx,mapy,9) -- room number

-- lives
	for i=1,p.total_hearts do

		if zoom_view then
			if p.remaining_hearts>=i then
				sspr(96,8,3,3,p.x+shl(i,2)-32,p.y+29)
			else
				sspr(101,8,3,3,p.x+shl(i,2)-32,p.y+29)
			end
			
		else
			if p.remaining_hearts>=i then
				spr(238,mapx+shl(i,3)-8,mapy+118,1,1)
			else
				spr(239,mapx+shl(i,3)-8,mapy+118,1,1)
			end
		end

	end

	--

	if btn(BTN_X) then		
		t_increment=0.05		
		if inv_timer<50 then
			for i=1,1 do
				inv_timer+=1
			end
		end	
		if inv_timer==1 then sfx(13) end
		p.dx=0
		p.dy=0
		allow_movement=false
		show_inventory()
	else
		t_increment=1
		inv_timer=0
		allow_movement=true
	end

end

item_selected=1

local top_item=0
local bottom_item=0
local left_item=0
local right_item=0

function place_on_map(obj,col)
	pset(mapx+96+obj.x/16,mapy+96+obj.y/16,col)
end

function curr_item()

if (item_selected==1) spr(207,mapx+8,mapy+4,1,2) --lanturn
if (item_selected==4) spr(72,mapx+4,mapy+4,2,2) --sword

end

--

function p4bonus(s,x,y,c,o) -- 34 tokens, 5.7 seconds
  color(o)
  ?'\-f'..s..'\^g\-h'..s..'\^g\|f'..s..'\^g\|h'..s,x,y
  ?s,x,y,c
end

--

function show_inventory()

	for obj in all(active_objects) do
    if obj.flags.name then
			if reading==false then
				p4bonus(get_current_room(),mapx+0,mapy+104,11,0)
				p4bonus(obj.name,mapx+0,mapy+112,11,0)
			end
		end
	end

	if (btnp(BTN_U)) item_selected=1 sfx(11)
	if (btnp(BTN_D)) item_selected=2 sfx(11)  
	if (btnp(BTN_L)) item_selected=3 sfx(11)
	if (btnp(BTN_R)) item_selected=4 sfx(11)

	if item_selected==1 then top_item=7 else top_item=0 end
	if item_selected==2 then bottom_item=7 else bottom_item=0 end
	if item_selected==3 then left_item=7 else left_item=0 end
	if item_selected==4 then right_item=7 else right_item=0 end
	
	--top select background
	fillp(0x0000)
	circfill(p.x+2,p.y-20,outelastic(inv_timer,0,10+top_item,50),top_item)

	--bottom select background
	fillp(0x0000)
	circfill(p.x+2,p.y+20,outelastic(inv_timer,0,10+bottom_item,50),bottom_item)

	--left select background
	fillp(0x0000)
	circfill(p.x-19,p.y,outelastic(inv_timer,0,10+left_item,50),left_item)

	--right select background
	fillp(0x0000)
	circfill(p.x+23,p.y,outelastic(inv_timer,0,10+right_item,50),right_item)

	--main background
	fillp(0x0000)
	circfill(p.x+2,p.y,outelastic(inv_timer,0,25,25),5)
	circ(p.x+2,p.y,outelastic(inv_timer,0,25,25),0)

	-- show the player
	spr(192,p.x-4,p.y-6,2,2,p.direction)
	
	-- small key
	if p.keys==1 then
		fillp(█)
		circfill(mapx+121,mapy+6,6,3)
		spr(206,mapx+118,mapy+3,1,1) 	
	end

 	-- lantern
	fillp(0x0000)
	circfill(p.x+2,p.y-20,outelastic(inv_timer,0,9,50),5)
	spr(207,p.x-1,outelastic(inv_timer,p.y,-25,25),1,2) -- lanturn
		
	-- sword
	fillp(0x0000)
	circfill(p.x+23,p.y,outelastic(inv_timer,0,9,50),5)
	spr(72,outelastic(inv_timer,p.x,16,25),p.y-8,2,2) -- sword

	-- something else
	fillp(0x0000)
	circfill(p.x+2,p.y+20,outelastic(inv_timer,0,9,50),5)

	-- something else
	fillp(0x0000)
	circfill(p.x-19,p.y,outelastic(inv_timer,0,9,50),5)
 
end