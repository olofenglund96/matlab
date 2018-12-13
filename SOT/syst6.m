function syst6 = syst6(f);
% övning 9.8
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
[tau1,t1]=meshgrid(t,t);
k = zeros(size(tau1));
k=(t1.^2-tau1.^2).*(t1>tau1);
syst6 = (f*k')*DELTAT;
