data_high = importdata('data/na_high.TXT');
data_low = importdata('data/na_low.TXT');
lambda_high = data_high(:,1);
intensity_high = data_high(:,5);
lambda_low = data_low(:,1);
intensity_low = data_low(:,5);
hold on;
subplot(2,1,2);
plot(lambda_low, intensity_low);

na_h_peaks = [589];
for p = na_h_peaks
    line([p p], [0 1e5], 'Color', 'red', 'LineStyle','--');
end
axis([430 630 0 7*10^4]);
title('Spektrum från Na, låg integrationstid');
subplot(2,1,1);
plot(lambda_high, intensity_high);

na_l_peaks = [433 466.8 498 515 616];
for p = na_l_peaks
    line([p p], [0 1e5], 'Color', 'red', 'LineStyle','--');
end

axis([430 630 0 7*10^4])
title('Spektrum från Na, hög integrationstid');