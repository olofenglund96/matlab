data = [importdata('co_60 - kopia.Spe') importdata('cs_137 - kopia.Spe') importdata('na_22 - kopia.Spe') importdata('th - kopia.Spe')];
preps = {'^{60}Co', '^{137}Cs', '^{22}Na', 'Th'};
peaks = {[692, 788], [396], [312, 762], [145, 205, 278, 307, 350, 433, 543 ,573, 940, 1550]};channels = 1:2048;
for i = 1:4
    plot(channels, data(:,i));
    
    hold on;
    for a = peaks{:,i}
        loglog([a a], [1 10^6], 'color', 'r');
    end
    hold off;
    
    title(['Uppmätt gammakvanta för ett ' preps{1,i} '-preparat']);
    legend({['Mätpunkter från ' preps{1,i} '-preparat']});
    set(gca, 'YScale', 'log');
    xlabel('Kanal');
    ylabel('Kvanta');
    saveas(gcf, ['img/plot_' num2str(i)], 'png');
end
