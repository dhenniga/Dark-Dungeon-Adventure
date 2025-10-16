-- dark dungeon adventure
-- by david hennigan

BTN_L = 0
BTN_R = 1
BTN_U = 2
BTN_D = 3
BTN_X = 4
BTN_O = 5

local dungeon = {{1,128},{2,7},{3,139},{4,132},{5,5},{6,6},{7,135},{8,4},{9,137},{10,138},{11,9},{12,143},{13,13},{14,14},{15,15}}
local sewer = {{1,129},{2,7},{3,131},{4,130},{5,129},{6,131},{7,135},{8,132},{9,137},{10,139},{11,9},{12,4},{13,1},{14,14},{15,5}}
local pit={{1,0},{2,7},{3,139},{4,132},{5,128},{13,129},{6,130},{7,135},{8,4},{9,137},{10,138},{11,9},{12,143},{14,14},{15,15}}

function palette(data)
	for i,v in ipairs(data) do
		pal(v[1],v[2],1)
	end
end

function save_game()
	s={}
	s.x=64
	s.y=48
	s.remaining_hearts=3
end

function _init()
	cartdata("davidhennigan_dark_dungeon_1")
	p.x = 570 or dget(0)
	p.y = 40 or dget(1)
  -- p.x = 148 or dget(0)
	-- p.y = 294 or dget(1)
	p.remaining_hearts = 3 or dget(2)

	t_increment = 1
	pal(0)
	palt(14,true)
	palt(0,false)
	decode_tiles()
	reading=false
	show_dialog=false
	darkrooms=true
	quake=false
	zoom_view=false
	allow_movement=true
	raindrops=false

	init_rain()

	--collision
	q=qico()
	-- q.add_topics("collision")
	-- q.add_sub("collision", p.handle_collision)

--music(0)
	sfx(10,3)
 poke(0x5f2e,1) --keep palette changes
 palette(dungeon)
end

--

function _update60()
	check_room_change()
	update_map()
	update_player()	
	baddie_m.update()

	q.proc()
	
	-- lanturn
	if item_selected==1 and lanturn_timer<12 then 
		for i=1,1 do
			lanturn_timer+=0.5
		end
	end
	
	if lanturn_timer>0 then
		for i=1,1 do
			lanturn_timer-=0.25
		end
	end

	l_rad=outelastic(lanturn_timer,0,30,30)

	if reading then
		tb_update()
	end

	if (raindrops) update_rain()
	
end

--

radius_thing=128

function _draw()
	cls()
	draw_map()
	draw_background_sprites()
	baddie_m.draw()
	player_attack()
	draw_player()
	draw_foreground_sprites()
	if (darkrooms) darkroom()	
	draw_inventory()
	curr_item()
	draw_sign_dialog()
	tb_draw()	
	-- draw_screen_wipe()

end