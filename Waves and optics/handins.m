%% Uppg 1a %%
n1 = 1;
n2 = 1.5;
alpha = 30;
f = @(x) x - alpha + asind((n2/n1)*sind(alpha - asind((n1/n2)*sind(x))));
x = linspace(-90, 160);
plot(x, f(x));

%   F�r st�rre vinklar fr�n normalen �r vinkelskillnaden h�gre. 

%% Uppg 1b %%
hold on;
span = [-90 90];
ver = 1;
PlotCols(450, ver, 'b', span);
PlotCols(495, ver, 'g', span);
PlotCols(620, ver, 'r', span);

%   Ljus med l�gre v�gl�ngder har l�gre vinkelskillnad. Det ljuset "bryter"
%   allts� inte lika mycket.


