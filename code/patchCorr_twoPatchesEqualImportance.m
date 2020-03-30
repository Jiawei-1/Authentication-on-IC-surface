function [corrVal_max, bestMatchedPoint, corrMap] = patchCorr_twoPatchesEqualImportance(trueImg, testImg, sWinSize, mode)

convertToIdx = @(range) range(1):range(2);
img1 = trueImg; img2 = testImg;

[h1, w1] = size(img1);
[h2, w2] = size(img2);

[vec_hori, vec_vert] = meshgrid(-sWinSize:sWinSize,-sWinSize:sWinSize);
sCnt = length(vec_hori(:));
corrVal = zeros(sCnt, 1);
for sIdx = 1:sCnt
    
    lag = struct('x', vec_hori(sIdx), 'y',  vec_vert(sIdx));
    
    [neededRange1.x, neededRange2.x] = getNeededRange(w1, w2, lag.x);
    [neededRange1.y, neededRange2.y] = getNeededRange(h1, h2, lag.y);
    
    im1 = double ( img1 ( convertToIdx(neededRange1.y), convertToIdx(neededRange1.x) ) );
    im2 = double ( img2 ( convertToIdx(neededRange2.y), convertToIdx(neededRange2.x) ) );
    
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