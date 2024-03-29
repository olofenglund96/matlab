%% 2.7
K = [1 6 -2 -3; 6 2 -4 0; -2 -4 2 -1; -3 -2 -1 2]
f = [0 0 30 40]'
bc = [1 2; 2 4]

[a, Q] = solveq(K, f, bc)

%% 3.2

K = [30 -20 -10; -20 30 -10; -10 -10 20]
f = [0 0 10]'
bc = [1 0]

[a, Q] = solveq(K, f, bc)

%% 3.3

K = [2 -1 -1 0; -1 3 -1 -1; -1 -1 3 -1; 0 -1 -1 2]
f = [1 0 0 0]'
bc = [2 4; 0 0]'

[a, Q] = solveq(K, f, bc)