data = importdata('data/h_not_sat_1804350U2.TXT');
lambda = data(:,1);
intensity = data(:,5);
hold on;
plot(lambda, intensity);
axis([350 700 0 7*10^4])
title('Spektrum från H');