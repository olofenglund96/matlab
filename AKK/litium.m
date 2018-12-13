a0 = 0.529177;
Zeff = 2.69;
e = 1.602*10^-19;
eps = 8.85418782*10^-12;
B = Zeff/a0;



e_zero_square = 14.39967;
a_Bohr        = 0.529177; % in Ångström
Z_eff         = 2.69;
r = linspace(0, 10, 1000);
V_from_inner_electrons = e_zero_square.*(2./r-(2*Z_eff/a_Bohr+2./r).*exp(-2*Z_eff.*r/a_Bohr));

U = e^2/(eps*2*pi)*(-B*exp(-2*B*r) - (1./r).*exp(-2*B*r) + 1./r);
hold on;
plot(r, U);
%plot(r, V_from_inner_electrons);

e/(eps*2*pi)