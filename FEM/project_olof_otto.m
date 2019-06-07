% -------- Constants and setup ---------- %
%% 1. Reset, setup mesh, edofs and constants

clear;

load('meshfine.mat');

coords = p';

enod = t(1:3,:)';
nelm = size(enod,1);
nnod = size(coords,1);

dof = (1:nnod)';
dof_S=[(1:2:nnod*2)',(2:2:2*nnod)'];   % displacements have more dof
edof_S = zeros(319,7);
edof = zeros(319,4);
for ie=1:nelm     
    edof_S(ie,:)=[ie dof_S(enod(ie,1),:), dof_S(enod(ie,2),:),dof_S(enod(ie,3),:)]; % edof for displacements
    edof(ie,:)=[ie,enod(ie,:)]; % edof for heat flow
end

[ex, ey] = coordxtr(edof,coords,dof,3); % find coordinates of element nodes

% Initialize all constants, create vectors corresponding to subdomains
% Stationary heat
k = [20 385 1.6 238 238 238]; % heat conductivity
Q = 1e5*(1.6)^2; % heat production
T_inf = 25; % ambient temperature
alpha_conv = 100; % convection constant

% Transient heat
rho = [7900 8930 2000 2710 2710 2710]; % density
c = [460 386 900 903 903 903]; % specific heat

% Displacements
E = [210 128 500 70 70 70]; % Young's modulus 
v = [0.3 0.36 0.45 0.33 0.33 0.33]; % Poisson's ratio
alpha_exp = [35 51 20 69 69 69]*1e-6; % expansion coefficient





%% 2. Generate matrices for handling boundary conditions

% Check which segments that should have convections
er = e([1 2 5],:);   % Reduced e

conv_segments = [10 11 12 29 30]; % Choosen boundary segments
strain_segments_x = [1 2 3]; % uy = 0
strain_segments_y = [8 9 28]; % ux = 0

edges_conv = [];
edges_strainx = [];
edges_strainy = [];

for i = 1:size(er,2)
    if ismember(er(3,i),conv_segments) % if the edge belongs to convection boundaries
        n1 = er(1,i);
        n2 = er(2,i);
        dist = norm(coords(n1,:) - coords(n2,:)); % calculate edge length
        edges_conv = [edges_conv [er(1:2,i); dist]]; % add nodes to convection edges along with distance between them
    end
    
    % do the same but for strain conditions
    
    if ismember(er(3,i),strain_segments_x) 
        edges_strainx = [edges_strainx [er(1:2,i)]];
    end
    if ismember(er(3,i),strain_segments_y)
        edges_strainy = [edges_strainy [er(1:2,i)]];
    end
    
end

edges_conv = sort(edges_conv,'descend')'; % sort this for easier comparison later
edges_strainx = edges_strainx';
edges_strainy = edges_strainy';

nodesx = [edges_strainx(:,1); edges_strainx(:,2)]; % add all nodes to one column
nodesx = unique(nodesx); % since there can be duplicates we find the unique nodes
nodesy = [edges_strainy(:,1); edges_strainy(:,2)];
nodesy = unique(nodesy); 

% create bc-vectors
bcx = zeros(size(nodesx,2),2); 
bcy = zeros(size(nodesy,2),2);

for i = 1:size(nodesx,1)
   bcx(i,1) = 2*nodesx(i); % multiply by 2 since we have 2*dof for displacements
   bcx(i,2) = 0;
end

for i = 1:size(nodesy,1)
   bcy(i,1) = 2*nodesy(i)-1; % compensate index to assign uy
   bcy(i,2) = 0;
end

bc = [bcx;bcy];








% ----------------- Solving problems -------------------- %

%% 3. Create stiffness matrices for heat problem

D = 1; % constitutive matrix
K = zeros(nnod); % global K
Kc = zeros(nnod); % global Kc
Kce = 0; % element K
f = zeros(nnod,1); % global f
fb = zeros(nnod,1); % global fb
%fe = [0 0 0]';

Qe = 0;



for i=1:nelm
   
    D = D*k(t(4,i)); % change D depending on subdomain
    
    if (t(4,i)==3) % if the element is in the electric core
        Qe = Q;
    end
    
    [Ke, fe] = flw2te(ex(i,:),ey(i,:),1,D, Qe);
    
    % check if any nodes of the element belongs to a convection boundary
    idx = find(ismember(edof(i,2:end), edges_conv(:,1:2)) == 1); 
    
    if size(idx, 2) >= 2 % if 2 nodes belon, one edge lies on the boundary and we want to calculate fb
        idx_e = sort(edof(i,1+idx),'descend'); % sort to compare with vector on line 55
        idx_l = find(edges_conv(:,1:2) == idx_e); % find nodes on the edge
        
        % calc fbe and assemble into fb
        fb(idx_e) = fb(idx_e) + (alpha_conv*T_inf)*edges_conv(idx_l(1), 3)/2; 
        
        Kce = [2 1; 1 2]*alpha_conv*edges_conv(idx_l(1), 3)/6; % calc Kce
        
        Kc(idx_e, idx_e) = Kc(idx_e, idx_e) + Kce; % assemble Kce into Kc
        Kce = 0;
        
    end
       
    % assembly and resetting of vars before next iteration
    D = 1;
    Qe = 0;
    indx = edof(i,2:end);
    K(indx,indx) = K(indx,indx)+Ke;
    
    indx = edof(i,2:end);
    f(indx) = f(indx) + fe;
    
