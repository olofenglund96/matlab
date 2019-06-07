%% setup mesh and edof

load('meshruff.mat');

coords = p';

enod = t(1:3,:)';
nelm = size(enod,1);
nnod = size(coords,1);

dof = (1:nnod)';
dof_S=[(1:2:nnod*2)',(2:2:2*nnod)'];   % give each dof a number
edof_S = zeros(319,7);
edof = zeros(319,4);
for ie=1:nelm     
    edof_S(ie,:)=[ie dof_S(enod(ie,1),:), dof_S(enod(ie,2),:),dof_S(enod(ie,3),:)];
    edof(ie,:)=[ie,enod(ie,:)];
end

[ex, ey] = coordxtr(edof,coords,dof,3);


%% Edges

% Check which segments that should have convections
er = e([1 2 5],:);   % Reduced e

conv_segments = [10 11 12 30 29]; % Choosen boundary segments
strain_segments_x = [1 2 3]; % uy = 0
strain_segments_y = [8 9 28]; % ux = 0
edges_conv = [];
edges_strain = [];
for i = 1:size(er,2)
    if ismember(er(3,i),conv_segments)
        n1 = er(1,i);
        n2 = er(2,i);
        dist = norm(coords(n1,:) - coords(n2,:));
        edges_conv = [edges_conv [er(1:2,i); dist]]; 
    end
    
    % Vet inte riktigt hur vi ska hantera randerna för strain nedan men
    % testar detta..
    
    if ismember(er(3,i),strain_segments_x)
        edges_strain = [edges_strain [2*er(1,i); 1]];
        edges_strain = [edges_strain [2*er(2,i); 1]];% Sätter uy = 0, uy = 1
    end
    
    if ismember(er(3,i),strain_segments_y)
        edges_strain = [edges_strain [2*er(1,i)-1; 1]]; % Sätter uy = 1, ux = 0
        edges_strain = [edges_strain [2*er(2,i)-1; 1]];
    end
end

edges_conv = sort(edges_conv,'descend')';
edges_temp = [];
insert_idx = 1;
for a = 1:size(edges_strain)
    contains = false;
    for b = 1:size(edges_temp)
        if edges_temp(1,b) == edges_strain(1,a)
            contains = true;
        end
    end
    
    if contains == false
        edges_temp(:,insert_idx) = edges_strain(:,a);
        insert_idx = insert_idx + 1;
    end
end

edges_strain = edges_strain';

%% load

k = [20 385 1.6 238 238 238];
D = 1;
K = zeros(nnod);
Kc = zeros(nnod);
Kce = 0;
f = zeros(nnod,1);
fb = zeros(nnod,1);
%fe = [0 0 0]';
Qe = 0;
T_inf = 25;
tjock = 50e-3;
alpha = 100;
Q = 1e5;

for i=1:nelm
    
    
    if (t(4,i)==1)
        D = D*k(1);
    elseif (t(4,i)==2)
        D = D*k(2);
    elseif (t(4,i)==3)
        D = D*k(3);
        Qe = Q;
    elseif (t(4,i)==4)
        D = D*k(4);
    elseif (t(4,i)==5)
        D = D*k(5);
    elseif (t(4,i)==6)
        D = D*k(6);
    end
    
    [Ke, fe] = flw2te(ex(i,:),ey(i,:),tjock,D, Qe);
    
    idx = [];
    idx = find(ismember(edof(i,2:end), edges_conv(:,1:2)) == 1);
    
    if size(idx, 2) >= 2    % om elementet har noder längs en rand
        idx_e = sort(edof(i,1+idx),'descend');
        idx_l = find(edges_conv(:,1:2) == idx_e);
        
        fb(idx_e) = fb(idx_e) + tjock*(alpha*T_inf)*edges_conv(idx_l(1), 3)/2;
        
        Kce = [2 1; 1 2]*alpha*edges_conv(idx_l(1), 3)*tjock/6;
        Kc(idx_e, idx_e) = Kc(idx_e, idx_e) + Kce;
        Kce = 0;
        
    end
       
    D = 1;
    Qe = 0;
    indx = edof(i,2:end);
    K(indx,indx) = K(indx,indx)+Ke;
    
    indx = edof(i,2:end);
    f(indx) = f(indx) + fe;
    
end

%% Solve stationary

[a, r] = solve(K+Kc,f+fb);
ed = extract(edof, a);
fill(ex',ey', ed','EdgeColor', 'none');
%colormap(hot)
colorbar;
T = ed;

%% solve time

rho = [7900 8930 2000 2710 2710 2710];
c = [460 386 900 903 903 903];
C = zeros(nnod);
deltat = 1;
time = 0:deltat:3600*2;
a = zeros(nnod,size(time,2));
a(:,1) = 25;

for i = 1:nelm
    
    x = rho(t(4,i))*c(t(4,i))*tjock;
    
    Ce = plantml(ex(i,:),ey(i,:),x);
    indx = edof(i,2:end);
    C(indx,indx) = C(indx,indx)+Ce;
end

Ks = C + deltat*(K+Kc);
Ksi = inv(Ks);

for i=2:size(time,2)
    
   a(:,i) = Ksi * (deltat*(f+fb) + C*a(:,i-1)); 
    
end

%% Stress
E = [210 128 500 70 70 70];
v = [0.3 0.36 0.45 0.33 0.33 0.33];
D = @(E, v) E/(1-v^2)*[1 v 0; v 1 0; 0 0 (1-v)/2];
Kstr = zeros(nnod*2);
fstr = zeros(nnod*2, 1);
ep = [1 tjock];
T0 = 15;
alpha = 20e-6;

for i = 1:nelm
    Ee = E(t(4,i)); ve = v(t(4,i));
    De = D(Ee, ve);
    
    fe = (T(i)-T0)*alpha*Ee/(1-ve)*[1 1 1 0 0 0]';
    
    Ke = plante(ex(i,:), ey(i,:), ep, De)
    
    indx = edof_S(i,2:end);
    Kstr(indx,indx) = Kstr(indx,indx)+Ke;
    
    indx = edof_S(i,2:end);
    fstr(indx) = fstr(indx) + fe;
    
end

%% Bc solv

[a, r] = solveq(Kstr, fstr, edges_strain);

ed = extract(edof_S, a);

fill(ex',ey', mean(ed, 2)','EdgeColor', 'none');
%colormap(hot)
colorbar;

%% extract

Ed = {};
for i = 1:size(time, 2)
    Ed(i) = {extract(edof, a(:,i))};
end

%% Visualize
hold on;
for i = 1:2300:size(Ed,2)
    fill(ex',ey', Ed{i}','EdgeColor', 'none');
    %colormap(hot)
    colorbar;
    pause(0.5);
end

%% print
ed = extract(edof, a(:,3600));
fill(ex',ey', ed','EdgeColor', 'none');
%colormap(hot)
colorbar;