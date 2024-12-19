-- player

p={
	x=64,
	y=40,
	dx=0,
	dy=0,
	w=8,
	h=8,
	xspd=1,
	yspd=1,
	curr_speed=0,
	a=0.4,
	drg=0.9,
	recoil=0,
	cooldown=0,
	weapon=nil,
	af_idle={192,194,196},
	af_run={198,200,202,204},
	total_hearts=5,
	remaining_hearts=3,
	falling=false,
}

local idol=1
local running=1
lanturn_timer=0
l_rad=40
tp=16

function draw_player()

		isMoving = p.dx>0 or p.dx<0 or p.dy>0 or p.dy<0 
		p.curr_speed=max(abs(p.dx),abs(p.dy))/4.5

		-- diag movement speed
		if p.dx*p.dy!=0 then
			p.dx=p.dx*0.55
			p.dy=p.dy*0.55
		end

			-- idol animation
			if (idol<3.8) then 
				idol=idol+0.09*t_increment
			else 
				idol=1 
			end
			
			-- running animation
			if (isMoving and running<4.5) then 
				running=running+p.curr_speed
			else 
				running=1
			end
			
			--footstep sounds for specific frames
			if (isMoving and running>1.2 and running<1.5 or running>3.2 and running<3.4) then
				sfx(7,2)
			end

			if not p.falling then
		if isMoving then 
			-- circ(p.x+2,p.y+2,l_rad*1.5,8) --light radius test
			spr(p.af_run[flr(running)],p.x-4,p.y-8,2,2,p.direction)
			-- spr(162,p.x,p.y,1,1,p.direction) --collision test block
		else
			-- circ(p.x+2,p.y+2,l_rad*1.5,8) --light radius test
			spr(p.af_idle[flr(idol)],p.x-4,p.y-8,2,2,p.direction)
			-- spr(162,p.x,p.y,1,1,p.direction) --collision test block
		end
	end

	if p.falling then
		if tp > 0 then
			-- Shrink sprite evenly toward the center
			tp -= 0.4 -- Reduce size
	
			local center_offset = (16 - tp) / 2 -- Calculate how much to shift to center the sprite
	
			-- Adjust position and draw the sprite
			sspr(96, 32, 16, 16, p.x + center_offset-4, p.y + center_offset-4, tp, tp)
		else
			-- Reset after falling animation
			p.falling = false
			tp = 16
		end
	end

end

--

p.handle_collision = function()
	if p.cooldown == 0 then	
		p.remaining_hearts -= 1
		p.cooldown = 60
	end
end

--

function player_attack()
	if item_selected==4 then
		if btn(BTN_O) then
			spr(110,p.x+7,p.y-8,2,2,p.direction)
		end
	end
end

--

function update_player()

	if allow_movement==true then
		if (btn(BTN_L)) p.dx -= p.a p.direction = true
		if (btn(BTN_R)) p.dx += p.a p.direction = false
		if (btn(BTN_U)) p.dy -= p.a
		if (btn(BTN_D)) p.dy += p.a
		
		p.dx = mid(-p.xspd, p.dx, p.xspd)
		p.dy = mid(-p.yspd, p.dy, p.yspd)

		-- Check if the player can move
		if (can_move(p, p.dx, p.dy)) then
			p.x += p.dx
			p.y += p.dy
		else
			-- Stop movement if collision is detected
			p.dx = 0
			p.dy = 0
		end 
	
		-- Apply friction
		if (abs(p.dx) > 0) p.dx *= p.drg
		if (abs(p.dy) > 0) p.dy *= p.drg
		
		-- Stop small movements
		if (abs(p.dx) < 0.02) p.dx = 0
		if (abs(p.dy) < 0.02) p.dy = 0

end
end

--

function fall_player()
  p.falling = false -- Reset falling state
end

--

function draw_character_light()
	if l_rad>0 then
	 local px,py=p.x+2,p.y+2
	 fillp(░)
	 circfill(px,py,l_rad+rnd(3)+l_rad/1.5,14)
	 fillp(▒)
	 circfill(px,py,l_rad+rnd(3)+l_rad/3,14)
	 fillp(█)
	 circfill(px,py,l_rad+rnd(3)+l_rad/6,14) 
	end
end