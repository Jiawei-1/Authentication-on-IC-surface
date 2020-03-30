function corr= Calculate_Correlation(Input, Reference)
%%
corr_X=calcPearsonCorr2(Input.X, Reference.X);
corr_Y=calcPearsonCorr2(Input.Y, Reference.Y);
corr_X_back=calcPearsonCorr2(Input.X_Back, Reference.X_Back);
corr_Y_back=calcPearsonCorr2(Input.Y_Back, Reference.Y_Back);
corr_X_text=calcPearsonCorr2(Input.X_Text, Reference.X_Text);
corr_Y_text=calcPearsonCorr2(Input.Y_Text, Reference.Y_Text);
%%
corr = struct('corr_X', corr_X, 'corr_Y',corr_Y,'corr_X_back',...
    corr_X_back,'corr_Y_back',corr_Y_back,'corr_X_text',corr_X_text,...
    'corr_Y_text',corr_Y_text);