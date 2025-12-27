BTN_L, BTN_R, BTN_U, BTN_D, BTN_X, BTN_O, dungeon, sewer, pit, player_light_enabled, reading, allow_movement, raindrops = 0, 1, 2, 3, 4, 5, "128,7,139,132,5,6,135,4,137,138,9,143,13,14,15", "129,7,131,130,129,131,135,132,137,139,9,4,1,14,5", "0,7,139,132,128,130,135,4,137,138,9,143,129,14,15", false, false, true, false

music_enabled = true
collision_state = true
darkrooms = true

function palette(s)
  for i, v in ipairs(split(s, ",")) do
    pal(i, v + 0, 1)
  end
end

function _init()
  cartdata("davidhennigan_dark_dungeon_1")
  p.x, p.y, p.remaining_hearts, p.keys = 67, 24, 5, 5
  -- p.x, p.y, p.remaining_hearts, p.keys = 3, 120, 5, 5
  t_increment = 1
  cls()
  decode_tiles()
  init_rain()
  -- keeps the palette after quit.  Can be removed later.
  poke(0x5f2e, 1)

  if music_enabled then
    music(0)
  end
  menuitem(
    1, "TOGGLE MUSIC", function()
      music_enabled = not music_enabled
      music(music_enabled and 0 or -1)
    end
  )
  menuitem(
    2, "TOGGLE COLLISION", function()
      collision_state = not collision_state
    end
  )
  menuitem(
    3, "TOGGLE DEVMODE", function()
      darkrooms = not darkrooms
    end
  )
  -- start_level_reveal()
  sfx(46, 3)
end

function _update60()
  if stat(53) == -1 then
    local t = {
      dungeon = 20,
      sewer = 41,
      pit = 42
    }
    sfx(t[current_palette], 3)
  end

  if music_enabled and not stat(57) then
    music(0)
  end

  update_map()
  check_room_change()
  update_player()
  update_shooters()
  update_arrows()
  update_buttons()
  update_events()
  update_smoke()
  update_circle()

  --

  mapx, mapy = band(p.x, 0xFFFFFF80), band(p.y, 0xFFFFFF80)
  baddie_m.update()

  lanturn_timer = mid(0, lanturn_timer + (player_light_enabled and 0.5 or -0.25), 12)
  l_rad = outelastic(lanturn_timer, 0, 35, 30)

  --

  if reading then
    tb_update()
  end
  if raindrops then
    update_rain()
  end
end

function _draw()
  draw_background()
  draw_background_sprites()
  draw_smoke()
  baddie_m.draw()

  player_attack()
  draw_arrows()
  draw_player()

  draw_foreground_sprites()

  if darkrooms then
    darkroom()
  else
    palt(0, false)
    palt(14, true)
  end
  draw_player_interact_icon()
  draw_inventory()
  tb_draw()  
  draw_circle()

  if not darkrooms then
    pb(get_current_room(), mapx + 106, mapy + 121, 10)
    -- pb("cx:" .. cur_room_x, mapx + 106, mapy + 106, 10)
    -- pb("cy:" .. cur_room_y, mapx + 106, mapy + 114, 10)
    pb("px:" .. flr(p.x) .. ", " .. "py:" .. flr(p.y), mapx + 2, mapy + 2, 7)
    pb("mx:" .. mapx / 128 .. ", my:" .. mapy / 128, mapx + 2, mapy + 9, 7)
    pb("cx:" .. cur_room_x .. ", cy:" .. cur_room_y, mapx + 2, mapy + 16, 7)
    circ(p.x + 2, p.y, l_rad, 3)
    pb("cpu:" .. stat(1), mapx + 97, mapy + 2, 7)
    pb("mem:" .. stat(0), mapx + 85, mapy + 8, 7)
  end


end