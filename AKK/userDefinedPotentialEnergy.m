function V = userDefinedPotentialEnergy( r )

% Some useful constants:

e_zero_square = 14.39967;
a_Bohr        = 0.529177; % in Ångström
Z_eff         = 2.69;

% The variable 'V' must be set to the value of the potential energy at
% the distance 'r' from the nucleus, where 'r' is given in units of Ångström.

V_core = -3.*e_zero_square.*(1./r);

V_from_inner_electrons = e_zero_square.*(2./r-(2*Z_eff/a_Bohr+2./r).*exp(-2*Z_eff.*r/a_Bohr));

V = V_core + V_from_inner_electrons;
