%%
% This draft is going to generate the aligned data for chips captured by
% camera, process them (balance the intensity, remove the specular
% part) and do the camera-scanner verification (norm map and subbands of
% height map).
% Oct. 2019 Jiawei Gao
%% generate one chip's roughly cut picture group(a group contains 4 pictures)
imgPath='C:\Users\jgao25\Desktop\ipad\New folder'; % Path to the original images
imgSave='C:\Users\jgao25\Desktop\ipad\New folder'; % path to save the cropped images
Crop_IC_Camera(imgPath,imgSave);
% Nead to name the cropped image '1.png' (the light from top to bottom),
% '2.png'(the light from right to left), '3.png'(the light from bottom to
% top), '4.png' (the light from left to right)
%% align 4 chips's group separately and reorganize them to 4*4 data
Camera_Case1=cell(4,4);
imgPath1='C:\Users\jgao25\Desktop\ipad\New folder'
imgPath2='C:\Users\jgao25\Desktop\ipad\New folder'
imgPath3='C:\Users\jgao25\Desktop\ipad\New folder'
imgPath4='C:\Users\jgao25\Desktop\ipad\New folder'
for idx =1:4
    load(['estimated_ideal_template',num2str(idx),'.mat']);
    finals=Case_Camera_Generate(eval('imgPath1',int2str(idx)),idx);%input the folder path of the chips and the chip number to be aligned with
    for i =1:4
        Camera_Case1{idx,i}=finals{i};
    end
end
%% use curve fitting toolbox to get the average intensity of each chip and balance each group's intensity
for i = 1:4
    [y{i},x{i}]=hist(Camera_Case1{1,i}(:),100);
end
y1=y{1};x1=x{1};y2=y{2};x2=x{2};
y3=y{3};x3=x{3};y4=y{4};x4=x{4};%use x and y as one input pair to curve fitting toolbox, choose 'Gaussian' fit and 'Bisquare' robust

means=[0.1485,0.1493,0.1631,0.1522]% The abscissa of the axis of symmetry for each curve
Mean=mean(means(:));img=[]
for i=1:4
    img=Camera_Case1{1,i};
    Camera_Case1_balanced{1,i}=img./means(i).*Mean;
end

%% make the scatter plot to find the specular points

scatter(Camera_Case1_balanced{1,2}(:),Camera_Case1_balanced{1,4}(:))
xlim([0,0.7]);
ylim([0,0.7]);
title('Scatter plot of Norm map X (Chip1)')


%% generate the norm map and remove the specular reflection
[Case1_Normmap_X,Case1_Normmap_Y] = Calculate_Norm_Map_Case(Camera_Case1_balanced);
for i = 1:4
    location1=find(abs(Camera_Case1_balanced{i,1}-Camera_Case1_balanced{i,3})>0.3);
    location2=find(abs(Camera_Case1_balanced{i,2}-Camera_Case1_balanced{i,4})>0.3);
    Case1_Normmap_X{i}(location2)=0.5*(Case1_Normmap_X{i}(location2-1)+Case1_Normmap_X{i}(location2+1));
    Case1_Normmap_Y{i}(location1)=0.5*(Case1_Normmap_Y{i}(location1+1)+Case1_Normmap_Y{i}(location1+1));
end
%% calculate the correlation between camera and scanner's norm maps
load('img_x_set5{i}')% norm map X of the scanner case
load('img_y_set5{i}')% norm map Y of the scanner case
for i=1:4
    for j=1:4
        corr(i,j)=calcPearsonCorr2(img_x_set5{i}, Case1_Normmap_X{j});
    end
end

%% generate the height map and calculate the correlation between camera and scanner's height maps' subbands
for i =1:4
    surface_camera = get_surface(Case1_Normmap_X{i},Case1_Normmap_X{i},nx,ny);
    for ii =1:4
        surface_scanner = get_surface(img_x_set5{ii},img_y_set5{ii},nx,ny);
        sub_camera = get_subbands(surface_camera, 8);
        sub_scanner = get_subbands(surface_scanner, 8);
        for j= 1:10
            corr_height(i*4+ii-4,j)=calcPearsonCorr2(sub_camera(j,:,:),sub_scanner(j,:,:));
        end
    end
end