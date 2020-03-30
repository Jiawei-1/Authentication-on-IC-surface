function [corrVal_max, bestMatchedPoint, corrMap] = patchCorr_oneSearchMaskOnTheOther(imgBg, imgMask, extend, mode)

convertToIdx = @(range) range(1):range(2);

[h_bg  , w_bg  ] = size(imgBg);
[h_mask, w_mask] = size(imgMask);

 if mod(h_bg,2)==0 || mod(w_bg,2)==0 || mod(h_mask,2)==0 || mod(w_mask,2)==0
     error('Dimensions of the images should be odd numbers');
 end

 if w_bg-w_mask~=2*extend || h_bg-h_mask~=2*extend
     error('The size of the background image should be calculated according to the size of the mask image and the extend for cross-correlation.');
 end


[vec_hori, vec_vert] = meshgrid(-extend:extend,-extend:extend);
sCnt = length(vec_hori(:));
corrVal = zeros(sCnt, 1);
for sIdx = 1:sCnt
    
    lag = struct('x', vec_hori(sIdx)+extend, 'y',  vec_vert(sIdx)+extend);

    im1 = double ( imgBg ( convertToIdx([1 h_mask]+lag.y), convertToIdx([1 w_mask]+lag.x) ) );
    im2 = double ( imgMask );
    
    % corrVal(sIdx) = corr(im1(:), im2(:), 'type', 'Pearson');
    corrVal(sIdx) = calcPearsonCorr(im1(:), im2(:)); % 30% faster
end

%surf(vec_hori, vec_vert, reshape(corrVal, size(vec_hori)));
%plot(sort(corrVal, 'descend'), 'o')
[corrVal_max, idx_max] = max(corrVal);
bestMatchedPoint = struct('x', vec_hori(idx_max), 'y', vec_vert(idx_max));
corrMap.val = reshape(corrVal, size(vec_hori));
corrMap.x = vec_hori;
corrMap.y = vec_vert;