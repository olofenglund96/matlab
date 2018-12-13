function plotsyst(system,insignal)
% Ber�knar utsignalen fr�n systemet "system" om 
% insignalen �r "insignal" och ritar upp b�de insignalen och
% utsignalen. Ingen utvariabel. 
% F�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
global t
global DELTAT
figure
subplot(211)
plot(t,insignal);
title(system);
xlabel('insignal');
grid
subplot(212)
eval(['utsignal' '=' system '(' 'insignal' ')' ';']);
plot(t,utsignal);
xlabel('utsignal');
grid
