function integrator = integrator(f);
%
global t
global DELTAT
integrator = cumsum(f)*DELTAT;

