-- player

p = {
	x = 64,
	y = 40,
	dx = 0,
	dy = 0,
	curr_speed = 0,
	acc = 0.4,
	drg = 0.9,
	cooldown = 0,
	total_hearts = 5,
	remaining_hearts = 3,
	fall_dir = nil,
	keys = 1,
	engaged = false,
	moving = false
}

local idle = 1
local running = 1
local player_atk = false
lanturn_timer = 0
tp = 19

function draw_player()
	p.moving = p.dx ~= 0 or p.dy ~= 0
	p.curr_speed = max(abs(p.dx), abs(p.dy)) / 4.5

	-- diag movement speed
	if p.dx * p.dy != 0 then
		p.dx *= 0.55 p.dy *= 0.55
	end

	-- idle animation
	idle = (idle < 3.8) and idle + 0.09 * t_increment or 1

	-- running animation
	running = (p.moving and running < 4.5) and running + p.curr_speed or 1

	-- footstep sounds for specific frames
	if not p.fall_dir and p.moving and ((running > 1.2 and running < 1.5) or (running > 3.2 and running < 3.4)) then
		sfx(13, 3)
	end

	if not player_atk then
		if p.moving then 
			if not p.fall_dir then spr(({198,200,202,204})[flr(running)], p.x - 4, p.y - 8, 2, 2, p.direction) end
		else
			if not p.fall_dir then spr(({192,194,196})[flr(idle)], p.x - 4, p.y - 8, 2, 2, p.direction) end
		end
	else
		spr(194, p.x - 4, p.y - 8, 2, 2, p.direction)
	end

	if p.fall_dir then
		if tp > 0 then
			tp -= 0.5
			local c = (16 - tp) / 2
			sspr(96, 32, 16, 16, p.x + c - 4, p.y + c - 6, tp, tp)
		else
			p.dx, p.dy = 0, 0
			if p.fall_dir == "left" then p.x += 16 end
			if p.fall_dir == "right" then p.x -= 16 end
			if p.fall_dir == "up" then p.y += 6 end
			if p.fall_dir == "down" then p.y -= 14 end
			p.fall_dir = nil
			p.remaining_hearts -= 1
			tp = 19
		end
	end
end

--

function player_attack()
	-- sword frames
	local sword_frames={72,74,106,108}

	-- start attack on button press if not already attacking
	if btnp(BTN_O) and not p.engaged and not player_atk then
		player_atk=true
		p.atk_t=time() -- start timestamp
		sfx(14,3)
	end

	-- handle active attack animation
	if player_atk then
		local t=time()-p.atk_t
		local i=flr(t*12)%#sword_frames+1 -- control frame timing
		local o=p.direction and -12 or 4
		spr(sword_frames[i],p.x+o,p.y-10,2,2,p.direction)

		-- attack lasts ~0.3s
		if t>0.3 then
			player_atk=false
		end
	end
end

--

function update_player()
	if p.fall_dir or not allow_movement then return end
	if btn(BTN_L) then
		p.dx -= p.acc p.direction = true
	end
	if btn(BTN_R) then
		p.dx += p.acc p.direction = false
	end
	if btn(BTN_U) then p.dy -= p.acc end
	if btn(BTN_D) then p.dy += p.acc end
	p.dx, p.dy = mid(-1, p.dx, 1), mid(-1, p.dy, 1)
	if player_can_move(p) then
		p.x += p.dx p.y += p.dy
	else
		p.dx, p.dy = 0, 0
	end
	p.dx = abs(p.dx) > 0 and p.dx * p.drg or 0
	p.dy = abs(p.dy) > 0 and p.dy * p.drg or 0
	if abs(p.dx) < 0.02 then p.dx = 0 end
	if abs(p.dy) < 0.02 then p.dy = 0 end
end

--

function draw_character_light()
	if l_rad > 0 then
		local px, py = p.x + 2, p.y + 2
		fillp(░)
		circfill(px, py, (l_rad - 10) + rnd(3) + l_rad / 1.5, 14)
		fillp(▒)
		circfill(px, py, (l_rad - 10) + rnd(3) + l_rad / 3, 14)
		fillp(█)
		circfill(px, py, (l_rad - 10) + rnd(3) + l_rad / 6, 14)
	end
end
