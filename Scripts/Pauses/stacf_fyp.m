function [ac_speech_flag,ac_vec,phi0,L,R,se,snext,frame_energy] = stacf_fyp(x_in,fs,ss,ac_level,Lm,Rm,Km,Klowm)
% 27-03-15


% 28-03-15 Function is working kind of nicely

subplot(2,1,1)


%% Variables


% Lm = 30; %size of frame in ms
% Rm = 0; %size of shift in ms
L = 0; % frame size in samples
R = 0;
% Km = 12.5; % Longest pitch period in ms (lowest frequency)
% Klowm = 2; % Shortest pitch period in ms (highest frequency)

% ac_level = 0.4; %Minimum required value of largest peak to be classified as speech




%% 1) Read in File

% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short.wav';
% [wavfile,fs] = wavread(filename);

L = round(Lm*(fs/1000));
R = round(Rm*(fs/1000));
K = ceil(Km*(fs/1000));
Klow = floor(Klowm*(fs/1000));

se = ss + L;
snext = ss + R;
%% 2) Segment speech


% So his magic function is:

 
% [L,M,K,pdlow,period,plevel,peakac,ac1,ac2,ac3,ac4,xw1,xw2,xw3,xw4,xwe2,xwe3,xwe4]=...
%     
% autocorrelation_analysis(xin,fs,wtype,ss,Lmsec,Mmsec,pdlow,K,P,fid)
    
 
% Copy
xs = x_in(ss:ss+L);
%     subplot(2,1,1)    
%     plot(wavfile(ss:ss+L))

frame_energy = 10*log10(sum(xs.^2));
        
window=hamming(L);
xw=xs(1:L).*window(1:L); %x-window, after applying window function

[ac_x,lags] = xcorr(xw,K); %autocorrelation of x
ac_x1 = ac_x(K+1:end);
phi0 = ac_x1(1);
ac_x1 = ac_x1/phi0;

ac_vec = ac_x1; 

%     subplot(2,1,2)
%     plot(lags(K+1:end),ac_x1);
    grid on

[peaks, peak_loc] = findpeaks(ac_x1(Klow:end));

%%%
% Check if largest peak is significant
ac_speech_flag = (max(peaks)>= 0.4);
if(isempty(ac_speech_flag))
    ac_speech_flag = 0;
end
%%%


end

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