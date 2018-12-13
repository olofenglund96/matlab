%% 208-Pb
A = 208;
Z = 82;
B = bind_energy(A, Z)/A


%% 21-Ne
A = 21;
Z = 10;
[B, C] = bind_energy(A, Z)

%% 57-Fe
A = 57;
Z = 26;
[B, C] = bind_energy(A, Z)

%% 209-Bi
A = 209;
Z = 83;
[B, C] = bind_energy(A, Z)

%% 256-Fm
A = 256;
Z = 100;
[B, C] = bind_energy(A, Z)

%% Mass-defect
%% 24-Ne
del = -8.418;
A = 24;
mass_from_defect(A, del)

%% 144-Sm
del = -81.964 ;
A = 144;
mass_from_defect(A, del)

%% 240-Pu
del = 50.123;
A = 240;
mass_from_defect(A, del)
