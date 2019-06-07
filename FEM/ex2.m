K = zeros(ndof);
f = zeros(ndof, 1);

D = 1;

for i = 1:nelm
    Ke = flw2te(ex(i,:), ey(i,:), 1, D);
    K = assem(edof(i,:), K, Ke);
    
end

[a, r] = solveq(K, f, bc);

ed = extract(edof, a);

H = fill(ex', ey', ed')
