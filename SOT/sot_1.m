%% 1
A = [[11 -6];[12 -6]]
[S,D]=eig(A)

%% 2
A = rosser
B = gallery(5)
%save('A.mat', 'A')
SB = eig(B)
format rat
SA = eig(A)

%% 3
A = [-1i-6, 6; -12, -1i+11]
B = [3;4]
A*B

%% 4
format rat
A = [0 2; 0.8 0.6]
[S,D] = eig(A)
A-eye(2)*(-2/5)

%% 5
A = [[6 -4];[9 -6]]
A*A

%% 6
A = [0 8*pi; -2*pi 0]
B = [0 2*pi; -8*pi 0]
A*B
B*A

%% Test
format rat
syms t
S = [[3 2];[4 3]]
A = [exp(3*t) 0; 0 exp(2*t)]
S*A*inv(S)