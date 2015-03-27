function [peak,level]=pitch_doubling_check(peak,pdlow,ac,level)
%
% function to check on pitch period doubling and correct peak
% autocorrelation estimate when pitch period doubling occurs
%
% Inputs:
%   peak: pitch period at peak of autocorrelation function (within valid
%       pitch period region)
%   pdlow: lowest allowable pitch period
%   ac: autocorrelation for current frame
%   level: autocorrelation level at peak1
%
% Outputs:
%   peak: pitch period after check for pitch period doubling
%   level: autocorrelation level after check for pitch period doubling

% check for pitch period doubling
    if (floor(peak/2) > pdlow && ac(floor(peak/2)) >= level*0.8)
        peak=floor(peak/2);
        level=ac(floor(peak/2));
    end
end