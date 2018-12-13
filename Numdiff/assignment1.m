%% 3 explicit
clear;
fun = @(x)exp(-10*x);
x = linspace(0,2);

y(1) = 1;
steps_y = [1/2 1/5 1/20];
titles_y = {'\Delta t = 0.5', '\Delta t = 0.2', '\Delta t = 0.05'};
pos_y = [[0.07 0.15 0.24 0.7]; [0.38 0.15 0.24 0.7]; [0.69 0.15 0.24 0.7]];
for a=1:3
    step_y = steps_y(a);
    N_y = 2/step_y;
    
    for n=1:N_y
        y(n+1)= y(n)+step_y*(-10*y(n));
        x_y(n+1)=n*step_y;
    end
    
    subplot('Position',pos_y(a,:))
    hold on;
    plot(x_y,y, 'r')
    plot(x, fun(x), 'color', 'black');
    title(titles_y(a))
    hold off;
end

%% 3 implicit
clear;
fun = @(x)exp(-10*x);
x = linspace(0,2);

y(1) = 1;
steps_y = [1/2 1/5 1/20];
titles_y = {'\Delta t = 0.5', '\Delta t = 0.2', '\Delta t = 0.05'};
pos_y = [[0.07 0.15 0.24 0.7]; [0.38 0.15 0.24 0.7]; [0.69 0.15 0.24 0.7]];
for a=1:3
    step_y = steps_y(a);
    N_y = 2/step_y;
    
    for n=1:N_y
        y(n+1)= y(n)/(1+10*step_y);
        x_y(n+1)=n*step_y;
    end
    
    subplot('Position',pos_y(a,:))
    hold on;
    plot(x_y,y, 'r')
    plot(x, fun(x), 'color', 'black');
    title(titles_y(a))
    hold off;
end

%% 4
clear;

tstart = 0;
tend = 100;
n = 1000;
tspan = [0 100];

xinit = [1;0;0];

[t1,x1] = ode45(@Integrator, tspan, xinit);
[t2,x2] = ode15s(@Integrator, tspan, xinit)
%plot3(x(:,1), x(:,2), x(:,3))
subplot(2,1,1);
hold on;
plot(t1, x1(:,1));
plot(t1, x1(:,2));
plot(t1, x1(:,3));
title('Solution using ode45');
legend({'C_A', 'C_B', 'C_C'})
subplot(2,1,2);

hold on;
plot(t2, x2(:,1));
plot(t2, x2(:,2));
plot(t2, x2(:,3));
legend({'C_A', 'C_B', 'C_C'})
title('Solution using ode15s');