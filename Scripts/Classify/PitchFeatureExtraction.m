% PITCH FEATURE VECTOR EXTRACTION

BIN_NUM = 2;

if(~exist('Sp','var'))
load('D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\SpFile.mat');
end

n = 20; %Number of points extracted from Pitch Contour

for j = 1:length(Sp)
    
    bin_INDX = find(Sp(j).Bins.Index(:,BIN_NUM));
    PitchVec = nan(length(bin_INDX),n); 
    
    for i = 1:length(bin_INDX)
        
        X = Sp(j).Utter(bin_INDX(i)).FIntrp;
        x = round(linspace(1,length(X),n));
        PitchVec(i,:) = X(x);
        
%         N = (1:length(X))/100;
%         plot(N,X,'linewidth',1.5)
%         x = round(linspace(1,length(X),n));
%         hold on
%         plot(x/100,X(x)','rx','MarkerSize',10,'linewidth',1.5)
%         xlabel('t (s)')
%         ylabel('deviation from mean')
%         title(['Utterance ' num2str(bin_INDX(i))])
        
    
    end
    
    Sp(j).PitchFVec = PitchVec;
    
end