function [ HRTstat ] = hrtstat( HRTmat )
%UNTITLED4 Summary of this function goes here

HRTstat.meanratio = mean(HRTmat(:,1));
temp = HRTmat(logical(HRTmat(:,2)),:);
HRTstat.meanHRTratio = mean(temp(:,1));
HRTstat.meandiff = mean(HRTmat(:,3));
HRTstat.meanHRTdiff = mean(temp(:,3));
HRTstat.stddiff = std(HRTmat(:,3));
HRTstat.percentage = sum(HRTmat(:,2))/length(HRTmat);
HRTstat.num = size(HRTmat,1);
HRTstat.numHRT = size(temp,1);


end

