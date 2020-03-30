%%
% This draft is to polt the error curve for the point light model
% Oct. 2019 Jiawei Gao
%%
[nx_c,ny_c,nz_c]=get_normmap(img_X,img_Y,nx,ny);
% img_X and img_Y are one calculated norm map from a camera case.
% nx and ny are norm map from the confocal microscope
%% fix the point location and change the distance between camera and chip
for  L=10:1:200
    j=L-9;
    l(j)=L;
    
    eta=1.3/L;
    L=L/100;
    ETA(j)=eta;
    for i=1:74451
        err(i)=abs((((1/sqrt(2)-eta/2)*nx_c(i)+ny_c(i)*eta/2+nz_c(i)/sqrt(2))/(L^2*(1+0.5*eta^2-eta/sqrt(2))^1.5)-((-1/sqrt(2)-eta/2)*nx_c(i)+ny_c(i)*eta/2+nz_c(i)/sqrt(2))/(L^2*(1+0.5*eta^2+eta/sqrt(2))^1.5))-(sqrt(2)*nx_c(i))/L^2);
    end
    MEAN(j) = mean(err);
    STD(j) = std(err);
end
plot(l,MEAN);
hold on
plot(l,MEAN-STD);
hold on
plot(l,MEAN+STD);

legend('mean','mean-std','mean+std');
xlabel('L (camera-chip distance)/cm')
ylabel('absolute error |n_x - n_xraw|')
title('L (distance to the center)=0.92cm')

%% fix the distance and change the point location
for  A=1:130
    j=A;
    l(j)=A/100/sqrt(2);
    L=0.2; % fix the distance
    eta=(A-1)/10000/L;
    ETA(j)=eta;
    for i=1:74451
        err(i)=abs((((1/sqrt(2)-eta/2)*nx_c(i)+ny_c(i)*eta/2+nz_c(i)/sqrt(2))/(L^2*(1+0.5*eta^2-eta/sqrt(2))^1.5)-((-1/sqrt(2)-eta/2)*nx_c(i)+ny_c(i)*eta/2+nz_c(i)/sqrt(2))/(L^2*(1+0.5*eta^2+eta/sqrt(2))^1.5))-(sqrt(2)*nx_c(i))/L^2);
    end
    MEAN(j) = mean(err);
    STD(j) = std(err);
end
MEAN=[]
STD=[]
l=[]
% for L = 10:2:200
%     j=(L-8)/2;
%         l(j)=L;
% end
plot(l,MEAN);
hold on
plot(l,MEAN-STD);
hold on
plot(l,MEAN+STD);

legend('mean','mean-std','mean+std');
xlabel('A (distance to the center)/cm')
ylabel('absolute error |n_x - n_xraw|')
title('L (camera-chip distance)=20cm')
ylim([0 2.5])