function plotsyst(system,insignal)
% Beräknar utsignalen från systemet "system" om 
% insignalen är "insignal" och ritar upp både insignalen och
% utsignalen. Ingen utvariabel. 
% För datorövning 2 i Lineära system för D
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
