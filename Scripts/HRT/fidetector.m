function [FI,ratio,diff ] = fidetector(fdata,fs0,d1,d2,fi_threshold,speaker_mean)
%HRTDETECTOR  Determines whether an utterance has a High Rising Terminal

d1 = d1*fs0/1000;
d2 = d2*fs0/1000;

if(length(fdata)<=d2)
    ratio = [];
    FI = [];
    diff = [];
else
    
    Tmean = mean(fdata(end-d1:end));
    
    C1 = Tmean < speaker_mean; %Ensures that drop is not just a return from above average
    C2 = Tmean < mean(fdata)*fi_threshold; %Represents that there is a drop from the rest of the utterance
    
%     Although FI intonation is the opposite of rising intonation, a
%     number of requirements mean that it must be detected differently.
    
    
    ratio = Tmean/speaker_mean;
    diff = abs(Tmean-speaker_mean);
    FI = C1 && C2;

    
end

end
