%% Code for part 1 of shape model project 
clc
clear
close all

% Load the DMSA images and manual segmentation
load dmsa_images
load man_seg

% Extract x- and y-coordinates
Xmcoord=real(man_seg);
Ymcoord=imag(man_seg);
Xmcoord(41)=Xmcoord(1);
Ymcoord(41)=Ymcoord(1);
plot(Xmcoord,Ymcoord);
axis equal
%%
%Räkna ut totala omkretsen
d_omkrets = 0;
for i = 1:40
   d_omkrets = d_omkrets + sqrt((Xmcoord(i+1)-Xmcoord(i)).^2+(Ymcoord(i+1)-Ymcoord(i)).^2);
end

d = d_omkrets/14;
points = zeros(14,2);
x_val = Xmcoord(1);
y_val = Ymcoord(1);
points(1,:) = [Xmcoord(1) Ymcoord(1)];
ind = 2;
d_cur = sqrt((Xmcoord(ind)-Xmcoord(ind-1))^2+(Ymcoord(ind)-Ymcoord(ind-1))^2);

for i = 2:14
while d_cur <= d*(i-1)
    ind = ind + 1;
    d_prev = d_cur;
    d_cur = d_cur + sqrt((Xmcoord(ind)-Xmcoord(ind-1))^2+(Ymcoord(ind)-Ymcoord(ind-1))^2);
end
x_prev = x_val;
y_prev = y_val;
weight = (d_cur-d*(i-1))/(d_cur-d_prev);
x_val = Xmcoord(ind)-weight*(Xmcoord(ind)-Xmcoord(ind-1));
y_val = Ymcoord(ind)-weight*(Ymcoord(ind)-Ymcoord(ind-1));
points(i,:) = [x_val y_val];
avst(i) = sqrt((x_val-x_prev)^2+(y_val-y_prev)^2);
end
avst(15) = sqrt((x_val-points(1,1))^2+(y_val-points(1,2))^2);

imagesc(dmsa_images(:,:,1))
colormap(gray)
hold on
plot(Xmcoord,Ymcoord,'r');
hold on 
plot(Xmcoord,Ymcoord,'r*');
hold on
plot([points(:,1); points(1,1)],[points(:,2); points(1,2)], 'g')
hold on
plot([points(:,1); points(1,1)],[points(:,2); points(1,2)], 'g*')
axis equal
axis xy

%%
% Choose patient and look at image
pat_nbr = 1;
figure
imagesc(dmsa_images(:,:,pat_nbr))
colormap(gray)
axis xy
axis equal
hold on
drawshape_comp(man_seg,[1 length(man_seg) 1],'.-r')


%% Code for part 2 of shape model project 
clc
clear
close all

% Load the DMSA images
load dmsa_images

% Choose patient and look at image
pat_nbr = 1;

figure
imagesc(dmsa_images(:,:,pat_nbr))
colormap(gray)
axis xy

%%
%covariance matrix not covariance vector

% Load the manual segmentations
% Columns 1-20: the right kidney of patient 1-20
% Columns 21-40: the mirrored left kidney of patient 1-20
% Each row is a landmark position
load models

% Extract x- and y-coordinates
Xcoord=real(models);
Ycoord=imag(models);

%% Align all against the first 
Z = {};
T = {};
for i = 2:40
    [D(i-1), Z{i-1}, T{i-1}] = procrustes([Xcoord(:,1) Ycoord(:,1)], [Xcoord(:,i) Ycoord(:,i)]);
end


figure 
plot(Xcoord(:,1), Ycoord(:,1), '*')
for i = 1:39
    hold on
    plot(Z{i}(:,1), Z{i}(:,2),'*')
