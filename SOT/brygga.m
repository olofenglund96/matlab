function brygga = brygga(f);
% 
global t
global DELTAT
h = 2*exp(-t).*(t>0);
brygga = falt(h,f)-f;
