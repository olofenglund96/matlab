%% Rand
n = 7;
p = 0.2;
U = rand(1,n) % 1 rad och n kolumner med observation från R(0,1)
U<=p % 0 = gror inte, 1 = gror
X = sum(U<=p)

%% plotta
figure(1)
stem(U)
refline(0, p)
% 7 st R(0,1) slumptal
% sannoliheten vi vill jämföra U med.

%%
N = 100;
% antal fröpåsar
n = 7;
p = 0.1;
X = binornd(n,p,N,1) % X = antal groende frön i var och en av Nx1 påsar
antal = hist(X,0:n) % använd hist för att räkna antalet gånger vi får 0,1,...,n
antal(4)
% antal X==3 (4:e siffra i vektorn 0,1,2,3,...)
sum(X==3)
% jfr med antalet X som är lika med 3
figure(2)

bar(0:n,[antal/N; binopdf(0:n,n,p)]') % rita två uppsättningar staplar
xlabel('antal frön som gror')
ylabel('andel påsar')
legend('simulering','exakt','Location','NorthWest')

%% BINOMIAL
n = 100;
p = 0.6;
np = n*p
npq = np*(1-p)
% väntevärde
% varians
x = linspace(np-4*sqrt(npq),np+4*sqrt(npq), 10000);
figure(3)
stairs(0:n,binocdf(0:n,n,p))
hold on
plot(x,normcdf(x,np,sqrt(npq)))
normcdf(63,np,sqrt(npq))
bi = binocdf(0:n,n,p);
(bi(63)+bi(62))/2
hold off

%%
figure(4)
subplot(211)
bar(0:2, binopdf(0:2,2,.75))
title('Antal frö som gror')
ylabel('p(x)')

mu = 10;
x = 0:4*mu;
figure(4)

subplot(234)
bar(x, poisspdf(x, 0*mu))
title('Skörd om 0 frö gror')
ylabel('p(y|x=0)')

subplot(235)
bar(x, poisspdf(x, 1*mu))
title('Skörd om 1 frö gror')
ylabel('p(y|x=1)')

subplot(236)
bar(x, poisspdf(x, 2*mu))
title('Skörd om 2 frö gror')
ylabel('p(y|x=2)')

%%
pY = poisspdf(x,0*mu)*binopdf(0,2,0.75);
% fallet X=0
pY = pY + poisspdf(x,1*mu)*binopdf(1,2,0.75); % fallet X=1
pY = pY + poisspdf(x,2*mu)*binopdf(2,2,0.75); % fallet X=2
figure(5)
bar(x,pY)
xlabel('antal nya frön')

%%
n=5; p=0.2; mu=5;
y = 0:20;
pY = zeros(size(y));
% Fyll först p_Y(y) med nollor.
for k=0:n
    % Uppdatera p_Y(y) för varje k
    pY=pY+poisspdf(y,mu*k)*binopdf(k,n,p);
end
figure(6)
plot(y,pY)
xlabel('antal nya frön')

%% maxhav
[Y, P] = harvest(5, 0.2, 5);
m = sum(P.*Y)
[X, I] = max(P)

s = [18*0.03509 19*0.03562 20*0.03547 21*0.03492]
sum(s)*sum([18 19 20 21])/16

%% harvest2d
figure(1)
harvest2D(5, 0.65, 25)
figure(2)
harvest(5, 0.65, 25)
figure(3)
harvestCond(5, 0.65, 25, 60)

%%
harvestCond(7, 0.4, 1, 5)

%% 3
mu = 2.3;
x = poissrnd(mu,2,1)
xmedel = mean(x)

%% mu = 3;
n = 29;
M = 1000;
x = poissrnd(mu,n,M);
subplot(2,1,1);
hist(x(1,:),0:15);
subplot(2,1,2);
hist(xmedel,0:0.5:15);
xmedel = mean(x)
E = sum(xmedel)/1000
E2 = sum(xmedel.^2)/1000

D = sqrt(E2-E^2)