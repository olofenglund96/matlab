function lpfilter = lpfilter(f);
% F�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
global t
global DELTAT
h=exp(-t).*(t>0);
lpfilter = falt(h,f);


