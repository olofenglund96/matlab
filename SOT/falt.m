function falt = falt(f,g);
% ber�knar kontinuerlig faltning av f och g
% DELTAT = samplingssteget
% F�r dator�vning 2 i Line�ra system f�r D
% 1995: SSp 20.11.95
global t
global DELTAT
[m,n] = size(t);
laengd = fix((n-1)/2);
falt = conv(f,g)*DELTAT;
indexen = 1+laengd:1:n+laengd;
falt = falt(indexen);

