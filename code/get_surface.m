function surface = get_surface(scanner_x, scanner_y, nx, ny)%, mask)
%addpath('C:\Users\rliu10\Desktop\mobile_imaging\project_counterfeit\c_surfaceReconstruction\refactored_1\normal_to_surface');
% use nx, ny as reference
x1 = nx;
y1 = ny;
x2 = scanner_x;
y2 = scanner_y;

scale_x = std(x2(:)) / std(x1(:));
scale_y = std(y2(:)) / std(y1(:));
scale=sqrt(0.5*(scale_x^2+scale_y^2));
x2 = x2  / scale;
y2 = y2  / scale;
z2 = zeros(249,299);

for i = 1:249
    for j = 1:299
        z2(i,j) = sqrt(1-x2(i,j)^2-y2(i,j)^2);
    end
end

dzdx = x2 ./ z2;% dzdx(~mask) = 0;
dzdy = y2 ./ z2;% dzdy(~mask) = 0;
% dzdx = dzdx(21:180,21:180);
% dzdy = dzdy(21:180,21:180);
surface = frankotchellappa(dzdx, dzdy);

end