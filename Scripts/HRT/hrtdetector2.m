function [ HRT, ratio, diff] = hrtdetector2(fdata,fs0,d1,d2,hrt_treshold,speaker_mean)
%HRTDETECTOR  Determines whether an utterance has a High Rising Terminal

d1 = d1*fs0/1000;
d2 = d2*fs0/1000;

if(length(fdata)<=d2)
    ratio = [];
    HRT = [];
    diff = [];
else
    
    peak = max(fdata(end-d1:end));
    ratio = peak/speaker_mean;
    
    diff = abs(peak-speaker_mean);
    
    HRT = (ratio > (hrt_treshold));
    
end

end

