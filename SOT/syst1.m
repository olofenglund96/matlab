function syst1 = syst1(f);
%
% F�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
global t
global DELTAT
h=exp(-abs(t));
syst1=falt(h,f);
