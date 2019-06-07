%% Regression

x = [1:8]';
% En kolumn med x-värden.
y = [1.5 2.3 1.7 2.0 2.5 1.9 2.2 2.4]'; % En kolumn med y-värden.
X = [ones(size(x)) x];
% En kolumn med ettor och en med
% x-värdena.
[b,bint] = regress(y,X)
% Skatta alfa och beta samt
% konfidensintervall för dem.
mu = X*b;
% Beräkna den skattade linjen.
plot(x,y,'*',x,mu,'-')
% Rita obervationer och skattad linje.

%% Reggui

reggui(X, y)

%% Load co2
load('co2.dat');

%% Plot co2
subplot
plot(co2);

%% Fix co2-matrix
z = reshape(co2, 12, []);

%% 
y = mean(z)';
x = (1:32)';
plot(x, y, 'o')

%% Regg

reggui(x, y);

%% cement

load cement.dat
corrcoef(cement)
x = cement(:,1:4);
Y = cement(:,5);
plotmatrix(cement)

%% cement 2
X = [ones(size(Y)) x]
beta = X\Y
res = Y-X*beta
[n, c] = size(X)
f = n-c
s2 = sum(res.^2)/f
Vbeta = s2*inv(X'*X)
plot(res,'o')

%% stepwise
stepwise(x, Y)


%% FLow
load flow.mat
reggui(fx2,fy2)

%%

Y = fy2;
X = [ones(size(Y)) fx2];
beta = X\Y
res = Y-X*beta
[n, c] = size(X)
f = n-c
s2 = sum(res.^2)/f
Vbeta = s2*inv(X'*X)
fn = @(x) beta(1) + beta(2)*x;
fn(0.52)
plot(res,'o')