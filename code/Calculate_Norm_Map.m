function Norm_Map = Calculate_Norm_Map(img)
%%
% input 4 scan images and calculate the whole norm map, the norm map with out 
% text region, the norm map of the text region 

Norm_Map_X=img{2}-img{4};
Norm_Map_Y=img{1}-img{3};
Norm_Map_X_back=Background(Norm_Map_X);
Norm_Map_Y_back=Background(Norm_Map_Y);
Norm_Map_X_text=TextRegions(Norm_Map_X);
Norm_Map_Y_text=TextRegions(Norm_Map_Y);
%%
Norm_Map=struct('X',Norm_Map_X,'Y',Norm_Map_Y,'X_Back',Norm_Map_X_back...
    ,'Y_Back',Norm_Map_Y_back,'X_Text',Norm_Map_X_text,'Y_Text',...
    Norm_Map_Y_text)

end
