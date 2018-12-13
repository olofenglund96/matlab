function result = converge(z)
% Decides wether a function converges
i = 0;
nbr0 = z;
while abs(z) < 2 && i < 100
    z = z*z + nbr0;
    i = i + 1;
end
result = i;

end