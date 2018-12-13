function visaserie(cnoll, akoeff, bkoeff, ymin, ymax)
% visaserie.m
%
% Beräknar och ritar delsummor till Fourierserie
% Fourierkoefficienterna finns i 
% cnoll (skalär), akoeff, bkoeff 
% inparametrar: 
%     cnoll, akoeff, bkoeff     trigonometriska Fourierkoefficienter
%     ymax, ymin                skalan på y-axeln
%
% Definiera cnoll, akoeff och bkoeff innan du anropar funktionen med
%
% >> visaserie(cnoll, akoeff, bkoeff, ymin, ymax)
%
% (SSp 3 okt 1997, 30 sep 1998, SS 23 nov 2000, FW, 5/2 2014)
%

if nargin < 5 || isempty(ymax)
    ymax = 2;
end

if nargin < 4 || isempty(ymin)
    ymin = -2;
end

clf
hold off
inresteg=0.03;
clear summa
clear term
t0 = -4*pi;
t1 = 4*pi;

axis([t0 t1 ymin ymax])
t=t0:inresteg:t1;

term=cnoll*ones(size(t));
summa=term;

for k=1:100,
%   
   subplot(211)
   hold off
   plot(t,summa); % rita summa (i annan ruta)
   axis([t0 t1 ymin ymax]) 
   set(gca,'XTick',t0:pi:t1)
   set(gca,'XTickLabel',{'-4pi','-3pi','-2pi', '-pi', '0', 'pi', '2pi', '3pi', '4pi' })   
   hold on
   title([ 'delsumma s_{' int2str(k-1) '}' ])
   hold off
%
   subplot(212)
   plot(t,term,'r');
   hold on
   axis([t0 t1 -1 1]) % skalan i y-led ändras vid behov 
   set(gca,'XTick',t0:pi:t1)
   set(gca,'XTickLabel',{'-4pi','-3pi','-2pi', '-pi', '0', 'pi', '2pi', '3pi', '4pi' })   
   hold off
   title([ 'term u_{' int2str(k-1) '}' ' (röd)' ])
%
   pause
   term = akoeff(k)*cos(k*t) + bkoeff(k)*sin(k*t); % uppdatera term
   summa = summa + term; % uppdatera summa
end
