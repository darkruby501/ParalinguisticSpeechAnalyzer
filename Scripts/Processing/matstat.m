function [ num, mean_dur, var_dur, total_dur] = matstat(Mat,last)
% MATSTAT performs statistics on Speech/Pause Matrices

% last - 1 to include last entry (used to exclude final pause

if(~last)
    Mat = Mat(1:end-1,:);
end
    
num = size(Mat,1);
mean_dur = mean(Mat(:,3));
var_dur = var(Mat(:,3));
total_dur = sum(Mat(:,3));

end

