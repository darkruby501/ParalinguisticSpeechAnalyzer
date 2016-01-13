function [ SpeechHeader, SpeechData, FHeader, FData] = sfspitch( filename )
%SFSPITCH This function uses SFS to compute the pitch contour of a wavfile.
%   Input:
%           filename - string containing name and location
% 
%   Output: fx - pitch track

[path1, name1, ext1] = fileparts(filename);
sfsname = [name1 '.sfs'];

cd(path1);

%% Pitch Analysis

% Process with SFS

error = system(['cnv2sfs -i sp ' [name1 ext1] ' ' sfsname])
error = system(['fxrapt -i sp ' sfsname])
error = system(['fxsmooth -i fx -m 50 -d -s 50 -j ' sfsname])  %%% EDIT: refine value for smoothing window (sigma = half-frame?)


[SpeechHeader,SpeechData] = sfsgetitem(sfsname,'sp');
[FHeader,FData]=sfsgetitem(sfsname,'fx');








end

