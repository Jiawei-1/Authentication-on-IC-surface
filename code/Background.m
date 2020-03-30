
function a = Background(a)
a(45:131,15:280)=NaN;
a(209:230,40:209)=NaN;
[m,n] = size(a);
a = reshape(a, m*n, 1);
a(isnan(a))=[];
end