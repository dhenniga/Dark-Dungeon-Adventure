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
      -- sfx(46, 1)
    end

    if o.flags.coin and collision(o) then
      sfx(52, 3)
      del(active_objects, o)
    end
  end
end

function update_chests()
  for o in all(active_objects) do
    if o.flags.chest and on(o.text) and o.active == false then
      o.flags.solid = true
      o.active = true
      boom(o.x, o.y, 13, 5, 10, 7, 8)
    end
    if o.flags.s_shoot_v and on(o.text) then
      o.active = false
    end
  end
end