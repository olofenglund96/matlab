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

I = @(I0, T, U) I0*(exp(e*U/(KB*T))-1);

%%

U = linspace(4e-3, 10e-3);
hold on;
plot(U, I(1, 6, U));
plot(U, I(1, 5, U));

%%
ir_lam = h*c/(2*e)

%% Laborationsgrejer!
%% Kap
M = csvread('pn_kap.csv', 1, 0);
U = M(:,1);
C2 = M(:,3);

plot(U, C2, 'o')
axis([-0.6 1.2 0 0.004])
phi0 = 0.0023/0.0021

%% Emission
% IR
dat = importdata('ir_em.txt', '\t', 1);
dat = dat.data;
ir_lam = dat(:,1);
ir_I = dat(:,2);

% Gul
dat = importdata('gul_em.txt', '\t', 1);
dat = dat.data;
gul_lam = dat(:,1);
gul_I = dat(:,2);

%% Absorption
dat = importdata('gul_abs.txt', '\t', 1);
dat = dat.data;
gul_abs_lam = dat(:,1);
gul_abs_I = dat(:,2);

%% Absorption lampa
dat = importdata('abs_back.txt', '\t', 1);
dat = dat.data;
lamp_abs_lam = dat(:,1);
lamp_abs_I = dat(:,2);

%% Plot

plot(lamp_abs_lam, lamp_abs_I);
figure();
hold on;
plot(ir_lam, ir_I, 'r');
plot(gul_lam, gul_I, 'b');
hold off;
figure();
hold on;
plot(gul_lam, gul_I, 'r');
plot(gul_abs_lam, gul_abs_I, 'b');
axis([400 750 0 1])
legend('Emission', 'Absorption');
hold off;

%% Energi
Eabs = h*c./(gul_abs_lam*1e-9);
Eem = h*c./(gul_lam*1e-9);
T = 293;
Fe = exp(-Eabs./(KB*T));
Z = Fe.*gul_abs_I/e;
hold on;
plot(Z, gul_abs_I);
%plot(Eem, gul_I);
axis([0 0.01 0 1])
