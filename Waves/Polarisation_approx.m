d = 3*10^-3;
l1 = 504*10^-9;
m1 = 0;
l2 = 577*10^-9;
m2 = 8;
l3 = 680*10^-9;
m3 = 16;
syms A B m;
eq1 = d*(A + B/l1^2) == (2*(m-m1) + 1)*(l1/2);
eq2 = d*(A + B/l2^2) == (2*(m-m2) + 1)*(l2/2);
eq3 = d*(A + B/l3^2) == (2*(m-m3) + 1)*(l3/2);
eqs = [eq1 eq2 eq3];
sol = solve(eqs, [A B m]);
ansA = double(sol.A)
ansB = double(sol.B)
ansm = double(sol.m)

%% Delta n
n = @(x)ansA + ansB./x.^2;
x = linspace(300*10^-9, 800*10^-9);
plot(x, n(x))