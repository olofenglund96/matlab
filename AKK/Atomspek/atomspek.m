
h = importdata('data/h.TXT');
cd = importdata('data/cd.TXT');
na_l = importdata('data/na_low.TXT');
na_h = importdata('data/na_high.TXT');

%% H

h_lambda = h(:,1);
h_intensity = h(:,5);
h_peaks = [410.2600, 434.0200, 486.2500, 656.3100];
hold on;
plot(h_lambda, h_intensity, 'b');

for p = h_peaks
    line([p p+1], [0 1e5], 'Color', 'red', 'LineStyle','--');
end
axis([400 700 0 7e4]);

%% Cd
cd_lambda = cd(:,1);
cd_intensity = cd(:,5);
cd_peaks = [340.34 346.6 346.75 361.03 361.25 361.4];

hold on;
plot(cd_lambda, cd_intensity, 'b');

% for p = cd_peaks
%     line([p p], [0 1e5], 'Color', 'red', 'LineStyle','--');
% end
axis([330 370 0 3e4]);

%% Na
na_l_lambda = na_l(:,1);
na_l_intensity = na_l(:,5);
na_l_peaks = [433 466.8 498 515 616];

na_h_lambda = na_h(:,1);
na_h_intensity = na_h(:,5);
na_h_peaks = [589];


lambdas = {h_lambda, cd_lambda, na_l_lambda, na_h_lambda};
intensities = {h_intensity, cd_intensity, na_l_intensity, na_h_intensity},
peaks = {h_peaks, cd_peaks, na_l_peaks, na_h_peaks}



for a = 1:length(lambdas)
    plot(lambdas{a}, intensities{a});
    
    strcat('plots/plot_', extractBefore(file.name, '.'))
    %filename = strcat(['plots/plot_' num2str(filenum) '_'], replace(extractBefore(file.name, '_'), ' ', '_'))
    filename = [strcat('plots/plot_', extractBefore(file.name, '.'))]
    saveas(gcf, char(filename), 'png');
    
end

%% Kvantdefekt
R = 1.097e7;
del = @(E, n) n-sqrt((h*c*R)/(E*e));
E = @(lam) 5.14-(h*c)/(e*lam*10^(-9));
E_def_3 = -h*c*R/(e*(3-0.8829)^2)
E_def_8 = -h*c*R/(e*(8-0.0308)^2)
E_tot = E_def_3 - E_def_8
lam_tot = h*c/(E_tot*e)
E(589);
del(5.14-4.97, 9);

%% Finstruktur
dE = @(l1, l2) h*c*10^9*(1/l1 - 1/l2)/e;
% Nere
dE(340.34, 346.8)
dE(346.6, 361.3)

% Uppe
dE(361, 361.3)
dE(346.6, 346.8)

E_fine = @(J, L, S, b) b*(J*(J+1)-L*(L+1)-S*(S+1))./2;
E_fine(0, 1, 1, 1)
E_fine(1, 1, 1, 1)
E_fine(2, 1, 1, 1)
E_fine(1, 2, 1, 1)
E_fine(2, 2, 1, 1)
E_fine(3, 2, 1, 1)