%% Init edof

coords = p';

enod=t(1:3,:)'; % nodes of elements
nelm=size(enod,1); % number of elements
nnod=size(coords,1); % number of nodes

dof=(1:nnod)'; % dof number is node number
ndof = size(dof, 1)
dof_S=[(1:nnod)',(nnod+1:2*nnod)']; % give each dof a number

edof = zeros(ndof, 4);
edof_S = zeros(ndof, 7);
edof_subd = zeros(ndof, 5);
for ie=1:nelm
    edof_S(ie,:)=[ie dof_S(enod(ie,1),:), dof_S(enod(ie,2),:), dof_S(enod(ie,3),:)];
    edof_subd(ie,:) = [ie, enod(ie,:), t(4,ie)];
    edof(ie,:)=[ie,enod(ie,:)];
end

[ex,ey]=coordxtr(edof,coords,dof,3);

%% Visualize

eldraw2(ex, ey, [1 2 2], edof(:,1));


%% Convection
er = e([1 2 5],:); % Reduced e

conv_segs = [10 11 12 30 29];
ins_segs = [1 2 3 8 9 28];
%conv_segments = [10 11 12]; % Choosen boundary segments
e_conv = [];
e_ins = [];
for i = 1:size(er,2)
    if ismember(er(3,i),conv_segs)
        n1 = er(1,i);
        n2 = er(2,i);
        dist = norm(coords(n1,:) - coords(n2,:));
        e_conv = [e_conv [er(1:2,i); dist]];
    end
    
    if ismember(er(3,i),ins_segs)
        n1 = er(1,i);
        n2 = er(2,i);
        e_ins = [e_ins er(1:2,i)];
    end
end

e_conv = sort(e_conv,1, 'descend')';




%% Load

Q = 1e5;
subdomain = 3;
alpha = 100;
D_alph = alpha;
T_inf = 273+15;
t = 50e-3;

K = zeros(ndof);
Kc = zeros(ndof);
f = zeros(ndof, 1);
f1 = [0 0 0]';
fb = zeros(ndof, 1);
D = 1;
Kce = 0;

for i = 1:nelm
    
    
    if edof_subd(i, 5) == subdomain
        Qe = Q;
    else
        Qe = 0;
    end
    
    [Ke, fe] = flw2te(ex(i,:), ey(i,:), t, D, Qe);
    idx = [];
    idx = find(ismember(edof(i,2:end), e_conv(:,1:2)) == 1);
    
    if size(idx, 2) >= 2
        idx_e = sort(edof(i,1+idx),'descend');
        idx_l = find(e_conv(:,1:2) == idx_e);
        fb(idx_e) = fb(idx_e) + t*(alpha*T_inf)*e_conv(idx_l(1), 3);
        
        Kce = eye(3).*(alpha.*e_conv(idx_l(1), 3)*t);
    end
    
    indx = edof(i,2:end);
    K(indx,indx) = K(indx,indx)+Ke;
    Kc(indx, indx) = Kc(indx, indx) + Kce;
    Kce = 0;
    indx = edof(i,2:end);
    f(indx) = f(indx) + fe;
    
end

%% Solve

[a, r] = solveq(K+Kc, f + fb);

ed = extract(edof, a);

fill(ex', ey', ed')
