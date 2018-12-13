function bil = bil(f);
%
global t
global DELTAT
h = exp(-0.2*t).*(3*sin(3*t)+0.4*cos(3*t)).*(t>0);
bil = falt(h,f);
