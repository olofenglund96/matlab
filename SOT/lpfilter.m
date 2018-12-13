function lpfilter = lpfilter(f);
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
h=exp(-t).*(t>0);
lpfilter = falt(h,f);


