function syst1 = syst1(f);
%
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
h=exp(-abs(t));
syst1=falt(h,f);
