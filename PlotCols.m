function [] = PlotCols(wLen, ver, col, span)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    alpha = 30;
    % zinkdopat kronglas: 1.517 10.72 blå färg
    zkA1 = 1.517;
    zkA2 = 10.72;
    % tungt flintglas: 1.653 10.27 grön färg
    tfA1 = 1.653;
    tfA2 = 10.27;
    
    n1 = 1;
    n2 = 0;
    if ver == 1
        n2 = (zkA1 + zkA2/wLen);
    else
        n2 = (tfA1 + tfA2/wLen);
    end
    f = @(x) x - alpha + asind((n2/n1)*sind(alpha - asind((n1/n2)*sind(x))));
    %g = @(x) asind((n2_2/n1)*sind(alpha - asind((n1/n2_2)*sind(x))));
    x = linspace(span(1), span(2));
    plot(x, x-f(x), col);
    %plot(x, x-g(x), 'green');
end

