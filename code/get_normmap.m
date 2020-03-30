function [nx_c,ny_c,nz_c]=get_normmap(scanner_x,scanner_y,nx,ny)
x1 = nx(:);
y1 = ny(:);
x2 = scanner_x(:);
y2 = scanner_y(:);

scale_x = std(x2(:)) / std(x1(:));
scale_y = std(y2(:)) / std(y1(:));
scale=sqrt(0.5*(scale_x^2+scale_y^2));
nx_c = x2  ./ scale;
ny_c = y2  ./ scale;
nz_c = sqrt(1-nx_c.^2-ny_c.^2);