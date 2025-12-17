-- -- smoke
particles = {}

function smoke_particle(x, y, r, a, col1, col2, g)
  add(
    particles, {
      x = x, y = y,
      dx = rnd(.4) - .2,
      dy = -rnd(.4),
      r = r, age = a,
      maxage = 50,
      col1 = col1, col2 = col2,
      g = g
    }
  )
end

function update_smoke()
  for p in all(particles) do
    if p.age >= p.maxage then
      del(particles, p)
    else
      p.dy += p.g
      p.x += p.dx
      p.y += p.dy
      p.age += 1
    end
  end
end

function draw_smoke()
  for p in all(particles) do
    drawparticle(p)
  end
end

function drawparticle(p)
  local a = (p.age - 5) / p.maxage
  a = 1 - a * a
  a = mid(0, a, 1)
  local r = p.r * a
  circfill(p.x, p.y - 2, r, p.col1)
  circfill(p.x, p.y + 2, r, p.col2)
end

function boom(x, y, c1, c2, c3, c4, scale)
  for i = 1, 20 do
    smoke_particle(x + rnd(16), y + rnd(16), rnd(scale), i - 20, c1, c2, 0)
    smoke_particle(x + rnd(16), y + rnd(16), rnd(3), i, c3, c4, .01)
  end
end

function sparkles(x, y, a)
  for i = 1, a do
    -- smoke_particle(x + rnd(8), y + rnd(8), 3, 20 - i, 11, 9, 0.01) -- fire
    -- smoke_particle(mapx + rnd(128), mapy + rnd(128), 1, 20 - i, 5, 1, 0.005) -- flies
    -- smoke_particle(x, y, rnd({ 1, 2, 3 }), i, rnd({ 4, 8 }), rnd({ 4, 8 }), 0.005) -- broken pot
  end
end

function poison_flames(x, y)
  for i = 1, 1 do
    smoke_particle(x + rnd(8), y + rnd(8), 5, 20 - i, 10, 3, 0.01)
  end
end

function fire_flames(x, y)
  for i = 1, 1 do
    smoke_particle(x + rnd(8), y + rnd(8), 5, 20 - i, 11, 9, 0.02)
  end
end