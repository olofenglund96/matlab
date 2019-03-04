%% Method 1
clear;
h_tot = [1/10 1/20 1/40 1/80];
y_next = @(y_current, y_previous, h_spec) 4*y_current*(h_spec-1) + y_previous*(2*h_spec + 5);
y_exact = @(x) exp(x);
hold on;
for idx = 1:numel(h_tot)
    clear y t;
    h = h_tot(idx);
    y(1) = 1;
    y(2) = y_next(1, 0, h);
    i = 3;
    t(1) = 0;
    t(2) = h;
    while (i-1)*h <= 0.4
        y(i) = y_next(y(i-1), y(i-2), h);
        t(i) = (i-1)*h;
        i = i + 1;
    end
    subplot(2,2, idx);
    hold on;
    %plot(t, y, 'o-');
    %plot(x, y_exact(x));
    x = linspace(0, 0.4, length(t));
    error = abs(y_exact(x)-y);
    plot(x, error);
    legend(['\Delta t = ' num2str(h)], 'Exact solution');
end

%% Method 2
clear;
h_tot = [1/10 1/20 1/40 1/80];
y_next = @(y_current, y_previous, h_spec) y_current*((3/2)*h_spec+1) - y_previous*((1/2)*h_spec);
y_exact = @(x) exp(x);
hold on;
for idx = 1:numel(h_tot)
    clear y t;
    h = h_tot(idx);
    y(1) = 1;
    y(2) = y_next(1, 0, h);
    i = 3;
    t(1) = 0;
    t(2) = h;
    while (i-1)*h <= 0.4
        y(i) = y_next(y(i-1), y(i-2), h);
        t(i) = (i-1)*h;
        i = i + 1;
    end
    subplot(2,2, idx);
    hold on;
    %plot(t, y, 'o-');
    x = linspace(0, 0.4, length(t));
    error = abs(y_exact(x)-y);
    plot(x, error);
    legend(['\Delta t = ' num2str(h)], 'Exact solution');
end