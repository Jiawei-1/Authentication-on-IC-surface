function corr = Compare_IC(insPath , template_num)
%%
% Input the input folder path and the number of the chip to be compared,
% output the correlation
% Please save 4 images in the input folder path, name them '1.png',..,'4.png'
% The corresponding scanning direction is from top to bottom, from right to left
% from bottom to top, from left to right.
% July. 2019 Jiawei Gao


load(['estimated_ideal_template',num2str(template_num),'.mat']);
load(['Reference_Set4.mat']); %Reference data
load(['Reference_Set5.mat']);

img_NORM=eval(['estimated_ideal_template',num2str(template_num)]);
img_aligned = cell(1, 4);
img_aligned_double= cell(1, 4);
Reference=cell(1, 4);

for i=1:4
    Reference{1,i}=Reference_Set4{template_num, i};
end

for idx = 1 : 4
    img_rgb = imread([insPath '\' int2str(idx) '.png']);
    img_aligned{idx} = double(img_rgb);
    [img_NORM,img_aligned{idx}] = rotate_align(img_NORM,img_aligned{idx});
end


Norm_Input = Calculate_Norm_Map(img_aligned);
Norm_Reference = Calculate_Norm_Map(Reference)

corr=Calculate_Correlation(Norm_Input, Norm_Reference);