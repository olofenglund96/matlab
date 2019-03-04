%% Calculate w
R = 4.19*10^-2;
phi = 1.19*10^-2;

w = pi*(phi/2)^2/R^2

%% Calculate I
e = 0.22E-2;
n = 10.177;
n_0 = 0.8467;
t = 276E-6;
I = (4*pi/(e*w))*(n/(1-n*t) - n_0/(1-n_0*t))