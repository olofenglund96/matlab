function result = mandelbrot(elems, start, finish)
%UNTITLED5 Summary of this function goes here
M = complexmat(elems, start, finish);
f = @(x) converge(x);
A = arrayfun(f, M);
result = A;
end

