function dxdt = Integrator( t, x )

ca = x(1);
cb = x(2);
cc = x(3);

dxdt = zeros(size(x));
dxdt(1) = -0.04*ca + 10^4*cb*cc;
dxdt(2) = 0.04*ca - 10^4*cb*cc - 3*10^7*cb^2;
dxdt(3) = 3*10^7*cb^2;

end

