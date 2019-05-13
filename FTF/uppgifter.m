%% Constants
c = 299792458;          % Speed of light
h = 6.626068E-34;       % Plank's constant
hbar = h/(2*pi);        % h bar
e = 1.60217653E-19;    % Electron charge
G =	6.6742E-11;         % Gravitational constant
KB = 1.3806505E-23;     % Boltzman constant
mu0 = 4*pi*1E-7;        % Permeability of free space
ep0 = 1/(mu0*c*c);      % Permativity of free space
fs = 1 / 137.0359895;   % Fine structure constant

me = 9.1093826E-31;     % Electron rest mass
mn = 1.67492728E-27;    % Neutron rest mass
mp = 1.67262171E-27;    % Proton rest mass
u = 1.660539040E-27; % Atomic mass unit

NA = 6.0221367E23;      % One mole
a0 = 5.29177E-11;       % Bohr radius
R = NA*KB;              % Gas constant
ys = 365.2564*24*60*60; % Year in seconds
Ri = 10973731.6;

epsi = 11.8; % relative permeability of Si

E_f = @(k, m) (hbar*k)^2/(2*m*e); % Fermi energy

lam_ph = @(E) h*c/(E*e); % Photon wave length
lam_db = @(m, v) h/(m*v); % De Broglie wave length
v = @(E, m) sqrt(2*E*e/m); % Velocity from kinetic energy

FE = @(Ef, E, T) 1./(exp((E-Ef)./(KB.*T))+1);

V = @(r) -e/(4*pi*ep0*r);

a0s = @(em, epr) 4*pi*hbar^2*ep0*epr/(e^2*em*me); % effective bohr radius

Nc = @(eme, T) 2*(2*pi*eme*KB*T/(h^2))^(3/2) % const for electron concentration
Nv = @(emh, T) 2*(2*pi*emh*KB*T/(h^2))^(3/2) % const for hole concentration

%% 9
%a
1/(exp(1)+1)
%b
1/(exp(-1)+1)
%c
log(1/0.99-1)*KB*77/eV

%% 10
%a
t = 273;
Ef = 1;
E = linspace(0, 2);
plot(FE(Ef, E, t), E);
axis([0 2 0 2]);

%% 14
%a
n = 4.7e28;
Ef = h^2/(2*me)*(3*n/(8*pi))^(2/3)
vf = sqrt(2*Ef/me)
%b
vth = sqrt(3*KB*300/me)
%c
vd = -100*1.05e7/(eV*n)
%d
l = vf*1.05e7*me/(eV^2*n)

%% 24
% a
E = E_f(8.45e28, me)
vf = v(E, me)
l = lam_db(me, vf)

% b
kf = 2*pi/l
ka = pi/2.09e-10

% c Vad har braggspridning med något att göra?

%% 25
% a
a = 0.25e-9
n =(1/(0.25e-9))
n3 = 3*n
n4 = 4*n
%1D
k3 = pi*n3/2
k4 = pi*n4/2
E3 = E_f(k3, me)
E4 = E_f(k4, me)
% b
k31 = k3
k32 = k3*2
E31 = E_f(k31, me)
E32 = E_f(k32, me)

%% 26
% a
%kf as function of fermi energy
2*sqrt(7e-19*2*me/hbar^2)
%kf in 3D
n_cu = 8.45e28;
k = 2*(3*pi^2*n_cu)^(1/3) % r�tt

% b
v = 3560;
f = v*k
E = hbar*f/e

% c
E_fermi = E_f(k/2, me)
qu = E/E_fermi

%% 27
% a
img = imread('FTF/Capture.PNG');
hold on;
imshow(img)
Ef = -0.367;
El = -0.22;
del_E = El-Ef
del_E_eV = 13.6*del_E
refline(0, 254);
line([183,183],[0,length(img)])
refline(0, 192);

%% 31

% c
n = 1e19;
p = 1e20;
mu_h = 0.455/(e*(10*n+p))
mu_p = 0.455/(e*(n+p/10))

% d
ni = sqrt(n*p)

%% 32


a0sp = a0s(0.066, 12.4)

1/(2*a0sp)^3 %2*radien

%% 33
n = 1e20;
eme_si = 0.26*me
emh_si = 0.69*me
N_c = Nc(eme_si, 300)
N_v = Nv(emh_si, 300)

Ed = -KB*300*log(n/N_c)/e

