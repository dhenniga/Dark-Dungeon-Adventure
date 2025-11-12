-- player

p={
	x=64,
	y=40,
	dx=0,
	dy=0,
	w=8,
	h=8,
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
	fall_dir=nil,
	keys=5,
}

local idol=1
local running=1
local player_atk=false
lanturn_timer=0
l_rad=40
tp=19

-- Add sword animation to the player
p.sword_anim = {68, 70, 72, 74} -- Sword swipe animation frames
p.sword_frame = 1 -- Current frame of the sword animation
p.sword_timer = 0 -- Timer for frame transitions
p.sword_playing = false -- Whether the sword animation is playing

function draw_player()
 local isMoving=p.dx~=0 or p.dy~=0
 p.curr_speed=max(abs(p.dx),abs(p.dy))/4.5

 -- diag movement speed
 if p.dx*p.dy!=0 then
  p.dx*=0.55 p.dy*=0.55
 end

 -- idol animation
 idol=(idol<3.8) and idol+0.09*t_increment or 1

 -- running animation
 running=(isMoving and running<4.5) and running+p.curr_speed or 1

 -- footstep sounds for specific frames
 if not p.fall_dir and isMoving and ((running>1.2 and running<1.5) or (running>3.2 and running<3.4)) then
  sfx(13,3) --done
 end

 if not player_atk then
  if isMoving then
   if not p.fall_dir then spr(p.af_run[flr(running)],p.x-4,p.y-8,2,2,p.direction) end
  else
   if not p.fall_dir then spr(p.af_idle[flr(idol)],p.x-4,p.y-8,2,2,p.direction) end
  end
 else
  spr(194,p.x-4,p.y-8,2,2,p.direction)
 end

 if p.fall_dir then
  if tp>0 then
   tp-=0.5
   local c=(16-tp)/2
   sspr(96,32,16,16,p.x+c-4,p.y+c-6,tp,tp)
  else
   p.dx,p.dy=0,0
   if p.fall_dir=="left" then p.x+=16 end
   if p.fall_dir=="right" then p.x-=16 end
   if p.fall_dir=="up" then p.y+=6 end
   if p.fall_dir=="down" then p.y-=14 end
   p.fall_dir=nil
   p.remaining_hearts-=1
   tp=19
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
	local sword_anim={72,74,106,108}
	if item_selected==4 and btn(BTN_O) then
		player_atk=true
		sfx(14,3)
		local frame_index=flr(time()*(12*t_increment)%4)+1
		spr(sword_anim[frame_index],p.x+4,p.y-10,2,2,p.direction)
	else
		player_atk=false
	end

	

end

--

function update_player()
 if p.fall_dir or not allow_movement then return end
 if btn(BTN_L) then p.dx-=p.a p.direction=true end
 if btn(BTN_R) then p.dx+=p.a p.direction=false end
 if btn(BTN_U) then p.dy-=p.a end
 if btn(BTN_D) then p.dy+=p.a end
 p.dx,p.dy=mid(-1,p.dx,1),mid(-1,p.dy,1)
 if player_can_move(p) then
  p.x+=p.dx p.y+=p.dy
 else
  p.dx,p.dy=0,0
 end
 p.dx=abs(p.dx)>0 and p.dx*p.drg or 0
 p.dy=abs(p.dy)>0 and p.dy*p.drg or 0
 if abs(p.dx)<0.02 then p.dx=0 end
 if abs(p.dy)<0.02 then p.dy=0 end
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