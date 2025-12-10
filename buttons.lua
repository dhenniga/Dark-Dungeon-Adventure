-- buttons

function trigger(e)
  events[e] = true
end

function on(e)
  return events[e]
end

function update_buttons()
  for o in all(active_objects) do
    if o.flags.button and obj_collision(o) and not o.pressed then
      o.pressed = true
      trigger(o.text)
      sfx(50,3)
    end
  end
end

function update_chests()
  for o in all(active_objects) do
    if o.flags.chest and on(o.text) then
      o.active = true
      o.solid = true
    end
  end
end