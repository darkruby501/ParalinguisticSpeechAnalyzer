function [ HRT, ratio, diff] = hrtdetector(fdata,fs0,d1,d2,hrt_treshold,speaker_mean)
%HRTDETECTOR  Determines whether an utterance has a High Rising Terminal

d1 = d1*fs0/1000;
d2 = d2*fs0/1000;

if(length(fdata)<=d2)
    ratio = [];
    HRT = [];
    diff = [];
else
    
    fdata1 = fdata(end-d1:end);
    fdata2 = fdata(end-d2:end-d1);
    meanf = mean(fdata(fdata>0));
    meanf1 = mean(fdata1(fdata1>0));
    meanf2 = mean(fdata2(fdata2>0));
    
%     ratio = meanf1/meanf2;
%     diff = abs(meanf1-meanf2);
%     
%     HRT = (ratio > (hrt_treshold));
%     
    
    ratio = meanf1/speaker_mean;
    diff = abs(meanf1-speaker_mean);
    
    HRT = (ratio > (hrt_treshold));
    
end

end

