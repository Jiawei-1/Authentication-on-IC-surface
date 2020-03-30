function [Norm_Map_X, Norm_Map_Y] = Calculate_Norm_Map_Case(img)
for i =1:4
    Norm_Map_X{i}=img{i,2}-img{i,4};
    Norm_Map_Y{i}=img{i,1}-img{i,3};
end