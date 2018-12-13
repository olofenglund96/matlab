function [shortestLen] = DrawOptPath(A, B, n1, n2, w, step)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    line([w(1) w(2)], [w(3) w(4)], 'color', 'r')
    Wx = w(1);
    Wy = w(3);
    Ax = A(1);
    Ay = A(2);
    Bx = B(1);
    By = B(2);
    repeats = w(4);
    pathLength = zeros(repeats*step, 1);
    index = 1;
    shortestLen = 1000;
    shortInd = 0;
    for i = 0:1/step:repeats
        pathLength(index) = n1*sqrt((Wx-Ax)^2 + (Wy+i - Ay)^2) + n2*sqrt((Bx-Wx)^2 + (By - (Wy+i))^2);
        if pathLength(index) < shortestLen
            shortestLen = pathLength(index);
            shortInd = i;
        end
        line([A(1) w(1)], [A(2) w(3)+i]);
        line([w(1) B(1)], [w(3)+i B(2)]);
        index = index + 1;
    end
    line([A(1) w(1)], [A(2) w(3)+shortInd], 'color', 'g');
    line([w(1) B(1)], [w(3)+shortInd B(2)], 'color', 'g');
end

