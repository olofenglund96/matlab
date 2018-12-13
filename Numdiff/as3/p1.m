%A = [-1 10; 0 -3];
f = @(Y) [Y(2,:); -9.82*sin(Y(1,:))];
time = 45;
[y_fixed, t_fixed] = odeAM3(f, [pi/2 0]', 0, time, 1/200);
% [y_fixed_10, t_fixed_10] = odeAM3(f, [pi/2 0]', 0, time, 1/10);
% [y_fixed_5, t_fixed_5] = odeAM3(f, [pi/2 0]', 0, time, 1/5);
[y_newton, t_newton] = odeAM3_newton(f, [pi/2 0]', 0, time, 1/200);
% [y_newton_10, t_newton_10] = odeAM3_newton(f, [pi/2 0]', 0, time, 1/10);
% [y_newton_5, t_newton_5] = odeAM3_newton(f, [pi/2 0]', 0, time, 1/5);

y1 = @(t) -(100/29)*exp(-29*t) + (1+(100/29))*exp(-t);
y2 = @(t) exp(-30*t);
%y1 = @(t) -5*exp(-3*t) + 6*exp(-t);
%y2 = @(t) exp(-3*t);

%error = y - x(t);
hold on;
subplot(3,1,1);
hold on;
plot(t_fixed(1,:), y_fixed(1,:), 'blue');
%plot(t_fixed, y_fixed(2,:), 'red');
title('Fixed point h=1/20');
%legend({'\alpha', '\alpha'''});
subplot(3,1,2);
hold on;
% plot(t_fixed_10(1,:), y_fixed_10(1,:), 'blue');
plot(t_newton, y_newton(1,:), 'red');
title('Fixed point h=1/10');
%legend({'\alpha', '\alpha'''});
subplot(3,1,3);
hold on;
%plot(t_fixed_5(1,:), y_fixed_5(1,:), 'blue');
%plot(abs(t_fixed-t_newton), abs(y_newton(1,:)-y_fixed(1,:)), 'blue');
title('Fixed point h=1/5');
%plot(t, y1(t), '+');
%plot(t, y2(t), '+');
%plot(t, error);
%max(error);