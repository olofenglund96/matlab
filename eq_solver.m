x = linspace(0, 2, 1000);
f = sin(pi*x);
g = (3/pi).*(1-x);
plot(x, f);
hold on
plot(x, g);