BTN_L, BTN_R, BTN_U, BTN_D, BTN_X, BTN_O = 0, 1, 2, 3, 4, 5
dungeon = "128,7,139,132,5,6,135,4,137,138,9,143,13,14,15"
sewer = "129,7,131,130,129,131,135,132,137,139,9,4,1,14,5"
pit = "0,7,139,132,128,130,135,4,137,138,9,143,129,14,15"
local music_enabled = true

function palette(s)
	for i, v in ipairs(split(s, ",")) do
		pal(i, v + 0, 1)
	end
end

function _init()
	cartdata("davidhennigan_dark_dungeon_1")
	p.x, p.y, p.remaining_hearts, p.keys = dget(0), dget(1), 4, 3
	t_increment = 1
	pal(0)
	palt(14, 1)
	palt(0, 0)
	decode_tiles()
	reading, show_dialog, darkrooms, quake, zoom_view, allow_movement, raindrops = false, false, true, false, false, true, false
	init_rain()
	q = qico()
	poke(0x5f2e, 1)
	if music_enabled then music(0) end
	menuitem(
		1, "toggle music", function()
			if music_enabled then
				music(-1)
				music_enabled = false
			else
				music(0)
				music_enabled = true
			end
		end
	)
end

function _update60()
	if stat(53) == -1 then
		if current_palette == "dungeon" then
			sfx(20, 3)
		elseif current_palette == "sewer" then
			sfx(41, 3)
		elseif current_palette == "pit" then
			sfx(42, 3)
		end
	end

	update_map()
	check_room_change()
	update_player()
	baddie_m.update()
	q.proc()
	if item_selected == 1 and lanturn_timer < 12 then
		lanturn_timer = lanturn_timer + 0.5
	end
	if lanturn_timer > 0 then
		lanturn_timer = lanturn_timer - 0.25
	end
	l_rad = outelastic(lanturn_timer, 0, 30, 30)
	if reading then tb_update() end
	if raindrops then update_rain() end
end

function _draw()
	cls()
	draw_map()
	draw_background_sprites()
	baddie_m.draw()
	player_attack()
	draw_player()
	draw_foreground_sprites()
	if darkrooms then darkroom() end
	draw_inventory()
	curr_item()
	draw_player_interact_icon()
	tb_draw()
	--print(get_current_room(), mapx + 2, mapy + 2, 7)
end