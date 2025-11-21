pi = 3.14159
function asin(x)
  local n = x < 0 and 1 or 0
  x = abs(x)
  local r = 1.57079 - sqrt(1 - x) * (((-.01873 * x + .07426) * x - .21211) * x + 1.5707)
  return r - 2 * n * r
end

function outelastic(t, b, c, d, a, p)
  if t == 0 then return b end
  t /= d
  if t == 1 then return b + c end
  p = p or d * .3
  local s
  if not a or a < abs(c) then
    a = c
    s = p / 4
  else
    s = p / 6.28318 * asin(c / a)
  end
  return a * 2 ^ (-10 * t) * sin(-(t * d - s) / p) + c + b
end

function inoutcubic(t, b, c, d)
  t /= d / 2
  if t < 1 then return c / 2 * t * t * t + b end
  t -= 2
  return c / 2 * (t * t * t + 2) + b
end

function outcubic(t, b, c, d)
  t = t / d - 1
  return c * (t * t * t + 1) + b
end