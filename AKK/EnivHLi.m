%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Detta program anropas av menu.m och används för att lösa Schrö-    %
% dingerekvationen numeriskt, d.v.s. utifrån given potential (väte-  %
% eller litiumsystem), givet l-kvanttal och given energi räkna fram  %
% motsvarande radiella vågfunktion.                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Utvecklat av  Fredrik Frisk, Gunnar Ohlen, Ingemar Ragnarsson och  %
% Per Östborn.                                                       %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Översyn gjord av Magnus Borgh, höstterminen 2005                   %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%  Här börjar programmet!
%   ||		     ||
%   ||		     ||
%   \/               \/

two_m_over_hbar_square = 0.26247;
e_Zero_square = 14.39967;
a_Bohr        = 0.529177;

Energy  = E;
Enorm = E*two_m_over_hbar_square; 

set(energiruta,'string',mat2str(E));

% definition av delta_r och start_r; vektorn r är definierad i menu.m
delta_r = r(2) - r(1);
start_r	= r(1:2);
L; Z;
old_wave_function1 = wave_function1;

% Potentialer för elektronen i väteatomen samt för valenselektronen i
% litium. Notera att effektivt Z=2.69 används. En alternativ modell
% vore att använda kvantdefektmodellen.
h_pot = -1.*e_Zero_square.*(1./r);
li_pot = -3.*e_Zero_square.*(1./r) + e_Zero_square.*(2./r-(5.38/a_Bohr+2./r).*exp(-5.38.*r/a_Bohr));
 
% Programmet kan även (med användarinställningen Li i potentialvalet)
% användas för att räkna på elektronen i den väteliknande jonen Li++.
% aktivera följande rad för numerisk test av Li++       

%li_pot = -3.*e_Zero_square.*(1./r);

eff_pot = L*(L+1)./r.^2;
if Z == 1
    eff_pot = eff_pot + two_m_over_hbar_square .* (-e_Zero_square ./ r);
else
    eff_pot = eff_pot + two_m_over_hbar_square * userDefinedPotentialEnergy( r );
end;


% startvärden i 1:a och 2:a 'punkten' för vågfunktionen
wave_function = start_r.^(L+1);
t1 = clock;
% iteration med delta(r) enligt definition ovan
for i = 3:100
     wave_function(i) = (2+(eff_pot(i-1)-Enorm)*delta_r^2)* ...
        wave_function(i-1) - wave_function(i-2);
  end;
% iteration med 4 ggr större delta(r)  
for i = 26:100
   wave_function(4*i) = (2+(eff_pot(4*(i-1))-Enorm)*(4*delta_r)^2)* ...
      wave_function(4*(i-1)) - wave_function(4*(i-2));
end;
% iteration med delta(r) ytterligare 5 ggr större!   
for i = 1:20
     wave_function1(i) = wave_function(20*i); 
  end;
for i = 21:600
   wave_function(20*i) = (2+(eff_pot(20*(i-1))-Enorm)*(20*delta_r)^2)* ...
      wave_function(20*(i-1)) - wave_function(20*(i-2));
  wave_function1(i) = wave_function(20*i);   
end;
tid =etime(t1,clock);

% 2010-04-15: The program now plots the actual wavefunction, instead of
% the wavefunction multiplied with r. / J C Cremon
wave_function1 = wave_function1 ./ r1;

%   normera vågfunktinen för plottning!
m_max = 0;
if Energy < -4
  m_max = max(abs(wave_function1(1:30)));
else
  m_max = max(abs(wave_function1(1:240)));
end;
wave_function1 = wave_function1 / m_max;
cla;
line([0 30],[0 0],'linestyle','--')

set(gca,'xlim',[0 30]);
set(gca,'ytick',[]);
hold on;

p = plot( r1, wave_function1, '-' );
set( p, 'linewidth', 2 );
ps = plot( r1, (abs(wave_function1).^2.*r1.^2), '-' );
set( ps, 'linewidth', 2 );
plot( r1, old_wave_function1, '--' );

xlabel('Avstånd till kärnan (Ångström)');
%
%   /\           /\
%   ||		     ||
%   ||		     ||
%  Här slutar programmet!
