%% D1
format short
p = [1 11 3 183 144 756];
r = roots(p);
zero = polyval(p, r)

%% D2
r = [-8 -5 3 6];
p = poly(r);
x = linspace(-50, 50, 1000);
y = polyval(p, x);
plot(x, y);
grid on

%% D3
f = @(x) 2*sin(3*x) + 1.2.^x;
x = linspace(1, 5);
I = integral(f, 1.7, 3.4)
plot(x, f(x));

%% D4
f = @(x) cos(exp(x))./(1-x);
x = linspace(2, 3, 1000);
[minx1, miny1] = fminbnd(f, 2, 2.7)
[minx2, miny2] = fminbnd(f, 2.7, 3)
plot(x, f(x), 'r');
grid on;

%% D5
f = @(x) 2*exp(-x.^2) - 9*x.^2 + 2*x;
g = @(x) -f(x);
x = linspace(-1, 1, 1000);
plot(x, g(x));
grid on
[maxX, maxY] = fminbnd(g, -1, 1);
maxX
maxY = -maxY
zero1X = fzero(f, -0.3)
zero2 = fzero(f, 0.5)

%% D6
M = eye(9, 9) * 4;
V = ones(8, 1)*3;
M = M + diag(V, -1) + diag(V, 1);
d = det(M)

%% D7
m = complexmat(5, -2+i, 1-i)

%% D8
z = 0.5; %% konv
z = 1.1; %% div
z = 0.5 + 0.5*i; %% konv

%% D9
M = complexmat(1000, -1.4+0.48i, -1.1+0.24i);
f = @(x) converge(x);
A = arrayfun(f, M);
image(A)
