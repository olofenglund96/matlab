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

E_f = @(k, m) (hbar*k)^2/(2*m*e); % Fermi energy

lam_ph = @(E) h*c/(E*e); % Photon wave length
lam_db = @(m, v) h/(m*v); % De Broglie wave length
v = @(E, m) sqrt(2*E*e/m); % Velocity from kinetic energy

FE = @(Ef, E, T) 1./(exp((E-Ef)./(KB.*T))+1);

V = @(r) -e/(4*pi*ep0*r);

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

% b