end








%% 4. SOlve stationary heat distribution and extracting

T = solve(K+Kc,f+fb);
edT = extract(edof, T);








%% 5. Create time discrimination of heat distribution

C = zeros(nnod);
deltat = 1; % time step of 1 s
time = 0:deltat:3600*2; % run for 2 hours
Tt = zeros(nnod,size(time,2)); % temperature at specific times
Tt(:,1) = 25; % set initial temperature to 25 degrees celsius

for i = 1:nelm
    
    x = rho(t(4,i))*c(t(4,i)); % use the right constants
    
    Ce = plantml(ex(i,:),ey(i,:),x); % find the Ce-matrix
    % assemble Ce into C
    indx = edof(i,2:end);
    C(indx,indx) = C(indx,indx)+Ce;
end

% prepare for time-stepping
Ks = C + deltat*(K+Kc);
Ksi = inv(Ks);

% step from t_0 to t_end
for i=2:size(time,2)
    
   Tt(:,i) = Ksi*(deltat*(f+fb) + C*Tt(:,i-1)); 
    
end








%% 6. Create stiffness matrix for displacements

deltaT = T-25; % subtract with T_0

b = [0 0];
Kstr = zeros(nnod*2);
fstr = zeros(nnod*2, 1);
f0e = zeros(6,1);


for i=1:nelm
    
    D = hooke(2, E(t(4,i)), v(t(4,i))); % decide D depending on subdomain
    
    Ke = plante(ex(i,:),ey(i,:),[2 1],D);
        
    indx = edof(i,2:end);
    
    % find average temperature diff depending on diff in element nodes
    del_T = mean([deltaT(indx(1)), deltaT(indx(2)), deltaT(indx(3))]);

    % find f0e, calculations made by hand and then implemented here
    f0e = del_T*alpha_exp(t(4,i))*E(t(4,i))/(2*(1-2*v(t(4,i))))*...
             [(ey(i,2) - ey(i,3))
              (ex(i,3) - ex(i,2))
              (ey(i,3) - ey(i,1))
              (ex(i,1) - ex(i,3))
              (ey(i,1) - ey(i,2))
              (ex(i,2) - ex(i,1))];
    

       
    indx = edof_S(i,2:end);
   
    % assembly of global matrices
    Kstr(indx,indx) = Kstr(indx,indx)+Ke;
        
    fstr(indx) = fstr(indx) + f0e;
    
end








%% 7. Solve displacement field

u = solve(Kstr,fstr, bc);
edu = extract(edof_S, u);








%% 8. Find Von Mises stress

Es = zeros(nelm,1);
Et = zeros(nelm,1);
for i = 1:nelm
    indx = edof(i,2:end);
    
    D = hooke(2, E(t(4,i)), v(t(4,i))); % find D for plane strain for specific subdomains
    
    ed = extract(edof_S(i,:), u); % find element displacements
    [es, et] = plants(ex(i,:), ey(i,:), [2 1], D, ed); % find stress resulting from displacements
    
    % calculate mean temperature in an element
    deltaT_mean = mean([deltaT(indx(1)) deltaT(indx(2)) deltaT(indx(3))]);
    
    % create D_eps_0 to subtract thermal strains from total strains
    De0 = alpha_exp(t(4,i))*E(t(4,i))*deltaT_mean/(1-2*v(t(4,i)))*[1; 1; 0; 0];
    
    esp = es' - De0; % subtract D_eps_0 from total strains
    
    % calculate Von Mises stress in each element
    vonMise = sqrt(esp(1)^2 + esp(2)^2 + eps(3)^2 - esp(1)*esp(2) - ...
        esp(2)*eps(3) - esp(1)*eps(3) + 3*esp(4)^2);
    
    Es(i) = vonMise; % save to global vector
    
end

Seff_nod = zeros(nnod,1); % variable containing stress in each node
for i=1:nnod
    % find index of each element containing node i
    [c0,c1]=find(edof(:,2:4)==i); 
    % calculate node stress by averaging the stresses in connected elements
    Seff_nod(i,1)=sum(Es(c0))/size(c0,1); 
end

edS = extract(edof,Seff_nod);








% ------------------ Visualizations ------------------------ %

%% 9. Visualize heat distribution

fill(ex',ey', edT','EdgeColor', 'none');
colormap(hot)
colorbar;
title('Stationary heat distribution with an increase in current by 60%');







%% 10. Visualize heat distribution at various times

ed = extract(edof, Tt(:,3600));
fill(ex',ey', ed','EdgeColor', 'none');
colormap(hot)
colorbar;









%% 11. Visualize displacement field

%quiver(ex',ey',edx',edy');

%fill(ex',ey', edprim','EdgeColor', 'none');
eldisp2(ex,ey,edu, [1 2 0], 100);
%colormap(hot)
%colorbar;








%% 12. Visualize stress field

hold on;
fill(ex',ey', edS','EdgeColor', 'none');
[Smax, Imax] = max(Seff_nod)
[Smin, Imin] = min(Seff_nod)
plot(coords(Imax,1), coords(Imax,2), 'bx', 'MarkerSize',20);
plot(coords(Imin,1), coords(Imin,2), 'rx', 'MarkerSize',20);
colormap(hot);
colorbar


