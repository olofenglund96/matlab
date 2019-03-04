%% Const
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

Ej = @(z, n, d) -h*c*Ri*z^2/(e*(n-d)^2);
El = @(l) h*c/(l*10^-9)/e;
lR = @(n, m)  Ri*(1/n^2 - 1/m^2)

%% EX1 Upg 1c
E2p = Ej(1, 2, 0.045)

E2s_2p = h*c/(670.8e-9)/e

E2s = E2s_2p - E2p

%% - Upg 2a

El(323.266)
El(610.353)
El(610.366)
El(670.776)
El(670.791)
El(812.623)
El(812.645)

%% - AF uppgifter
Ej(1, 51, 0)

%% FTF 17
n = 8.45e28;
Ef = h^2/(2*me)*(3*n/(8*pi))^(2/3)/e
Cv = 3*n*KB
Cv_kg = Cv/(9e3)

Cvv = (pi^2)*KB^2*300*n/(Ef*e)/2
perc = Cvv/Cv

%% 18
n = 3*0.5*1.99e30/(4*pi*4.0026*u*10^21)
Ef = h^2/(2*me)*(3*n/(8*pi))^(2/3)
Tf = 10^-14/KB
