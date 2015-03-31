% My Pause Detection Development Script

% 27/03/15

clear all;
close all;

subplot(2,1,1)


%% Variables


Lm = 30; %size of frame in ms
Rm = 0; %size of shift in ms
L = 0; % frame size in samples
R = 0;
Km = 12.5; % Longest pitch period in ms (lowest frequency)
ac_level = 0.4 %Minimum required value of largest peak to be classified as speech

ss = 5000;



%% 1) Read in File

filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short.wav';
[wavfile,fs] = wavread(filename);

L = Lm*(fs/1000);
K = Km*(fs/1000);
%% 2) Segment speech


% So his magic function is:

 
% [L,M,K,pdlow,period,plevel,peakac,ac1,ac2,ac3,ac4,xw1,xw2,xw3,xw4,xwe2,xwe3,xwe4]=...
%     
% autocorrelation_analysis(xin,fs,wtype,ss,Lmsec,Mmsec,pdlow,K,P,fid)
    
 
% Copy
xs = wavfile(ss:ss+L);
    subplot(2,1,1)    
    plot(wavfile(ss:ss+L))
energy = sum(xs.^2);
        
window=hamming(L);
xw=xs(1:L).*window(1:L); %x-window, after applying window function

[ac_x,lags] = xcorr(xw,K); %autocorrelation of x
ac_x1 = ac_x(K+1:end);
phi0 = ac_x1(1);
ac_x1 = ac_x1/phi0;

    subplot(2,1,2)
    plot(lags(K+1:end),ac_x1);

[peaks, peak_loc] = findpeaks(ac_x1);

%%%
% Check if largest peak is significant
ac_speech_flag = (max(peaks)>= 0.4);

%%%




%  % type 1 short time autocorrelation
%         xw1=xs(1:L).*window(1:L);
%         ac1p=xcorr(xw1,K);
%         ac1=ac1p(K+1:2*K+1)'/ac1p(K+1); %restrict to range of interest and normalise
%         plev1=ac1p(K+1); %peak level
%         peaks=find(ac1(pdlow:K) == max(ac1(pdlow:K))); %find location of values equal to maximum within specfied range
%         peak1=peaks(1)+pdlow-2; %find actual peak index
%         level1=ac1(peak1);   %find peak level
%     
%     
    
    
    
    
    
    
    
    



























%% Misc

%Play file 
% soundsc(curr_file,fs)