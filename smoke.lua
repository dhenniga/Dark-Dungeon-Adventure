-- smoke
particles = {}

function smoke_particle(_x, _y, _c, _r, _life, _age)
  local new = {
    x = _x,
    y = _y,
    dx = -0.2 + rnd(0.4),
    dy = -rnd(0.7),
    r = _r,
    age = _age,
    maxage = _life,
    col = _c
  }

  add(particles, new)
end

function update_smoke()
  for p in all(particles) do
    if p.age >= p.maxage
        or p.y > 128
        or p.y < 0
        or p.x > 128
        or p.x < 0 then
      del(particles, p)
    else
      if p.age >= 0 then
        p.x += p.dx
        p.y += p.dy
      end
      p.age += 1
    end
  end
end

function drawparticles()
  for p in all(particles) do
    if p.age >= 0 then
      drawparticle(p)
    end
  end
end

function drawparticle(p)
  local agemult = 1
  local col
  agemult = (p.age - 5) / p.maxage
  agemult = 1 - (agemult * agemult)
  agemult = mid(0, agemult, 1)
  col = p.col[mid(#p.col, p.age, 1)]
  circfill(p.x, p.y, p.r * agemult, col)  
  circ(p.x, p.y, p.r * agemult, 2)
end

function boom(_x, _y)
  local x1, x2, y1, y2, angle
  for i = 0, 10 do
    smoke_particle(
      _x - 8 + rnd(28), --x
      _y - 8 + rnd(28), --y
      {3,4,5,6,7,8,9}, -- colour table
      2 + rnd(7), 
      50, 
      i
    )
  end
end