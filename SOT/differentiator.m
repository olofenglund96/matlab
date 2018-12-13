function derivator = derivator(f);
%
global t
global DELTAT
d = diff(f);
derivator =  [d(1) d]/DELTAT;


