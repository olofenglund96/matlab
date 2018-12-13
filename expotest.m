hold on;
for a = 2:2:4
    f = @(x)exp(-a*x);
    x = linspace(0, 10);
    plot(x, f(x));
    %line([0 exp(-a)], [1/a 1/a])
    line([0 1/a], [exp(-1) exp(-1)])
    line([1/a 1/a], [0 exp(-1)])
end