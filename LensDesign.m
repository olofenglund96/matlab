function [] = LensDesign(d, D, n, step)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    Wx = d;
    Wy = -D/2;
    Ax = 0;
    Ay = 0;
    Bx = d*2;
    By = 0;
    line([Wx Wx], [Wy -Wy], 'color', 'r');
    repeats = D;
    index = 1;
    lensWidth = zeros(repeats*step, 1);
    compLen = sqrt((Wx-Ax)^2 + (Wy - Ay)^2);
    %line([Ax Wx], [Ay Wy]);
    %line([Wx Bx], [Wy By]);
    for i = 0:1/step:repeats
        lensWidth(index) = (compLen - sqrt((Wx-Ax)^2 + (Wy+i - Ay)^2))./n;
        lIndex = lensWidth(index);
        %line([Wx-lIndex/2 Wx+lIndex/2], [Wy+i Wy+i], 'color', 'g');
        %line([Wx-lIndex/2 Wx-lIndex/2], [Wy+i-1 Wy+i+1], 'color', 'g');
        %line([Wx+lIndex/2 Wx+lIndex/2], [Wy+i-1 Wy+i+1], 'color', 'g');
        index = index + 1;
    end
    index = 1;
    for i = 0:1/step:repeats
        lensWidth(index) = (compLen - sqrt((Wx-Ax)^2 + (Wy+i - Ay)^2))./n;
        lIndex = lensWidth(index);
        line([Ax Wx-lIndex/2], [Ay Wy+i]);
        line([Wx+lIndex/2 Bx], [Wy+i By]);
        index = index + 1;
    end
end