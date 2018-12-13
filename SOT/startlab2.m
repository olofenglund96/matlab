% Initieringar för datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
global N
N = 9;
DELTAT = 20/2^(N-1);
t = -(2^(N-1)-1)*DELTAT:DELTAT:2^(N-1)*DELTAT;
delta = (t==0)/DELTAT;
theta = 1*(t>0);