%% 34
sigm = 1/9e-3
RH = -3.9e-4
mu = -sigm*RH % a
n = -1/(RH*e)
N_c = Nc(eme_si, 300)
Ed = -KB*300*log(n/N_c)/e
FE(0, Ed*e, 300)


%% 35
n = 5e22;
delE1 = 0.05*e;
T1 = -delE1/(KB*log(n/Nc(me, 300)))

delE2 = 0.2*e;
T2 = -delE2/(KB*log(n/Nc(me, 300)))

%% 36
mu = 0.15;
p = 0.05
n = 1/(mu*p*e)
pp = 0.06
np = 1/(mu*pp*e)
na = n-np

%% 38
Eg = -2*KB*410*log(1/100)/e

%% 39
NAm = 1e22;
NAmm = 1e22/((1000)^3)

Z = 8*pi*(1e-3)^3*(2*me)^(3/2)*(3*KB*300)^(3/2)/(3*h^3)

vth = sqrt(3*KB*300/(me))
l = 0.048*me*vth/e

%% 41
E = h*c/(1800e-9*e)

%% 42
I0 = 10E-9*(exp(-e*10/(KB*300))-1)^(-1)

I = @(U) I0*(exp(e*U/(KB*300))-1);
I(0.1)
I(0.3)
I(0.5)

%% 43
I0 = 1E-3*(exp(e*0.7/(KB*300))-1)^(-1)
U = KB*300*log(100e-3/I0 + 1)/e

%% 47
ND = 1e21;
NA = 1e22;
ni = 1e16;
phi_0 = KB*300*log(ND*NA/(ni^2))/e
xn = sqrt(2*ep0*11.8*phi_0*NA/(e*(NA+ND)*ND))
xp = ND*xn/NA

U = phi_0 - (2*(xn+xp))^2*e*NA*ND/(2*ep0*11.8*(NA+ND))

%% 48
ND = 1e21;
NA = 1e22;
ni = 1e16;
phi_0 = KB*300*log(ND*NA/(ni^2))/e
xn = sqrt(2*ep0*epsi*phi_0*NA/(e*(NA+ND)*ND))
xnp = 0.8*xn;
phi_0p = xnp^2*e*(NA+ND)*ND/(2*ep0*epsi*NA)
phi_0-phi_0p

%% 49
ND = 1e22;
NA = 1e23;

phi_0 = 0.42;
xp = sqrt(2*ep0*16.3*phi_0*ND/(e*(NA+ND)*NA))
em = e*NA*xp/(ep0*16.3)

ebr = sqrt(NA*ND/(NA+ND))

%% 50
ND = 1.7e21;
NA = 3.7e23;
ni = 2.4e19;
phi_0 = KB*300*log(ND*NA/(ni^2))/e
np0 = ND*exp(-e*phi_0/(KB*300))
pn0 = ni^2*exp(-e*phi_0/(KB*300))/np0

np0 = ND*exp(-e*(phi_0-0.1)/(KB*300))

%% 51
C = 86.3e-12;
phi_0 = 1.76;
U = 1;
A = 2*(phi_0-U)/(ep0*12*e)

%% 53
ND = 1e22;
w = sqrt(0.3*2*ep0*epsi/(e*ND))
e0 = e*ND*2*w/(2*ep0*epsi)
q = w*ND

%% EXTENTA
%% 1
% b
NA = 1e22;
EfEv = KB*300*log(Nv(0.69*me, 300)/NA)/e

% c
mh = 0.69*me;
muh = 0.048;
l = sqrt(3*KB*300*mh)*muh/e

% d
n = Nc(0.26*me, 300)*Nv(0.69*me, 300)*exp(-(1.12*e)/(KB*300))/NA
np = n + NA*0.001
np/n

% 2
% a
lam = h*c/(4.1*e)
% b
Ef0 = 0.3*e;
n = Nc(0.35*me, 300)*exp(Ef0/(KB*300))


%% 2
% a
delK = 2*pi/(15*0.5e-9)

%% 5
% a
NA = 1e24;
ND = 1e22;
W = 30e-6;
L = 10e-6;
a = 1e-6;
ni2 = Nc(0.26*me, 300)*Nv(0.69*me, 300)*exp(-1.12*e/(KB*300))
phi0 = KB*300*log((NA*ND)/ni2)/e
w = @(U) sqrt(2*ep0*epsi*(phi0-U)*(NA+ND)/(e*NA*ND))
w(0)
sigm = e*ND*0.135

I = sigm*0.2*2*(a-w(0))*W/(L)
