data = importdata('data/Kad_1804341U2.TXT');
lambda = data(:,1);
intensity = data(:,5);
hold on;
plot(lambda, intensity);
axis([340 362 0 2*10^4])
title('Spektrum från Cd');