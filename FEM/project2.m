%% setup mesh and edof

load('meshruff.mat');

coords = p';

enod = t(1:3,:)';
nelm = size(enod,1);
nnod = size(coords,1);

dof = (1:nnod)';
dof_S=[(1:nnod)',(nnod+1:2*nnod)'];   % give each dof a number
edof_S = zeros(319,7);
edof = zeros(319,4);
for ie=1:nelm     
    edof_S(ie,:)=[ie dof_S(enod(ie,1),:), dof_S(enod(ie,2),:),dof_S(enod(ie,3),:)];
    edof(ie,:)=[ie,enod(ie,:)];
end

[ex, ey] = coordxtr(edof,coords,dof,3);


%% Convection

% Check which segments that should have convections
er = e([1 2 5],:);   % Reduced e

conv_segments = [10 11 12 30 29]; % Choosen boundary segments

edges_conv = [];
for i = 1:size(er,2)
    if ismember(er(3,i),conv_segments)
        n1 = er(1,i);
        n2 = er(2,i);
        dist = norm(coords(n1,:) - coords(n2,:));
        edges_conv = [edges_conv [er(1:2,i); dist]]; 
    end
end

edges_conv = sort(edges_conv,'descend')';

for i = 1:nelm
    
end

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
T_inf = 15;
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

[a, r] = solve(K+Kc,f+fb);
ed = extract(edof, a);
fill(ex',ey', ed','EdgeColor', 'none');
%colormap(hot)
colorbar;


