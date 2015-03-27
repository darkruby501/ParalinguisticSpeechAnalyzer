function [ss]=plot_speech_cursor(x,ss,istart,graphicPanel);

% function to plot the entire speech waveform and, using a graphics cursor,
% choose a starting sample; the region around the starting sample is then
% displayed and a second graphics cursor is used to choose the actual
% starting sample of the speech frame.

% Inputs:
%   x: speech array, sampling rate: fsd
%   ss: starting sample in speech array for frame analysis
%   istart: binary switch between first time with speech file, and
%       iteration of multiple frames
%   gp: index of graphic panel for display of speech waveforms and
%       cursors
%
% Output:
%   ss: new starting sample of speech array

% display entire speech file in top graphics panel;
% use cursor to delineate region of signal; expand signal display to +/- 1000
% samples around selected starting sample; re-display speech in top
% graphics panel; use cursor to determine actual starting sample
    reset(graphicPanel);
    axes(graphicPanel);
    cla;
    
% plot entire speech file    
    plot(0:length(x)-1,x,'k','LineWidth',2); hold on;
    xlabel('time in samples');ylabel('amplitude');grid on;axis tight;
    
% use graphics cursor to select region of speech for cepstral computation
    [xd,yd]=ginput(1);
    ss=round(xd+1);
    
% demark beginning and end of frame
    plot([ss-1 ss-1],[min(x) max(x)],'r','LineWidth',4);
    
% expand region of ss to make finer decision as to speech region for
% cepstral computation
    reset(graphicPanel);
    axes(graphicPanel);

    s1=max(ss-1000,0);
    s2=min(ss+1000,length(x)-1);
    plot(s1:s2,x(s1+1:s2+1),'k','LineWidth',2);
    xlabel('time in samples');ylabel('amplitude'); hold on;
    grid on;axis tight;
        
% use cursor to refine center of speech frame
    if (istart == 1) 
        [xd,yd]=ginput(1);
        ss=round(xd+1);
    end
    
% demark new beginning and end of frame
    plot([ss-1 ss-1],[min(x) max(x)],'r','LineWidth',4);
end