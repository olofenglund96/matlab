function delaytest(system,insignal,del);
% Testar tidsinvarians av systemet "system" genom att beräkna 
% fördröjningar av  insignaler och motsvarande fördröjningar
% av utsignaler
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
figure
del1=num2str(del);
subplot(211)
plot(t,insignal);
hold on
plot(t,delay(insignal,del));
hold off
title('test av tidsinvarians')
xlabel(['fördröjning =' del1 ]);
eval(['testsignal =' system '(delay(insignal,del)) - delay(' system '(insignal),del);']);
subplot(212)
eval(['testsignal1 =' system '(delay(insignal,del));']);
eval(['testsignal2 = delay (' system '(insignal),del);']);
%plot(t,testsignal1,'b');
%hold on
%plot(t,testsignal2,'r');
plot(t,testsignal1-testsignal2,'g');
hold off;
xlabel(['S(delay(insignal,' del1 ')) - delay(S(insignal),' del1 '))'])

