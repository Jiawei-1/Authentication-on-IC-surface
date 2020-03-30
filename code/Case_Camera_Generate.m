function Case_Camera = Case_Camera_Generate(imgPath,template_num)

imgPath = [imgPath '\'];
load(['estimated_ideal_template',num2str(template_num),'.mat']);
img_NORM=eval(['estimated_ideal_template',num2str(template_num)]);
for idx = 1 : 4
    img = imread([imgPath int2str(idx) '.png']);
    img_double{idx} = double(img)./255;
end
img_average=(img_double{1}+img_double{4}+img_double{2}+img_double{3})./4;
for idx = 1 : 4
    tformEstimate = imregcorr(img_average, img_NORM); %,'rigid');
    Rfixed = imref2d(size(img_NORM));
    img_final{idx} = imwarp(img_double{idx},tformEstimate,'OutputView',Rfixed);
    % %     imwrite(img_final{idx},[int2str(idx) '.tiff'])
    figure (idx)
    imshow(img_final{idx},[]);
end
Case_Camera=img_final;