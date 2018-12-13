%% 2.2

K = 1:100;
t = -10:0.05:10;
cnoll = 3*pi/4;
akoeff = 1/pi * ((-1).^K - 1) ./ (K.^2);
bkoeff = 1./K;
ymin = -0.5;
ymax = 4;

visaserie(cnoll, akoeff, bkoeff, ymin, ymax);

%% 2.3

K = 1:100;
t = -2*pi:0.05:2*pi;
cnoll = 2;
akoeff = (2.*(((-1).^K).*sin(2*K))) ./ (K);
bkoeff = 0*K;
ymin = -2*pi;
ymax = 2*pi;

visaserie(cnoll, akoeff, bkoeff, ymin, ymax);