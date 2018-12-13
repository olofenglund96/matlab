%% Blue
bcurrent = [2 2.5 3 3.5 4];
btesla = bcurrent./10;
bsplitting = [0.049665831 0.416597569 0.492447296 0.971438879 0.893799382];
berror_p = [0.0496 0.0915 0.0048 0.0973 0.0403];
berror_v = berror_p.*bsplitting;
 k = btesla'\bsplitting';
 rfit = 0:0.05:0.15;
btesla = [rfit btesla];
bsplitting = [0*rfit bsplitting];
berror_v = [k*rfit berror_v];

hold on;

errorbar(btesla, bsplitting, berror_v);
x = linspace(0, 0.45);
plot(x, k*x, 'r');
axis([0 0.45 0 1.2]);

%% Red
rcurrent = [3 3.5 4];
rtesla = rcurrent./10;
rsplitting = [0.187019695 0.197962734 0.339924823];
rerror_p = [0.0124 0.0228 0.0124];
rerror_v = rerror_p.*rsplitting;

k = rtesla'\rsplitting';
rfit = 0:0.05:0.25;
rtesla = [rfit rtesla];
rsplitting = [0*rfit rsplitting];
rerror_v = [k*rfit rerror_v];
hold on;
errorbar(rtesla, rsplitting, rerror_v, 'b');
%errorbar(rfit, 0*rfit, k*rfit, 'b');
x = linspace(0, 1);
plot(x, k*x, 'r');

axis([0 0.4 0 0.4]);