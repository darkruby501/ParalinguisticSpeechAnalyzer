function [SpeechVec, SpeechMat, PauseMat] = pausedetector(wavfile,fs,fdata,fs0,min_pause)
%PAUSEDETECTORUNTITLED Identifies speech/pauses in a waveform

% Output:
%  PauseVec pause/speech vec
%  PauseMat Matrix of pauses and their durations

n = length(wavfile);

%% Variables

ac_level = 0.4;
% min_pause = 200; %ms
min_speech = 200; %ms
safety = 0;

MinPause = 200; %for final counting
MinSpeech = 200; %for final counting


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
    
%  fprintf('Percentage complete %5.2f\n',100*ss/length(wavfile))   


end 

Max_E = max(Energy_Contour);
EnergyVec = (Energy_Contour > (Max_E - e_diff_thresh));
PauseVec_n = PauseVec_n > 1;

%%%%%%%%%%%%%%%%%%%%%%%%%% PLOTTING
nsub = 7;
L = 20;
N = fs*L;
n = (1:N)/fs;
N2 = (fs0)*L;
n2 = (1:N2)/fs0;


% Waveform
subplot(nsub,1,1)
plot(n,wavfile(1:N))
% Fdata
subplot(nsub,1,2)
plot(n2,fdata(1:N2))

% PauseVec
subplot(nsub,1,3)
plot(n,PauseVec_n(1:N),'r','linewidth',1.5)
ylim([0,1.5])

% EnergyVec
subplot(nsub,1,4)
plot(n,EnergyVec(1:N),'r','linewidth',1.5)
ylim([0,1.5])

%%Post Smoothing 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%






%% Smoothing

PauseVec_n = GlitchDetector(PauseVec_n,fs,min_pause,min_speech,0);
EnergyVec = GlitchDetector(EnergyVec,fs,min_pause,min_speech,0);


% PauseVec
subplot(nsub,1,5)
plot(n,PauseVec_n(1:N),'r','linewidth',1.5)
ylim([0,1.5])

% EnergyVec
subplot(nsub,1,6)
plot(n,EnergyVec(1:N),'r','linewidth',1.5)
ylim([0,1.5])



%% Combining
SpeechVec = PauseVec_n & EnergyVec;


% SpeechVec
subplot(nsub,1,7)
plot(n,SpeechVec(1:N),'r','linewidth',1.5)
ylim([0,1.5])

% SpeechVec
subplot(nsub,1,1)
hold on
plot(n,SpeechVec(1:N)*0.7,'r','linewidth',1.5)




%% Tallying and Statistics
PauseMat = PauseCounter(SpeechVec,fs,MinPause);
SpeechMat = UtterCounter(SpeechVec,fs,MinSpeech);




display('PAUSEDETECTOR-AC')



end

