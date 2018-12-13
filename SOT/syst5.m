function syst5 = syst5(f);
% övning 9.10
% För datorövning 2 i Lineära analys för D
% SSp 1.12.96
global t
global DELTAT
h = exp(-0.2*t).*(3*sin(3*t)+0.4*cos(3*t)).*(t>0);
syst5 = falt(h,f);