end
axis equal
%% Computes the mean and plots the mean with the first 
vec = zeros(2,39);
m = zeros(14,2);
for i = 1:14
    for j = 1:39
        vec(:,j) = Z{j}(i,:);
    end
    m(i,:) = mean(vec');
end

figure
plot(Xcoord(:,1), Ycoord(:,1))
for i = 1:39
    hold on
    plot(Z{i}(:,1), Z{i}(:,2))
end
hold on
plot(m(:,1), m(:,2),'k*');
axis equal
%% 
vec = zeros(2,40);
Z_m = {};
T_m = {};

for i = 1:2
[D_mean, Z_mean] = procrustes([Xcoord(:,1) Ycoord(:,1)], m);

for j = 1:40
    if j == 1
        [D_m(j), Z_m{j}, T_m{j}] = procrustes(Z_mean, [Xcoord(:,j) Ycoord(:,j)]);
    else
        [D_m(j), Z_m{j}, T_m{j}] = procrustes(Z_mean, [Z{j-1}(:,1) Z{j-1}(:,2)]);

    end
end

for j = 1:14
    for k = 1:40
        vec(:,k) = Z_m{j}(j,:);
    end
    m(j,:) = mean(vec');
end

end

figure
plot(m(:,1), m(:,2),'r*');
axis equal

figure
for i = 1:40
    plot(Z_m{i}(:,1), Z_m{i}(:,2))
    hold on
end
plot(m(:,1), m(:,2),'k*');
axis equal

%%
figure
plot(m(:,1), m(:,2),'k*');
for i = 1:14
    text(m(i,1),m(i,2),int2str(i))
    hold on
end
axis xy
axis equal
%%
for i = 1:40 
    dx_coord(:,i) = Z_m{i}(:,1) - m(:,1);
    dy_coord(:,i) = Z_m{i}(:,2) - m(:,2);
end 

S = 0;
for i = 1:40
S = S + 1/length(dx_coord)*[dx_coord(:,i); dy_coord(:,i)]*[dx_coord(:,i); dy_coord(:,i)]';
end

[V,D,W] = eig(S);
e = diag(D);
x = 1:28;
figure 
plot(x, e, '*')

%%
m_xy = [m(:,1); m(:,2)];
x_new = {};
for i = 1:28 
x_new{i} = m_xy + V*V(:,i);
end

%% Ser skumt ut för 1-3, skiljer sig för mkt?
ind = 3;
figure 
plot(m_xy(1:14), m_xy(15:28))
hold on
plot(m_xy(1:14)+2*sqrt(e(ind))*V(1:14,ind), m_xy(15:28)+2*sqrt(e(ind))*V(15:28,ind));
hold on
plot(m_xy(1:14)+sqrt(e(ind))*V(1:14,ind), m_xy(15:28)+sqrt(e(ind))*V(15:28,ind));
hold on
plot(m_xy(1:14)-2*sqrt(e(ind))*V(1:14,ind), m_xy(15:28)-2*sqrt(e(ind))*V(15:28,ind));
hold on
plot(m_xy(1:14)-sqrt(e(ind))*V(1:14,ind), m_xy(15:28)-sqrt(e(ind))*V(15:28,ind), 'g');
axis equal


%%
t=10;
E = sum(e);
E_t = sum(e(1:t)); %Need 10 eig for obtaining 95% confidence interval
amount = E_t/E;

P_t = V(:,1:t);

%%
im_nbr = 21;
im = ind2gray(dmsa_images(:,:,im_nbr), colormap(gray));
B = bwboundaries(imbinarize(im));
hold on
imagesc(dmsa_images(:,:,im_nbr))
colormap(gray)
plot(B{1}(:,2),B{1}(:,1), 'g*'); %vänster
plot(B{2}(:,2),B{2}(:,1), 'g*'); %höger
axis xy
axis equal
Xmcoord = B{2}(:,2);
Ymcoord = B{2}(:,1);
%%
im_nbr = 22;
im = ind2gray(dmsa_images(:,:,im_nbr), colormap(gray));
B = bwboundaries(imbinarize(im));
hold on
imagesc(dmsa_images(:,:,im_nbr))
colormap(gray)
plot(B{1}(:,2),B{1}(:,1), 'g*'); %vänster
plot(B{4}(:,2),B{4}(:,1), 'g*'); %höger
axis xy
axis equal
Xmcoord = B{4}(:,2);
Ymcoord = B{4}(:,1);
%%
im_nbr = 23;
im = ind2gray(dmsa_images(:,:,im_nbr), colormap(gray));
B = bwboundaries(imbinarize(im));
hold on
imagesc(dmsa_images(:,:,im_nbr))
colormap(gray)
plot(B{1}(:,2),B{1}(:,1), 'g*'); %vänster
plot(B{2}(:,2),B{2}(:,1), 'g*'); %höger
axis xy
axis equal
Xmcoord = B{2}(:,2);
Ymcoord = B{2}(:,1);
%%
im_nbr = 24;
im = ind2gray(dmsa_images(:,:,im_nbr), colormap(gray));
B = bwboundaries(imbinarize(im));
hold on
imagesc(dmsa_images(:,:,im_nbr))
colormap(gray)
plot(B{1}(:,2),B{1}(:,1), 'g*'); %vänster
plot(B{2}(:,2),B{2}(:,1), 'g*'); %höger
axis xy
axis equal
Xmcoord = B{2}(:,2);
Ymcoord = B{2}(:,1);
%%
im_nbr = 25;
im = ind2gray(dmsa_images(:,:,im_nbr), colormap(gray));
B = bwboundaries(imbinarize(im));
hold on
imagesc(dmsa_images(:,:,im_nbr))
colormap(gray)
plot(B{1}(:,2),B{1}(:,1), 'g*'); %vänster
plot(B{2}(:,2),B{2}(:,1), 'g*'); %höger
axis xy
axis equal
Xmcoord = B{2}(:,2);
Ymcoord = B{2}(:,1);
%% Forsätter med höger o samplar om till 14 punkter

%Räkna ut totala omkretsen
d_omkrets = 0;
for i = 1:length(Xmcoord)-1
   d_omkrets = d_omkrets + sqrt((Xmcoord(i+1)-Xmcoord(i)).^2+(Ymcoord(i+1)-Ymcoord(i)).^2);
end

d = d_omkrets/14;
points = zeros(14,2);
x_val = Xmcoord(1);
y_val = Ymcoord(1);
points(1,:) = [Xmcoord(1) Ymcoord(1)];
ind = 2;
d_cur = sqrt((Xmcoord(ind)-Xmcoord(ind-1))^2+(Ymcoord(ind)-Ymcoord(ind-1))^2);

for i = 2:14
while d_cur <= d*(i-1)
    ind = ind + 1;
    d_prev = d_cur;
    d_cur = d_cur + sqrt((Xmcoord(ind)-Xmcoord(ind-1))^2+(Ymcoord(ind)-Ymcoord(ind-1))^2);
end
x_prev = x_val;
y_prev = y_val;
weight = (d_cur-d*(i-1))/(d_cur-d_prev);
x_val = Xmcoord(ind)-weight*(Xmcoord(ind)-Xmcoord(ind-1));
y_val = Ymcoord(ind)-weight*(Ymcoord(ind)-Ymcoord(ind-1));
points(i,:) = [x_val y_val];
avst(i) = sqrt((x_val-x_prev)^2+(y_val-y_prev)^2);
end
avst(15) = sqrt((x_val-points(1,1))^2+(y_val-points(1,2))^2);
%%

%b_t = zeros(t,1); 
x_n = [points(6:14,1)' points(1:5,1)'; points(6:14,2)' points(1:5,2)']';
limit = 3*sqrt(e(t));
%threshold?
for i = 1:50
[D_n, x_n, T_n] = procrustes(m, x_n);

b_t = P_t'*([x_n(:,1); x_n(:,2)] - m_xy);

b_t(b_t>limit) = limit;
b_t(b_t<-limit) = -limit;

x_new = m_xy + P_t*b_t;

x_hat = (([x_new(1:14), x_new(15:28)]-T_n.c))*T_n.T'/T_n.b;

for j = 1:14 
    min_dist = 10000;
    for k = 1:length(Xmcoord)
    dist = sqrt((x_hat(j,1)-Xmcoord(k))^2 + (x_hat(j,2)-Ymcoord(k))^2);
    if dist < min_dist
        min_dist = dist;
        ind = k;
    end  
    end
    x_n(j,:) = [Xmcoord(ind) Ymcoord(ind)];
end

%db_t = P_t'*dx;
%b_t = b_t + db_t; %Antingen eller
end

figure
imagesc(dmsa_images(:,:,im_nbr))
colormap(gray)
hold on
plot(x_n(:,1),x_n(:,2), 'g*')
hold on
plot([x_n(:,1); x_n(1,1)],[x_n(:,2); x_n(1,2)], 'g')

axis xy
axis equal

%%
% Mirror the left kidney to get it in the right position in the image
figure
imagesc(dmsa_images(:,:,pat_nbr))
colormap(gray)
axis xy

hold on
drawshape_comp(models(:,pat_nbr),[1 14 1],'.-r')
drawshape_comp((size(dmsa_images,2)+1)-models(:,pat_nbr+20)',[1 14 1],'.-r')
axis equal



















