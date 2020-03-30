%%
%This draft is to generate the template model using scanner's data.
%Use phase correlation to reduce the range of image to be aligned
%After get the aligned picture, we can delete some bad pics and generate the template
pos=cell(1,4);
img_final=cell(1,4);

img_NORM=load('estimated_ideal_template1.mat');

[Width,Length]=size(img_NORM);
if  mod(Width,2)==0
    Width=Width-1;
end
if  mod(Length,2)==0
    Length=Length-1;
end
img_NORM=img_NORM(1:Width,1:Length);
%%
for idx = 1 : 4
    img_rgb = imread([int2str(idx-1) '.tiff']); %Need to name the pictures in order of light direction
    img = imrotate(img_rgb, 180 - (idx-1)*90);
    figure (idx)
    imshow(img);
    
    h = drawrectangle('Position',[1 1 100 100]);%Crop the ROI
    pos{idx} = customWait(h);
    
    img = rgb2gray(img);
    img=double(img);
    point1=[floor(pos{idx}(1)),floor(pos{idx}(2))];
    h_bg = ceil(pos{idx}(3));
    w_bg =ceil(pos{idx}(4));
    if  mod(h_bg,2)==0 %The ROI's length and width need to be odd
        h_bg=h_bg-1;
    end
    if  mod(w_bg,2)==0
        w_bg=w_bg-1;
    end
    
    extend = max((h_bg-Length)/2 , (w_bg-Width)/2)
    h_bg=Length+2*extend-1;
    w_bg=Width+2*extend-1;
    
    x_range = point1(1) :  point1(1)+h_bg;
    y_range = point1(2)  :  point1(2)+w_bg;
    
    img_crop = img(y_range, x_range);
    img_final{idx}=img_crop;
    
    [corrVal_max, bestMatchedPoint, corrMap] = patchCorr_oneSearchMaskOnTheOther(img_final{idx}, img_NORM, extend, 3); %Using phase correlation to find the best matched point
    img_final{idx}=img_final{idx}(bestMatchedPoint.y+extend+3:bestMatchedPoint.y+extend+Width-1,bestMatchedPoint.x+extend+3:bestMatchedPoint.x+extend+Length-1);%Keep a little more points
    figure (idx)
    imshow(img_final{idx});
    [img_NORM,img_final{idx}]=rotate_align(img_NORM,img_final{idx});
    figure (idx)
    imshow(img_final{idx});
end
