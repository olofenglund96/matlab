%%
radon=load('radon200.dat');
K = 0.098;

%%
g3rum = mean(radon)/K

%%
d3rum = sqrt(g3rum/(10*K))

%% 
g3rum*10*K

%%
I3rum = [g3rum-norminv(1-0.05/2)*d3rum; g3rum+norminv(1-0.05/2)*d3rum]

%%
skattningar(1, 1, 5, 25, 'muskatt')

%%
skattningar(1, 3, 5, 25, 'konfint')

%%
gamma0 = 200;
mu03rum = 10*K*gamma0
% väntevärdet för summan när H0 är sann
y3rum = sum(radon)
% summorna i de tre rummen
P3rum = poisscdf(y3rum,mu03rum) % P(Y_i <= y_i)

%%
mu0hus = 3*10*K*gamma0
yhus = sum(y3rum)
Phus = poisscdf(yhus,mu0hus)

%%
styrkefkn(1, 10, 0, 0.05, '<')
styrkefkn(1, 10, 1.24, 0.1, '>')

%%
styrkefkn(1.6, 11, 1.4, 0.05, '!=', 0)