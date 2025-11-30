
𝘣𝘵𝘯_𝘭, 𝘣𝘵𝘯_𝘳, 𝘣𝘵𝘯_𝘶, 𝘣𝘵𝘯_𝘥, 𝘣𝘵𝘯_𝘹, 𝘣𝘵𝘯_𝘰, dungeon, sewer, pit, music_enabled, collision_state, darkrooms, player_light_enabled, reading, quake, allow_movement, raindrops, mapx, mapy, l_rad, current_palette = 0, 1, 2, 3, 4, 5, "128,7,139,132,5,6,135,4,137,138,9,143,13,14,15", "129,7,131,130,129,131,135,132,137,139,9,4,1,14,5", "0,7,139,132,128,130,135,4,137,138,9,143,129,14,15", true, true, true, false, false, false, true, false, 0, 0, 0, ""

function palette(s)
	for i, v in ipairs(split(s, ",")) do
		pal(i, v + 0, 1)
	end
end

function _init()
	cartdata("davidhennigan_dark_dungeon_1")
	p.x, p.y, p.remaining_hearts, p.keys = 67, 12, 5, 5
	t_increment = 1
	cls()
	decode_tiles()
	init_rain()
	poke(0x5f2e, 1)

	if music_enabled then
		music(0)
	end
	menuitem(
		1, "𝘵𝘰𝘨𝘨𝘭𝘦 𝘮𝘶𝘴𝘪𝘤", function()
			music_enabled = not music_enabled
			music(music_enabled and 0 or -1)
		end
	)
	menuitem(
		2, "𝘵𝘰𝘨𝘨𝘭𝘦 𝘤𝘰𝘭𝘭𝘪𝘴𝘪𝘰𝘯", function()
			collision_state = not collision_state
		end
	)
	menuitem(
		3, "𝘵𝘰𝘨𝘨𝘭𝘦 𝘥𝘦𝘷𝘮𝘰𝘥𝘦", function()
			darkrooms = not darkrooms
		end
	)
end

function _update60()

	if stat(53)==-1 then
  	local t={dungeon=20,sewer=41,pit=42}
  	sfx(t[current_palette],3)
	end

	if music_enabled and not stat(57) then
		music(0)
	end

	update_map()
	check_room_change()
	update_player()
	update_shooters()
	update_arrows()

	mapx, mapy = band(p.x, 0xffffff80), band(p.y, 0xffffff80)
	baddie_m.update()

	lanturn_timer = mid(0, lanturn_timer + (player_light_enabled and 0.5 or -0.25), 12)

	l_rad = outelastic(lanturn_timer, 0, 35, 30)

	if reading then tb_update() end
	if raindrops then update_rain() end
end

function _draw()
	draw_background()
	draw_background_sprites()
	baddie_m.draw()
	player_attack()
	draw_player()
	draw_foreground_sprites()
	draw_arrows()
	if darkrooms then
		darkroom()
	else
		palt(0, false)
		palt(14, true)
	end
	draw_player_interact_icon()
	draw_inventory()

	tb_draw()
	-- if not darkrooms then
	-- 	print(get_current_room(), mapx + 106, mapy + 121, 10)
	-- end
	-- if not darkrooms then
	-- 	print("px:" .. flr(p.x) .. ", " .. "py:" .. flr(p.y), mapx + 2, mapy + 2, 7)
	-- end
	-- if not darkrooms then
	-- 	print("mx:" .. mapx .. ", my:" .. mapy, mapx + 2, mapy + 9, 7)
	-- end
	-- if not darkrooms then
	-- 	circ(p.x + 2, p.y, l_rad, 3)
	-- end
	-- if not darkrooms then print("cpu:" .. stat(1), mapx + 97, mapy + 2, 7) end
	-- if not darkrooms then print("mem:" .. stat(0), mapx + 85, mapy + 8, 7) end
end