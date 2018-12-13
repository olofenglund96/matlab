%% Divergens
L = [50 77 129 179 226];
D = [20 30 50 70 90];
theta = atand((D/2)./L)
avg = mean(theta)
plot(L, D/2, 'o')

%% Gauss
a = 126;
b = 118;
f = 60;
f1 = 1/a + 1/b
f2 = 1/f
f1-f2

%% Avlänkning
y = 590;
x_0 = 295;
theta_0 = 59.50;
x = [89 137 171 193 211 222 229 232 232 229 224 217 207 195 183 167 153 135 118 99 80];
theta = 20:-2:-20;
d = atand(y./(x_0 + x))

theta_i = theta_0 - theta;
plot(theta_i, d, 'o');
f = @(n, theta_i) theta_i - 60 + asind(n.*sind(60 - asind(sind(theta_i)./n)));
N = lsqcurvefit(f, theta_i(1), theta_i, d)
hold on;
plot(theta_i, f(N, theta_i))