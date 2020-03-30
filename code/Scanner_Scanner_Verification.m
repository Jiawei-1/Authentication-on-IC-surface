%%
% This draft is to do the scanner-scanner verification.
% Oct. 2019 Jiawei Gao
%% crop one chip from the scans
imgPath = 'C:\Users\jgao25\Desktop\ipad\New folder';% please put scans in 4 different light directions to the folder
imgSave = 'C:\Users\jgao25\Desktop\ipad\New folder';
Crop_IC_Scanner(imgPath,imgSave);
% Please save 4 images in the input folder path, name them '1.png',..,'4.png'
% The corresponding scanning direction is from top to bottom, from right to left
% from bottom to top, from left to right.
%% calculate the correlation of the norm map (text regions, background, the whole norm map) between the input and reference chip
correlation=Compare_IC(imgSave,i);% i is the number for the reference (four in total)
