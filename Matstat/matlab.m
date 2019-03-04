%% Läs in
load kroppsTemp.mat
whos T

temp = T(:,1);
gen = T(:,2);

%% Histogram vs plot
histogram(temp)

figure(2)
plot(temp, '.')

%% Jämföra
Tk = temp(gen == 2);
Tm = temp(gen == 1);
figure(3)
subplot(211)
histogram(Tm)
subplot(212)
histogram(Tk)

%% Boxplot
figure(4)
boxplot(temp, gen)

%% Tillsammans
figure(5)
plot(sort(temp), 1:length(temp), '.')

%% Ratio
ratio = mean(temp <= 36.8)

%% Steg
figure(6)
N = length(temp)
stairs(sort(temp), (1:N)/N)
grid on

%% Stickprov
mu = mean(temp)
sigma = std(temp)

%% Jämf
figure(1)
histogram(temp, 'Normalization', 'pdf') % normera histogramet till area = 1
x = linspace(35.5, 38.5, 100);
% skapa en x-vector
hold on
plot(x, normpdf(x, mu, sigma))
% plotta tätheten (pdf) i samma figur
hold off

%% Fördelningsfunktioner
figure(6)
stairs(sort(temp),(1:N)/N,'-')
grid on
hold on
plot(x, normcdf(x, mu, sigma))
hold off

%% Simulera
data = normrnd(mu, sigma, 1, 2000);
figure(7)
histogram(data, 'Normalization', 'pdf')
hold on
plot(x, normpdf(x,mu,sigma))
hold on
figure(8)
stairs(sort(data),(1:length(data))/length(data),'.-')
hold on
plot(x, normcdf(x,mu,sigma))
hold off
grid on

%% Sannolikhet för P(X<=36.3)
normspec([-Inf 36.3], mu, sigma)

%% Kvantil 7%
norminv(1-0.07, mu, sigma)

%% Andra fördelningar
close all
x = linspace(0,10,1000);
figure(1)
plot(x,normpdf(x,2,0.5))
hold on
plot(x,normpdf(x,7,0.5))
plot(x,normpdf(x,5,2))

plot(x,normpdf(x,5,0.2))
% N(5, 0.2)
hold off
% Lås upp plotten
xlabel('x')
title('Täthetsfunktioner, f(x)')
figure(2)
plot(x,normcdf(x,2,0.5))
hold on
plot(x,normcdf(x,7,0.5))
plot(x,normcdf(x,5,2))
plot(x,normcdf(x,5,0.2))
hold off
xlabel('x')
title('Fördelningsfunktioner, F(x)')

%% Slump
u = rand(1000, 1);
hist(u);

f = @(x, lam) -log(1-x)/lam;

hist(f(u, 3));

f(0.507,  0.84)