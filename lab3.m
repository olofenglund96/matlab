%% D1
fprime = @(t, f) 8.*t + 1.3.^t - 2*f.^2;
[t, f] = ode45(fprime, [3 6], 6);
plot(t, f);
wrongSolution = f(8) % ger det åttonde värdet i vektorn f, inte f(8) rent matematiskt
solution = f(end)
%% D2
x = [ 0.000 1.000 2.000 3.000 4.000 5.000 ];
y = [ 3.749 4.689 6.273 5.897 6.381 7.003 ];
hold on;
plot(x, y, 'o');
p = polyfit(x, y, length(x)-1)
a = linspace(-10, 10);
plot(a, polyval(p,a));
%%
axis([0 5 3 8]);
h = polyfit(x, y, 1);
plot(a, polyval(h,a), 'b');

%% D3

x = [ 0.10 0.20 0.30 0.40 0.50 0.60 0.70 0.80 0.90 1.00 1.10 1.20 1.30 1.40 1.50 ];
y = [ 1.60 1.91 1.91 2.33 2.17 2.64 2.44 2.56 2.55 2.60 3.20 3.06 3.15 2.98 3.46 ];

p = polyfit(x, exp(y), 1);
hold on;
plot(x, y, 'o');
f = @(z)log(p(1).*z + p(2));
z = linspace(0, 2);
plot(z, f(z));

%% D4
v = csvread('race.txt');
x = linspace(0, 40, length(v));
size(v);
v(1);
l = v(450);
plot(x, v);

%% D5
v = csvread('race.txt');
v(v > 80) = v(find(v>80) -1);
%v(find(v>80)) = []
x = linspace(0, 40, length(v));
plot(x, v);
maxSpeed = max(v);

%% D6
v = csvread('race.txt');
v(v > 80) = v(find(v>80) -1);
x = linspace(0, 40, length(v));
s = trapz(x, v)
vel = s/40

%% D7
v = csvread('const_accel.txt');
t = linspace(0, 5, length(v));
plot(t, v, 'r');
l = v(450);

%% D8
v = csvread('const_accel.txt');
t = linspace(0, 5, length(v));
plot(t, v, 'r');
p = polyfit(t, v.', 1);
accel = p(1);

%% D9
F = @(v) 4*1171.42/0.3515 - 0.24*1.29*2.4.*(v.^2)/2;
v = linspace(0, 5);
F(30)

%% D10
F = @(v) 4*1171.42/0.3515 - 0.24*1.29*2.4.*(v.^2)/2;
v = linspace(0, 5);
a = @(t, v) F(v)./2107.98;
[x, y] = ode23(a,[0 3], 0);
plot(x, y);
I = y(end)

%% D11
l
I

% Skillnaden beror på att förhållandena i verkligheten aldrig är ideella