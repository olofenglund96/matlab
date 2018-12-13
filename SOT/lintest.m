function lintest(system,insignal1,insignal2,c1,c2);
% lintest(system,insignal1,insignal2,c1,c2);
% Testar linearitet av systemet "system" genom att beräkna 
% lineärkombinationer av insignaler och motsvarande lineär-
% kombinationer av utsignaler
% För datorövning 2 i Lineära system för D
% SSp 20.11.95, 1.12.96
global t
global DELTAT
figure
c11=int2str(c1);
c12=int2str(c2);
subplot(211)
plot(t,c1*insignal1+c2*insignal2);
title('test av linearitet')
%xlabel(sprintf( c1 '*w1+' c2 '*w2']);
xlabel([ c11 '*w1+' c12 '*w2']);
eval(['testsignal' '=' system '(c1*insignal1 + c2*insignal2)' ...
 '-' system '(c1*insignal1)' '-' system '(c2*insignal2)'  ';']);
subplot(212)
plot(t,testsignal);
xlabel(['S(' c11 '*w1+' c12 '*w2)' ...
'- (' c11 '*S(' 'w1) +' c12 '*S(' 'w2))'])

