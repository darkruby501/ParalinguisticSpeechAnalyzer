% My Pause Detection Development Script
% 31-03-15

% close all;
% clear all;


% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_44_mono.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_sample_mono.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_sample_short_Brienne_noise.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short.wav';
filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Miranda_passage';

[wavfile,fs,nbits] = wavread(filename);

% wavfile = wavfile(837000:1560000);
% 
% if(length(wavfile) > 10*fs)
%     wavfile = wavfile(1:10*fs);
% end

n = length(wavfile);

%% Variables

ac_level = 0.4;
min_pause = 200; %ms
min_speech = 200; %ms
safety = 0;

MinPause = 200; %for final counting

Lm = 30; %size of frame in ms
Rm = 10; %size of shift in ms

Km = 12.5; % Longest pitch period in ms (lowest frequency)
Klowm = 0.1;

e_diff_thresh = 30; % Allowable difference from loudest frame before cutoff.

PauseVec_n = zeros(length(wavfile),1); %1 for speech, 0 for noise/pause.
Energy_Contour = zeros(length(wavfile),1); %1 for above threshold, 0 for below.
EnergyVec = zeros(length(wavfile),1); %1 for above threshold, 0 for below.
SpeechVec = zeros(length(wavfile),1); %1 for speech, 0 for pause.
Phi_vec = 0;

%% Iterate

ss = 1;

while(ss > 0) %Set to zero in code when all frames complete
    
    [ac_flag,ac_vec,phi0,L,R,se,snext,frame_energy] = stacf_fyp(wavfile,fs,ss,ac_level,Lm,Rm,Km,Klowm);
    
    PauseVec_n(ss:ss+L) = PauseVec_n(ss:ss+L) + ac_flag;
    Energy_Contour(ss:ss+L) = EnergyVec(ss:ss+L) + frame_energy;
   
    
    ss = snext;
    if(ss > length(wavfile)-L)
        ss = 0;
    else
%     subplot(2,1,1)
%     plot(wavfile(ss:ss+L))
%     
%     subplot(2,1,2)
%     plot(ac_vec);
%     grid on  
       
    end
    
 fprintf('Percentage complete %5.2f\n',100*ss/length(wavfile))   
    
end 

% save('D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_44_mono_var.mat','PauseVec_n');


Max_E = max(Energy_Contour);
EnergyVec = (Energy_Contour > (Max_E - e_diff_thresh));

%% Smoothing

PauseVec_n = GlitchDetector(PauseVec_n,fs,min_pause,min_speech);
EnergyVec = GlitchDetector(EnergyVec,fs,min_pause,min_speech);

%% Combining
SpeechVec = PauseVec_n & EnergyVec;

%% Tallying and Statistics
PauseMat = PauseCounter(SpeechVec,fs,MinPause);

NumPauses = size(PauseMat,1);
MeanPause = mean(PauseMat(:,3));
StdPause = std(PauseMat(:,3));

PauseSpacing = PauseMat(2:end,1)-PauseMat(1:end-1,2);
MeanSpace = mean(PauseSpacing);
StdSpace = std(PauseSpacing); 

fprintf('Number of Pauses = %6d\n',NumPauses);
fprintf('Mean Pause Duration = %6.3fs\n',MeanPause);
fprintf('Standard Deviation = %6.3fs\n\n',StdPause);

fprintf('Mean Space between pause = %6.3fs\n',MeanSpace);
fprintf('Standard Deviation = %6.3fs\n',StdSpace);


%% Plotting
% 
% 
% figure
% plotyy(1:n,wavfile,1:n,Energy_Contour)

% plot(Energy_Contour)
% line([1 n],[(Max_E-e_diff_thresh) (Max_E-e_diff_thresh)],'Color','r')


x_sec = (1:n)/fs;

figure
plot(x_sec,wavfile)
hold on
plot(x_sec,EnergyVec*0.5*max(wavfile),'r','Linewidth',2)
plot(x_sec,PauseVec_n*0.6*max(wavfile),'g','Linewidth',2)
plot(x_sec,SpeechVec*0.4*max(wavfile),'m','Linewidth',2)

title('Speech/Pause Detection')
xlabel('time (s)')
legend('Speech Waveform','Energy Thresholding','Autocorrelation Method','Combined Speech/Pause Value')

PauseVec_n = (PauseVec_n > 1)*0.5*max(wavfile); %%%%



% soundsc(wavfile,fs);

