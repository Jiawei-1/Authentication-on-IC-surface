
function a = TextRegions(a)
a1=a(45:131,15:280);
a2=a(209:230,40:209);
[m,n] = size(a1);
a1 = reshape(a1, m*n, 1);
[m,n] = size(a2);
a2 = reshape(a2, m*n, 1);
a=[a1;a2];
end