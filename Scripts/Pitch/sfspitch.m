function [ SpeechHeader, SpeechData, FHeader, FData] = sfspitch(filename, smoothing,intrp)
%SFSPITCH This function uses SFS to compute the pitch contour of a wavfile.
%   Input:
%           filename - string containing name and location
% 
%   Output: fx - pitch track

if(nargin<2)
    smoothing = 50;
end


[path1, name1, ext1] = fileparts(filename);
sfsname = [name1 '.sfs'];


CurDir = pwd;
cd(path1);

%% Pitch Analysis

% Process with SFS

error = system(['cnv2sfs -i sp ' [name1 ext1] ' ' sfsname])
error = system(['fxrapt -i sp ' sfsname])

if(intrp)
    error = system(['fxsmooth -i fx -m 50 -d -s ' num2str(smoothing) ' -j ' sfsname])  %%% EDIT: refine value for smoothing window (sigma = half-frame?)
else
    error = system(['fxsmooth -i fx -m 50 -d -s ' num2str(smoothing) ' ' sfsname])  %%% EDIT: refine value for smoothing window (sigma = half-frame?)
end
    
[SpeechHeader,SpeechData] = sfsgetitem(sfsname,'sp');
[FHeader,FData]=sfsgetitem(sfsname,'fx');



cd(CurDir);




end

