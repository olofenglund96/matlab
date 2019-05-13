nel = 20;
K = zeros(nel+1:nel+1)
f = zeros(nel+1, 1)

Edof = zeros(nel, 3)

spacing = (8-2)/nel;

nodes = 2:spacing:8
AkL = 50/(spacing);

fe = [100; 100]
Ke = spring1e(AkL)

for i = 1:nel
    Edofe = [i i i+1];
    Edof(i,:) = [i i i+1];
    [K,f] = assem(Edofe, K, Ke, f, fe);
end

bc = [1 -24; nel+1 -150]

T = solveq(K, f, bc)

plot(nodes, T);