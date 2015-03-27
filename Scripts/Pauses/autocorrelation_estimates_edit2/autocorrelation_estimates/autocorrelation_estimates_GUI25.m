function autocorrelation_estimates_GUI25
% Modifiable runGUI file
clc;
clear all;
fileName = 'autocorrelation_estimates.mat';    %USER - ENTER FILENAME
fileData=load(fileName);
temp=fileData(1).temp;

f = figure('Visible','on',...
'Units','normalized',...
'Position',[0,0,1,1],...
'MenuBar','none',...
'NumberTitle','off');

%SENSE COMPUTER AND SET FILE DELIMITER
switch(computer)				
    case 'MACI64',		char= '/';
    case 'GLNX86',  char='/';
    case 'PCWIN',	char= '\';
    case 'PCWIN64', char='\';
    case 'GLNXA64', char='/';
end


% find speech files directory by going up one level and down one level
% on the directory chain; as follows:
    dir_cur=pwd; % this is the current Matlab exercise directory path 
    s=regexp(dir_cur,char); % find the last '\' for the current directory
    s1=s(length(s)); % find last '\' character; this marks upper level directory
    dir_fin=strcat(dir_cur(1:s1),'speech_files'); % create new directory
    start_path=dir_fin; % save new directory for speech files location

%USER - ENTER PROPER CALLBACK FILE
Callbacks_autocorrelation_estimates_GUI25(f,temp,start_path); 

%panelAndButtonEdit(f, temp);       % Easy access to Edit Mode
% Note comment PanelandBUttonCallbacks(f,temp) if panelAndButtonEdit is to
% be uncommented and used
end

% 2 Panels
%   #1 - files/parameters
%   #2 - graphics
% 8 Graphics Panels
%   4 autocorrelation types showing frame of speech and autocorrelation 
% 1 Titlebox
% 12 buttons
%   #1 - pushbutton - Speech Directory
%   #2 - popupmenu - Speech Files
%   #3 - popupmenu - window type
%   #4 - editable button - ss: starting sample
%   #5 - editable button - Lmsec: window duration in msec
%   #6 - editable button - Mmsec: window shift in msec
%   #7 - editable button - pdlow: lowest valid pitch period
%   #8 - editable button - pdhigh: highest valid pitch period
%   #9 - editable button - P: clipping level percentage
%   #10 - pushbutton - Run Single Frame Analysis
%   #11 - pushbutton - Play speech file/Run Pitch Detection of File
%   #12 - pushbutton - Close GUI