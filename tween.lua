pi = 3.14159265358979

--- 𝘤os now uses radians
cos1 = cos function cos(angle) return cos1(angle/(3.1415*2)) end
--- 𝘴in now uses radians
sin1 = sin function sin(angle) return sin1(-angle/(3.1415*2)) end

--- 𝘪mplementation of asin.
-- 𝘴ource converted from 
-- http://developer.download.nvidia.com/cg/asin.html
function asin(x)
  local negate=(x<0 and 1.0 or 0.0)
  x=abs(x)
  local ret=-0.0187293
  ret*=x
  ret+=0.0742610
  ret*=x
  ret-=0.2121144
  ret*=x
  ret+=1.5707288
  ret=pi*0.5-sqrt(1.0-x)*ret
  return ret-2*negate*ret
end

--- 𝘪mplementation of acos.
-- 𝘴ource converted from 
-- http://developer.download.nvidia.com/cg/acos.html
function acos(x)
  local negate = (x<0 and 1.0 or 0.0)
  x=abs(x);
  local ret=-0.0187293;
  ret*=x;
  ret+=0.0742610;
  ret*=x;
  ret-=0.2121144;
  ret*=x;
  ret+=1.5707288;
  ret*=sqrt(1.0-x);
  ret-=2*negate*ret;
  return negate*pi+ret;
end

--- 𝘧unction for calculating 
-- exponents to a higher degree
-- of accuracy than using the
-- ^ operator.
-- 𝘧unction created by samhocevar.
-- 𝘴ource: https://www.lexaloffle.com/bbs/?tid=27864
-- @param x 𝘯umber to apply exponent to.
-- @param a 𝘦xponent to apply.
-- @return 𝘵he result of the 
-- calculation.
function pow(x,a)
  if (a==0) return 1
  if (a<0) x,a=1/x,-a
  local ret,a0,xn=1,flr(a),x
  a-=a0
  while a0>=1 do
      if (a0%2>=1) ret*=xn
      xn,a0=xn*xn,shr(a0,1)
  end
  while a>0 do
      while a<1 do x,a=sqrt(x),a+a end
      ret,a=ret*x,a-1
  end
  return ret
end

--

function outelastic(t,b,c,d,a,p)
  if (t==0) return b
  t/=d
  if (t==1) return b+c
  p=p or d*0.3
  local s

  if not a or a<abs(c) then
    a=c
    s=p/4
  else
    s=p/(2*pi)*asin(c/a)
  end

  return a*pow(2,-10*t)*sin((t*d-s)*(2*pi)/p)+c+b
end

--

function in𝘰ut𝘤ubic(t,b,c,d)
  t=t/d*2
  if (t<1) return c/2*t*t*t+b
  t=t-2
  return c/2*(t*t*t+2)+b
end

function out𝘤ubic(t,b,c,d)
  return c*(pow(t/d-1,3)+1)-b
end