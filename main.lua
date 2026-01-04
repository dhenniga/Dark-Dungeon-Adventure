BTN_L, BTN_R, BTN_U, BTN_D, BTN_X, BTN_O, dungeon, sewer, pit, reading, allow_movement, raindrops = 0, 1, 2, 3, 4, 5, "128,7,139,132,5,6,135,4,137,138,9,143,13,14,15", "129,7,131,130,129,131,135,132,137,139,9,4,1,14,5", "0,7,139,132,128,130,135,4,137,138,9,143,129,14,15", false, true, false

music_enabled = false
collision_state = false
darkrooms = true
player_light_enabled = true
local t = {
  dungeon = 20,
  sewer = 41,
  pit = 42
}

local lanturn_timer = 0

function palette(s)
  for i, v in ipairs(split(s, ",")) do
    pal(i, v + 0, 1)
  end
end

function _init()
  cartdata("davidhennigan_dark_dungeon_1")
  p.x, p.y, p.remaining_hearts, p.keys = 68, 16, 5, 2
  t_increment = 1
  cls()
  decode_tiles()
  init_rain()
  poke(0x5f2e, 1)
end

last_palette_sfx = nil

function play_palette_sfx()
  if current_palette == last_palette_sfx then return end
  last_palette_sfx = current_palette

  if not music_enabled then
    sfx(t[current_palette], 2)
  end
end

function _update60()
  if music_enabled then
    if stat(53) == -1 then
      sfx(t[current_palette], 3)
    end
  end
  -- this loops the music
  if music_enabled and not stat(57) then
    music(0)
  end

  play_palette_sfx()
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
  draw_alert()
end

alert_txt = nil
alert_t = 0

function chest_alert(t)
  alert_txt = t
  alert_t = 0
end

function draw_alert()
  if not alert_txt then return end
  alert_t += 1

  local y = alert_t < 30 and outcubic(alert_t, -12, 12, 30)
      or alert_t < 150 and 0
      or alert_t < 180 and outcubic(alert_t - 150, 0, -12, 30)

  if not y then
    alert_txt = nil return
  end

  rectfill(mapx, mapy + y, mapx + 127, mapy + y + 11, 1)
  pb(alert_txt, mapx + 64 - #alert_txt * 2, mapy + y + 4, 9)
end