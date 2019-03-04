data1 = importdata('Germanium-Thorium.Spe');
data2 = importdata('Plast-Cs137.Spe');
channels = 1:2048;

plot(channels, data1);

title('Uppm�tt gammakvanta f�r ett ^{137}Cs-preparat med Ge-detektor');
legend({'M�tpunkter fr�n laboration'});
set(gca, 'YScale', 'log');
xlabel('Kanal');
ylabel('Kvanta');
saveas(gcf, 'img/plot_5', 'png');

plot(channels, data2);

title('Uppm�tt gammakvanta f�r ett Th-preparat med plastscintillator');
legend({'M�tpunkter fr�n laboration'});
set(gca, 'YScale', 'log');
xlabel('Kanal');
ylabel('Kvanta');
saveas(gcf, 'img/plot_6', 'png');