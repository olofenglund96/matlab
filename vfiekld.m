[x,y] = meshgrid(-1:0.1:1,-1:0.1:1);
u = x./(x.^2+y.^2);
v = y./(x.^2+y.^2);
a = -y./(x.^2+y.^2);
b = x./(x.^2+y.^2);
figure
hold on
quiver(x,y,u,v)
quiver(x,y,a,b,'r')