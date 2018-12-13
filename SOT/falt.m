function falt = falt(f,g);
% beräknar kontinuerlig faltning av f och g
% DELTAT = samplingssteget
% För datorövning 2 i Lineära system för D
% 1995: SSp 20.11.95
global t
global DELTAT
[m,n] = size(t);
laengd = fix((n-1)/2);
falt = conv(f,g)*DELTAT;
indexen = 1+laengd:1:n+laengd;
falt = falt(indexen);

