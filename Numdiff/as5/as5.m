L = 0.1;
N = 100;
T_A = 20;
r_0 = 0.02;
h = 20;
k = 14;

% 1
a = @(x) -1/(L*(1-x/(2*L)));
b = @(x) -2*h/(k*r_0*(1-x/(2*L)));
c = @(x) 2*h*T_A/(k*r_0*(1-x/(2*L)));

% 2
dx = L/(N+1/2);
x = dx:dx:L-dx/2;

% 3
d_i = @(x) 1/dx^2-a(x)/(2*dx);
e_i = @(x) b(x)-2/dx^2;
f_i = @(x) 1/dx^2+a(x)/(2*dx);

%4 
T_0 = 100;
T_N1 = @(T_N) (h*T_A-T_N*(h/2-k/dx))/(h/2+k/dx);

%5 och 6
A = zeros(N,N);
A(1,1) = e_i(x(1));
A(1,2) = f_i(x(1));

C = zeros(N,1);
C(1) = c(x(1))+d_i(x(1))*T_0;

for i = 2:N-1
    A(i,i-1) = d_i(x(i));
    A(i,i) = e_i(x(i));
    A(i,i+1) = f_i(x(i));
    
    C(i) = c(x(i));
end

A(N,N-1) = d_i(x(N));
A(N,N) = e_i(x(N))-f_i(x(N))*(h*dx-2*k)/(h*dx+2*k);

C(N) = c(x(N)) + f_i(x(N))*h*T_A/(h/2+k/dx);

T = A\(-C);
T_L = (T(N)+T_N1(T(N)))/2