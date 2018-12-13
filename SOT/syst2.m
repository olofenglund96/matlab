function syst2 = syst2(f);
% amplitudmodulation (utan bärvåg)
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
syst2=f.*sin(13*t);
