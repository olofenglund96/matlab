function syst5 = syst5(f);
% �vning 9.10
% F�r dator�vning 2 i Line�ra analys f�r D
% SSp 1.12.96
global t
global DELTAT
h = exp(-0.2*t).*(3*sin(3*t)+0.4*cos(3*t)).*(t>0);
syst5 = falt(h,f);
