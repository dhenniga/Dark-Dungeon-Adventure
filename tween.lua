pi=3.14159265358979
cos1=cos function cos(a)return cos1(a/(pi*2))end
sin1=sin function sin(a)return sin1(-a/(pi*2))end

function asin(x)
 local n=x<0 and 1 or 0
 x=abs(x)
 local r=-0.0187293
 r=r*x+0.0742610
 r=r*x-0.2121144
 r=r*x+1.5707288
 r=pi/2-sqrt(1-x)*r
 return r-2*n*r
end

function acos(x)
 local n=x<0 and 1 or 0
 x=abs(x)
 local r=-0.0187293
 r=r*x+0.0742610
 r=r*x-0.2121144
 r=r*x+1.5707288
 r*=sqrt(1-x)
 r-=2*n*r
 return n*pi+r
end

function pow(x,a)
 if a==0 then return 1 end
 if a<0 then x,a=1/x,-a end
 local r,a0,xn=1,flr(a),x
 a-=a0
 while a0>=1 do
  if a0%2>=1 then r*=xn end
  xn,a0=xn*xn,shr(a0,1)
 end
 while a>0 do
  while a<1 do x,a=sqrt(x),a+a end
  r,a=r*x,a-1
 end
 return r
end

function outelastic(t,b,c,d,a,p)
 if t==0 then return b end
 t/=d
 if t==1 then return b+c end
 p=p or d*0.3
 local s
 if not a or a<abs(c)then a=c s=p/4 else s=p/(2*pi)*asin(c/a)end
 return a*pow(2,-10*t)*sin((t*d-s)*(2*pi)/p)+c+b
end

function inoutcubic(t,b,c,d)
 t=t/d*2
 if t<1 then return c/2*t*t*t+b end
 t-=2
 return c/2*(t*t*t+2)+b
end

function outcubic(t,b,c,d)
 return c*(pow(t/d-1,3)+1)-b
end
