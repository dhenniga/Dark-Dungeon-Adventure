-- Tween
function asin(x)
  local n = x < 0 and 1 or 0
  x = abs(x)
  local rad = 1.57079 - sqrt(1 - x) * (((-.01873 * x + .07426) * x - .21211) * x + 1.5707)
  return rad - 2 * n * rad
end

function outelastic(t, b, c, d, a, j)
  if t == 0 then return b end
  t /= d
  if t == 1 then return b + c end
  j = j or d * .3
  local s
  if not a or a < abs(c) then
    a = c
    s = j / 4
  else
    s = j / 6.28318 * asin(c / a)
  end
  return a * 2 ^ (-10 * t) * sin(-(t * d - s) / j) + c + b
end

function outcubic(t, b, c, d)
  t = t / d - 1
  return c * (t * t * t + 1) + b
end

function inCubic(t, b, c, d)
  return c * (t / d) ^ 3 + b
end

-- function inOutCubic(t, b, c, d)
--   t = t / d * 2
--   if (t < 1) return c / 2 * t * t * t + b
--   t = t - 2
--   return c / 2 * (t * t * t + 2) + b
-- end

-- function linear(t, b, c, d)
--   return c * t / d + b
-- end