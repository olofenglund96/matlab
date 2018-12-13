% Detta demo simulerar Fraunhoferdiffraktion och bygger upp f�ltet
% enligt Huygens princip. K�r demot genom att trycka <F5> eller "Run"
% och f�rs�k f�rst� vad de olika parametrarna har f�r betydelse.
% Ingen b�jning finns med i ber�kningarna, och f�ljdaktligen avklingar
% inte f�ltet som i verkligheten.

lambda=5e-1;    % V�gl�ngd i godtyckliga enheter
n=4;            % Antal ljusk�llor
x0=-10;         % Ljusk�llornas x-position
ydev=3;       % Avst�nd mellan de tv� yttersta ljusk�llorna
nt=1;           % Om nt==1, integrera f�r att ber�kna tidsmedelv�rdet av intensiteten

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

x=linspace(-10,10,1e3);
y=x;

[X,Y]=meshgrid(x,y);

y0=linspace(-ydev,ydev,n);

H=zeros(size(X));
H2=H;

if n==1
  nt=0;
end
for i=0:nt
  phase=i/(nt+1)*pi;
  H=zeros(size(X));
  for y0i=y0
    R=sqrt((X-x0).^2+(Y-y0i).^2);
    H=H+cos(1/lambda*2*pi*R + phase);
  end
  H2=H2+H.^2;
end
H2=H2/(nt+1);

figure(1)
subplot('Position', [0.1 0.1 0.7 0.7])
surf(X,Y,H2)
shading interp
view(2)
axis square
colormap(gray)
xlabel('x')
ylabel('y')
zlim([0 max(max(H2))])
hold on
l=plot(x0*ones(n,1), y0,'b.'); % Plotta ljuskällornas position
set(l,'MarkerSize', 30.0)
hold off

% Plotta intensiteten på skärmen
subplot('Position', [0.8 0.1 0.1 0.7])
plot(sum(H2(:,end),2)',y)
xlabel('I')
ylabel('y')