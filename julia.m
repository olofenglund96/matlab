xaxis=0;
yaxis=0;
l=1.5;
x=linspace(xaxis-l,xaxis+l);
y=linspace(yaxis-l,yaxis+l);
[xtrans,ytrans]=meshgrid(x,y);
var= -.745429;
ztrans=xtrans+i*ytrans;
for k=1:arg1;
    ztrans=ztrans.^2+var;
    t=exp(-abs(ztrans));
end
colormap prism(256)
pcolor(t);
shading flat;
axis('square','equal','off');