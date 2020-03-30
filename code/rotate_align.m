function [Fixed Registered]=rotate_align(fixed,moving)
%% This function will align 'Registered' image with 'Fixed' image

%Estimate the registration required to bring these two images into alignment. imregcorr returns an affine2d object that defines the transformation.
tformEstimate = imregcorr(moving, fixed); %,'rigid');

%Apply the estimated geometric transform to the misaligned image. Specify 'OutputView' to make sure the registered image is the same size as the reference image. Display the original image and the registered image side-by-side. You can see that imregcorr has done a good job handling the rotation and scaling differences between the images. The registered image, movingReg, is very close to being aligned with the original image, fixed. But some misalignment remains. imregcorr can handle rotation and scale distortions well, but not shear distortion.
Rfixed = imref2d(size(fixed));
movingReg = imwarp(moving,tformEstimate,'OutputView',Rfixed);

% imshowpair(fixed,movingReg,'montage');

%View the aligned image overlaid on the original image, using imshowpair. In this view, imshowpair uses color to highlight areas of misalignment.

% imshowpair(fixed,movingReg,'falsecolor');

%To finish the registration, use imregister, passing the estimated transformation returned by imregcorr as the initial condition. imregister is more effective if the two images are roughly in alignment at the start of the operation. The transformation estimated by imregcorr provides this information for imregister. The example uses the default optimizer and metric values for a registration of two images taken with the same sensor ( 'monomodal' ).
% [optimizer, metric] = imregconfig('monomodal');
% movingRegistered = imregister(moving, fixed,...
%     'similarity', optimizer, metric,'InitialTransformation',tformEstimate);%'affine', optimizer, metric,'InitialTransformation',tformEstimate);
% % imshow(movingRegistered)
% %Display the result of this registration. Note that imregister has achieved a very accurate registration, given the good initial condition provided by imregcorr.
% % imshowpair(fixed, C,'Scaling','joint');
Fixed =fixed;
% Registered = movingRegistered;
Registered = movingReg;