function [ Y_ans, T_ans ] = custom_solver( Y, Y_0, t_0, t_end, solver, step )
%CUSTOM_SOLVER Solves ODE's with different solvers
%   Takes a matrix Y containing the equation system, a matrix
%   Y_0 which contains initial values, time start t0 and time end t_end.
%   Returns a matrix Y containing the solution and an array t_ans
%   containing the time steps.

    h = step;
    N = 1+(t_end-t_0)/h;
    
    if solver == 1
        y_approx = @(y_n, c) y_n/(1-c*h);
    elseif solver == 2
        alpha = 1-sqrt(2)/2;
        y_approx = @(y_n, c) y_n/(1-h*alpha*c)*(1+c*h*(1-alpha)*(1+h*alpha*c/(1-alpha*c*h)));
    elseif solver == 3
        y_approx = @(y_n, c) y_n*(1 + h*c + ((h*c)^2)/2 + ((h*c)^3)/4 + ((h*c)^4)/24);
    end
    Y_ans = [[0] [0]]';
    T_ans = Y_ans;
    
    % Loop backwards through matrix rows and solve sequentially
    for el = length(Y(:,1)):-1:1
        % Clear previous solutions
        y = zeros(1, N);
        t = y;
        y_solved = zeros(1, N);
        
        % Include previous solutions to current row
        if ~isempty(Y_ans)
            for idx = el:length(Y_ans(:,1))
                y_solved = y_solved + Y(el,idx).*Y_ans(idx,:);
            end
        end
        % Initial conditions
        y(1) = Y_0(el);
        t(1) = 0;
        i = 1;
        
        % Specify coefficient from Y matrix
        C = Y(el,el);
        
        while i*h <= t_end-t_0
            y(i+1) = y_approx(y(i), C) + h*y_solved(i+1);
            t(i+1) = h*i;
            i = i + 1;
        end
        
        Y_ans(el,1:N) = y;
        T_ans(el,1:N) = t;
    end
    
end

