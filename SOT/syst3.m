function syst3 = syst3(f);
% övning 9.10
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
%
global t
global DELTAT
h=(t>0)-(t>1);
syst3=falt(h,f);
