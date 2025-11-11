BTN_L,BTN_R,BTN_U,BTN_D,BTN_X,BTN_O=0,1,2,3,4,5

dungeon={{1,128},{2,7},{3,139},{4,132},{5,5},{6,6},{7,135},{8,4},{9,137},{10,138},{11,9},{12,143},{13,13},{14,14},{15,15}}
sewer={{1,129},{2,7},{3,131},{4,130},{5,129},{6,131},{7,135},{8,132},{9,137},{10,139},{11,9},{12,4},{13,1},{14,14},{15,5}}
pit={{1,0},{2,7},{3,139},{4,132},{5,128},{13,129},{6,130},{7,135},{8,4},{9,137},{10,138},{11,9},{12,143},{14,14},{15,15}}

function palette(d)
	for i in all(d)do pal(i[1],i[2],1)end
end

function save_game()
	s={x=64,y=48,remaining_hearts=3}
end

function _init()
	cartdata("davidhennigan_dark_dungeon_1")
	p.x,p.y=68,18 --or dget(0),dget(1)

	-- p.x,p.y=68*16,18 --or dget(0),dget(1)
	p.remaining_hearts=5 --or dget(2)
	t_increment=1
	pal(0) palt(14,1) palt(0,0)
	decode_tiles()
	reading,show_dialog,darkrooms,quake,zoom_view,allow_movement,raindrops=false,false,true,false,false,true,false
	init_rain()
	q=qico()
	--music(0)
	poke(0x5f2e,1)
	palette(dungeon)
end

function _update60()
	-- if not stat(57)then music(0)end
	if stat(53)==-1 then sfx(20,3)end
	check_room_change()
	update_map()
	update_player()
	baddie_m.update()
	q.proc()
	if item_selected==1 and lanturn_timer<12 then lanturn_timer+=.5 end
	if lanturn_timer>0 then lanturn_timer-=.25 end
	l_rad=outelastic(lanturn_timer,0,30,30)
	if reading then tb_update()end
	if raindrops then update_rain()end
end

radius_thing=128

function _draw()
	cls()
	draw_map()
	draw_background_sprites()
	baddie_m.draw()
	player_attack()
	draw_player()
	draw_foreground_sprites()
	if darkrooms then darkroom()end
	draw_inventory()
	curr_item()
	draw_sign_dialog()
	tb_draw()
end
