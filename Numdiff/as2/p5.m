%% Test matrix 1
Y_input = [-1 10; 0 -3];
Y_0 = [1 1];
t_0 = 0;
t_end = 5;
step = 1/10;
[Y1, T1] = custom_solver(Y_input, Y_0, t_0, t_end, 1, step);
[Y2, T2] = custom_solver(Y_input, Y_0, t_0, t_end, 2, step);
[Y3, T3] = custom_solver(Y_input, Y_0, t_0, t_end, 3, step);
%Actual solutions
y1 = @(t) -5*exp(-3*t) + 6*exp(-t);
y2 = @(t) exp(-3*t);
t = linspace(t_0, t_end);
subplot(2,2,1);
hold on;
plot(T1(1,:), Y1(1,:), 'r');
plot(T1(2,:), Y1(2,:), 'r');
plot(t, y1(t), 'b');
plot(t, y2(t), 'b');
title('Implicit Euler');
axis([0 5 0 3]);

subplot(2,2,2);
hold on;
plot(T2(1,:), Y2(1,:), 'r');
plot(T2(2,:), Y2(2,:), 'r');
plot(t, y1(t), 'b');
plot(t, y2(t), 'b');
title('SDIRK-2');
axis([0 5 0 3]);

subplot(2,2,3:4);
hold on;
plot(T3(1,:), Y3(1,:), 'r');
plot(T3(2,:), Y3(2,:), 'r');
plot(t, y1(t), 'b');
plot(t, y2(t), 'b');
title('Classical Runge-Kutta');
axis([0 5 0 3]);
%% Test matrix 2
Y_input = [-1 100; 0 -30];
Y_0 = [1 1];
t_0 = 0;
t_end = 5;
step = 1/50;
[Y1, T1] = custom_solver(Y_input, Y_0, t_0, t_end, 1, step);
[Y2, T2] = custom_solver(Y_input, Y_0, t_0, t_end, 2, step);
[Y3, T3] = custom_solver(Y_input, Y_0, t_0, t_end, 3, step);
%Actual solutions
y1 = @(t) -(100/29)*exp(-29*t) + (1+(100/29))*exp(-t);
y2 = @(t) exp(-30*t);
t = linspace(t_0, t_end);
subplot(2,2,1);
hold on;
plot(T1(1,:), Y1(1,:), 'r');
plot(T1(2,:), Y1(2,:), 'r');
plot(t, y1(t), 'b');
plot(t, y2(t), 'b');
title('Implicit Euler');
axis([0 5 0 4]);

subplot(2,2,2);
hold on;
plot(T2(1,:), Y2(1,:), 'r');
plot(T2(2,:), Y2(2,:), 'r');
plot(t, y1(t), 'b');
plot(t, y2(t), 'b');
title('SDIRK-2');
axis([0 5 0 4]);

subplot(2,2,3:4);
hold on;
plot(T3(1,:), Y3(1,:), 'r');
plot(T3(2,:), Y3(2,:), 'r');
plot(t, y1(t), 'b');
plot(t, y2(t), 'b');
title('Classical Runge-Kutta');
axis([0 5 0 4]);