function Crop_IC_Scanner(imgPath,imgSave)
%% 
% With coarse cropping and a rotation angle specified by human, 
% save each upright chip image to a PNG file.
% Enter the path saving the input image and the path to output the PNG file,
% enter a rotate angle to rotate one image and cut it rough by hand. 
% July. 2019 Jiawei Gao

imgPath = [imgPath '\']
imgDir  = dir([imgPath,'*.tiff']);
for i = 1:length(imgDir)          % 
    img_rgb = imread([imgPath imgDir(i).name]);
    img_gray = rgb2gray(img_rgb);
    img_double=double(img_gray)./255;
    imshow(img_double,[]);
    
    angle = input('Please enter the rotate angle:'); %Rotate the picture to the right direction
    img = imrotate(img_double, angle,'bicubic');
    imshow(img,[]);
    
    h = drawrectangle('Position',[1 1 100 100]); %Cut the picture roughly
    pos = customWait(h);
%     img = rgb2gray(img);
    x_range = floor(pos(1)) :  ceil(pos(1) + pos(3));
    y_range = floor(pos(2))  :  ceil(pos(2)  + pos(4));
    img_crop = img(y_range, x_range);
    imshow(img_crop,[]);
    
    save_name = input('Please enter the save name:') % Enter the name, for example: '1.png'
    imwrite(img_crop,fullfile(imgSave,save_name)); 
end
