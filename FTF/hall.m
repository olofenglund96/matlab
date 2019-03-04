M = csvread('hallmeasure.csv', 1, 0);
In = fliplr(M(:,1))
Un = fliplr(M(:,2))

B = @(I) 6.31e-3 + 0.233*I + 31.4e-3.*I.^2 - 13.0e-3.*I.^3;
Bn = B(In)
p = polyfit(Un, B(In), 1)

x = linspace(-0.02, 0.16, 1000);
f = polyval(p, x);
hold on;
plot(Un, B(In), 'o')
plot(x, f);
legend('mätdata', 'linjär anpassning')

n = 1e-3/(p(1)*1.5e-6*e)

%% Skärning
dat = importdata('halvledarkonduktivitet');
U = dat(:,2);
T = dat(:,1);
Ut = log(1./U);
Tt = 1./T;

linear_Ut = Ut(67:300)
linear_Tt = Tt(67:300)

max = 5.968;
max_Ut = ones(1000)*max;

k = polyfit(linear_Tt, linear_Ut, 1)
x = linspace(0.003, 0.012, 1000);
f = polyval(k, x);

Tt_cross = (max-k(2))/k(1)
T_cross = 1/Tt_cross

hold on;

plot(Tt, Ut, 'r');
plot(Tt_cross, max, 'o')
plot(x, f, 'g');
plot(x, max_Ut(), 'magenta');
axis([3e-3 12e-3 4.5 6.5])
legend('mätdata', 'skärningspunkt')

%% Bestäm Ea
k = 309.12;
kb = 1.380658e-23;
Ea = 2*KB*k/e

%% Bestäm p
Nv = 2*(2*pi*KB*T_cross*0.69*me/(h^2))^(3/2)
p = Nv*exp(-Ea*e/(KB*T_cross))

%% Resistans i järntråd
M = csvread('konduktivitet.csv', 2, 0);
I = fliplr(M(:,1));
U = fliplr(M(:,2));
R = U./I
T = fliplr(M(:,3));
plot(T, R, 'o');

%%
KB*200/e