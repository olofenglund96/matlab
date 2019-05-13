Ex1 = 1/3
Ex2 = (4^2 + 2^2 + 3^2)/3
V = Ex2-Ex1^2

%%
E = @(x, p) (3*x + 2)*p
E(0, 4/100) + E(1, 30/100) + E(2, 42/100) + E(3, 24/100)

%%
sqrt((0.3)^2*7)

%%
sigm = 0.05;
mu = 0.68;
f = @(x) 1/(sigm*sqrt(2*pi))*exp(-(x-mu).^2/(2*sigm^2));
x = linspace(0, 1.3);
plot(x, f(x))

p = 1 - integral(f, 0.58, 0.78)

%%
sigm = 9.7;
mu = 11.31;
f = @(x) 1/(sigm*sqrt(2*pi))*exp(-(x-mu).^2/(2*sigm^2));
x = linspace(-30, 50);
plot(x, f(x))

kg_bil = 1200/101

p = integral(f, kg_bil, 100)

%%
x = linspace(-10, 20, 10000);
X = normpdf(x, 4, 3);
Y = normpdf(x, 5, 1);
f = @(x) normpdf(x, 4, 3) - normpdf(x, 5, 1);
hold on;
plot(x, f(x));
p = integral(f, -50, 0)