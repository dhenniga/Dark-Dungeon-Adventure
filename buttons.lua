-- buttons

function trigger(e)
  events[e] = true
end

function on(e)
  return events[e]
end

function update_buttons()
  for o in all(active_objects) do
    if o.flags.button and collision(o) and not o.pressed then
      o.pressed = true
      trigger(o.text)
      sfx(50, 3)
    end
  end
end

function update_events()
  for o in all(active_objects) do
    local ox, oy = mapx + (o.x or 0), mapy + (o.y or 0)
    if o.flags.chest and on(o.text) and o.active == false then
      o.flags.solid = true
      o.active = true
      boom(ox, oy, 13, 5, 10, 7, 8)
    end
    if o.flags.s_shoot_v and on(o.text) then
      o.active = false
    end

    if o.flags.stairs_up and on(o.text) and o.active == false then
      boom(ox, oy, 13, 5, 10, 7, 8)
      o.active = true
    end
  end
end