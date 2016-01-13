function [ FIstat ] = fistat( HRTmat )
%UNTITLED4 Summary of this function goes here

FIstat.meanratio = mean(HRTmat(:,1));
temp = HRTmat(logical(HRTmat(:,2)),:);
FIstat.meanFIratio = mean(temp(:,1));
FIstat.meandiff = mean(HRTmat(:,3));
FIstat.meanFIdiff = mean(temp(:,3));
FIstat.stddiff = std(HRTmat(:,3));
FIstat.percentage = sum(HRTmat(:,2))/length(HRTmat);
FIstat.num = size(HRTmat,1);
FIstat.numFI = size(temp,1);


end

