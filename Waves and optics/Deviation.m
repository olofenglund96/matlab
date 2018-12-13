 y = 61.0;
 x0 = 27.2;
 v0 = 60.17;
 V = v0 - linspace(20,-26,24);
 X = [5.4 12.7 16.2 18.8 20.6 21.7 22.4 22.8 22.8 22.5 22.0 21.2 20.4 19.3 17.9 16.5 14.8 13.0 11.2 9.4 7.5 5.4 3.3 1.4];
 D = atand(y./(x0 + X));
 plot(V, D, 'o');
 f = @(n, v) v + asind(n .* sind(60 - asind(sind(v)/n))) - 60;
 nFit = lsqcurvefit(f, V(1), V, D)
 hold on;
 plot(V, f(nFit, V), 'b');
 hold off;