function Crop_IC_Camera(imgPath,imgSave)
%%
% With coarse cropping and a rotation angle specified by human,
% save each upright chip image to a PNG file.
% Enter the path saving the input image and the path to output the PNG file,
% enter a rotate angle to rotate one image and cut it rough by hand.
% Oct. 2019 Jiawei Gao

% imgPath='C:\Users\jgao25\Desktop\ipad\New folder';
% imgSave='C:\Users\jgao25\Desktop\ipad\New folder';
imgPath = [imgPath '\']
imgDir  = dir([imgPath,'*.jpg']);
img_rgb = imread([imgPath imgDir(1).name]);
img_rgb=rgb2gray(img_rgb);
img_rgb=double(img_rgb);
imshow(img_rgb,[]);
%%  Rotate the picture to the right direction
angle = input('Please enter the rotate angle:');
img = imrotate(img_rgb, angle,'bicubic');
imshow(img,[]);
%%  Cut the picture roughly
h = drawrectangle('Position',[1 1 100 100]);
pos = customWait(h);
x_range = floor(pos(1)) :  ceil(pos(1) + pos(3));
y_range = floor(pos(2))  :  ceil(pos(2)  + pos(4));
%%  Rotate and cut the chips, save them
for i = 1:length(imgDir)
    img_rgb = imread([imgPath imgDir(i).name]);
    img_rgb=rgb2gray(img_rgb);
    img_rgb=double(img_rgb)./255;
    img = imrotate(img_rgb, angle,'bicubic');
    imshow(img,[]);
    
    img_crop = img(y_range, x_range);
    imshow(img_crop,[]);
    
    save_name = input('Please enter the save name:') % Enter the name, for example: '1.png'
    imwrite(img_crop,fullfile(imgSave,save_name));
end
