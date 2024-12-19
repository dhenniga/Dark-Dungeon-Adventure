--inventory code

local inv_timer=0

function draw_inventory()	

	print(get_current_room(),mapx,mapy,9) -- room number

-- lives
	for i=1,p.total_hearts do
		if iscamfollow then
		if p.remaining_hearts>=i then
			spr(238,mapx+shl(i,3)-8,mapy+118,1,1)
		else
			spr(239,mapx+shl(i,3)-8,mapy+118,1,1)
		end

		else
			if p.remaining_hearts>=i then
			spr(238,p.x-64+shl(i,3)-8,p.y+54,1,1)
			else
				spr(239,p.x-64+shl(i,3)-8,p.y+54,1,1)
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
		allow_movement=false
		show_inventory()
	else
		t_increment=1
		allow_movement=true
		inv_timer=0
	end

end

item_selected=1

local top_item=0
local bottom_item=0
local left_item=0
local right_item=0

function curr_item()

if iscamfollow then
	if (item_selected==1) spr(207,mapx+8,mapy+4,1,2) --lanturn
	if (item_selected==4) spr(110,mapx+4,mapy+4,2,2) --sword
else 
	if (item_selected==1) spr(207,p.x-64,p.y-64,1,2) --lanturn
	if (item_selected==4) spr(110,p.x-64,p.y-64,2,2) --sword
end
end


function show_inventory()

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
	if p.keys==0 then
		fillp(█)
		if iscamfollow then
			circfill(mapx+121,mapy+6,6,3)
			spr(190,mapx+118,mapy+3,1,1)
	 	else
	 		circfill(p.x+6-64,p.y-64+5,6,3)
			spr(190,p.x-64+3,p.y-64+2,1,1)
		end
	end


 	-- lantern
	fillp(0x0000)
	circfill(p.x+2,p.y-20,outelastic(inv_timer,0,9,50),5)
	spr(207,p.x-1,outelastic(inv_timer,p.y,-25,25),1,2)
		
	-- sword
	fillp(0x0000)
	circfill(p.x+23,p.y,outelastic(inv_timer,0,9,50),5)
	spr(110,outelastic(inv_timer,p.x,16,25),p.y-8,2,2)

	-- something else
	fillp(0x0000)
	circfill(p.x+2,p.y+20,outelastic(inv_timer,0,9,50),5)

	-- something else
	fillp(0x0000)
	circfill(p.x-19,p.y,outelastic(inv_timer,0,9,50),5)
 
end