function [neededRange1, neededRange2] = getNeededRange(N1, N2, lag)
% Oct. 2014, Chau-Wai Wong
% Signal 1 is unshifted, signal 2 shifted to the right by number of lag
% units.

getCommonRange = @(a,b) [max(a(1),b(1)) min(a(2),b(2))];

rangeNew1 = [1 N1];
rangeNew2 = [1 N2] + lag;
rangeCommon = getCommonRange(rangeNew1, rangeNew2);

neededRange1 = rangeCommon;
neededRange2 = rangeCommon - lag;
