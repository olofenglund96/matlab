function syst2 = syst2(f);
% amplitudmodulation (utan b�rv�g)
% F�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
global t
global DELTAT
syst2=f.*sin(13*t);
