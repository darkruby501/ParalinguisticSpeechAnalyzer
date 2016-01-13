function [ SpeechHeader, SpeechData, FHeader, FData] = sfspitch2(filename, smoothing,intrp,reuse)
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

if(~(reuse&&exist(sfsname,'file')))
    
    error = system(['cnv2sfs -i sp ' [name1 ext1] ' ' sfsname])
    error = system(['fxrapt -i sp ' sfsname])
    
    if(intrp)
        error = system(['fxsmooth -i fx -j ' sfsname])  %%% EDIT: refine value for smoothing window (sigma = half-frame?)
    else
        error = system(['fxsmooth -i fx ' sfsname])  %%% EDIT: refine value for smoothing window (sigma = half-frame?)
    end
    
end

[SpeechHeader,SpeechData] = sfsgetitem(sfsname,'sp');
[FHeader,FData]=sfsgetitem(sfsname,'fx');



cd(CurDir);




end

