function syst3 = syst3(f);
% �vning 9.10
% F�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
%
global t
global DELTAT
h=(t>0)-(t>1);
syst3=falt(h,f);
