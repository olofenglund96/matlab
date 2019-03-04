abs_back = importdata('abs_back.txt');
gul_abs = importdata('gul_abs.txt');
gul_em = importdata('gul_em.txt');
x = gul_abs.data(:,1);
y = gul_abs.data(:,2);
k = 1.38e-23;
T = 293;
h = 6.626e-34;
c = 3e8;
E = h*c./(x.*10^-9);
Fe = exp(-E./(k*T));

hold on
plot(h*c./(gul_em.data(:,1).*10^-9), gul_em.data(:,2)./max(gul_em.data(:,2)), 'r')
plot(E,y.*Fe/3.4e-36, 'b');
xlim([3e-19, 5e-19])
