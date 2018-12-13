function [ Y, T ] = odeAM3_newton( f, Y_0, ts, te, step )
    I = eye(2);
    h = step;
    N = (te-ts)/h + 1;
    Y = zeros(2, N);
    
    % Define numerical methods
    EE = @(y_n) y_n + h.*f(y_n);
    AM2 = @(y_n, y_n1) y_n + (1/2)*h.*(f(y_n1) + f(y_n));
    AM3 = @(y_n, y_n1, y_n2) y_n1 + (1/12)*h.*(5*f(y_n2) + 8*f(y_n1) - f(y_n));
    AB2 = @(y_n, y_n1) y_n1 + (1/2)*h.*(3*f(y_n1) - f(y_n));
    
    % Produce initial values
    Y(:,1) = Y_0;
    Y(:,2) = AM2(Y_0, EE(Y_0));
    T = linspace(ts, te, N);
    
    % This iterator is used to compare performance between fixed point and
    % newton
    itr = zeros(1, N);
    for i = 3:N
        a = 1;
        
        % Guess initial value with Adam Bashfort-2
        c1 = AB2(Y(:,i-2), Y(:,i-1));
        
        % Compute numerical jacobian
        J = diff([c1'; Y(:,i-1)'])';
        while true
            
            % Refine guess with newtons method using Adam Moulton-3
            c2 = c1 - (I-h*J)\(c1 - AM3(Y(:,i-2), Y(:,i-1), c1));
            
            % Check if approximation is good enough or break if divergence
            if norm(c1-c2) < 10^(-20) || a > 10000
                %a
                break;
            end
            
            c1 = c2;
            a = a + 1;
        end
        
        itr(i-2) = a;
        Y(:,i) = c2;
    end
    % Calculates the average amount of required iterations by the iteration
    % method
    new = mean(itr)
end
