% Initieringar f�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
global t
global DELTAT
global N
N = 9;
DELTAT = 20/2^(N-1);
t = -(2^(N-1)-1)*DELTAT:DELTAT:2^(N-1)*DELTAT;
delta = (t==0)/DELTAT;
theta = 1*(t>0);

