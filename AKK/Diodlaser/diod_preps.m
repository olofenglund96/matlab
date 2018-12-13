c = 299792458;
h = 6.62607004e-34;
u0 = 1.660539040e-27;
lam = 780.2e-9;
nat_w = 1/(2*pi*26e-9);
w0 = 1/lam;
T1 = 20+273;
T2 = 120+273;
M = 85.4678*u0;
kb = 1.38064852e-23;
u = @(T) sqrt(2*kb*T/M);
e = 1.602e-19;
dop_w = @(T) 1.7*u(T)/lam
w_T1 = dop_w(T1)
w_T2 = dop_w(T2)

fsr = c/(2*1.511*0.109);

%% img

img = imread('peak_plot.png');
img = imrotate(img, -90);
image(img);

%% lab
d = 10e-2;
fsr = c/(2*1.51075*d)
fsr_def = fsr/188;

diff = 7*fsr;

x = 5.5e-2;
I0 = 218;
I = 202;
fwhm = 164*fsr_def;

mu = -log(I/I0)/x
G1G2 = 4/3;
n = (8*pi*26e-9*mu*fwhm*G1G2)/lam^2



%%