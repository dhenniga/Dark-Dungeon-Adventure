-- dark dungeon adventure
-- by david hennigan

-- refactor
---------------------
-- Unify map collision solution to use one function


---------------------

-- todo
---------------------
-- bat and rat ai
-- implement sword
-- doors and keys
-- stringify map data and write parser
-- use the map memory for more sprites
-- acceleration/deceleration for everything moving
---------------------

--todo more
---------------------
-- Add interactive element to bookcases
-- -- Fix collision on bookcases by modifying the metatile collision to half tiles.
-- Better start screen layout.
-- Save Game state
-- Stairs


--

BTN_L = 0
BTN_R = 1
BTN_U = 2
BTN_D = 3
BTN_X = 4
BTN_O = 5

--

local dungeon = {{1,128},{2,7},{3,139},{4,132},{5,5},{6,6},{7,135},{8,4},{9,137},{10,138},{11,9},{12,143},{13,13},{14,14},{15,15}}
local sewer = {{1,129},{2,7},{3,131},{4,130},{5,129},{6,131},{7,135},{8,132},{9,137},{10,139},{11,9},{12,4},{13,1},{14,14},{15,5}}

function pallette(data)
	for i,v in ipairs(data) do
		pal(v[1],v[2],1)
	end
end

--

function save_game()
	s={}
	s.player_x = 64
	s.player_y = 48
	s.hearts = 3
end

function _init()

	cartdata("davidhennigan_dark_dungeon_1")
  p.x = 64 or dget(0)
	p.y = 48 or dget(1)

	t_increment = 1
	pal(0)
	palt(14,true)
	palt(0,false)
	decode_tiles()
	iscamfollow=true
	reading=false
	show_dialog=false
	quake=false
	dark_shimmer=false

	-- make_player()

	--collision
	q=qico()
	q.add_topics("collision")
	q.add_sub("collision", p.handle_collision)

 --music(0)
 sfx(10,3)
 poke(0x5f2e,1) --keep pallette changes
 pallette(dungeon)
 menuitem(1, "toggle follow", function() iscamfollow=not iscamfollow end)	
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
	
end

--

local radius_thing=128

function _draw()
	cls()
	draw_map()	
	draw_background_sprites()
	baddie_m.draw()
	draw_player()
	player_attack()
	draw_foreground_sprites()
	darkroom()

	poke(0x5f34,0x2)
	if radius_thing>0 then
		allow_movement=false
		for i=1,1 do
			radius_thing-=1
			circfill(p.x+3,p.y,radius_thing,0|0x1800)
			if radius_thing==0 then radius_thing=128 end
		end
	end
	
	draw_inventory() -- inventory layer above darkroom layer
	curr_item() -- currently selected item
	draw_sign_dialog()
	tb_draw()
end