% My Pause Detection Development Script

close all;
clear all;

% Debug
subplot(2,1,1)

filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_44_mono.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_sample_mono.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_sample_short_Brienne_noise.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short1.wav';

[wavfile,fs,nbits] = wavread(filename);

% wavfile = wavfile(837000:1560000);
% 
% if(length(wavfile) > 10*fs)
%     wavfile = wavfile(1:10*fs);
% end

%% Variables

ac_level = 0.4;
min_pause = 200;
min_speech = 200;
safety = 0;

Lm = 30; %size of frame in ms
Rm = 10; %size of shift in ms

Km = 12.5; % Longest pitch period in ms (lowest frequency)
Klowm = 0.1;

PauseVec_n = zeros(length(wavfile),1);
Phi_vec = 0;

%% Iterate

ss = 1;

while(ss > 0) %Set to zero in code when all frames complete
    
    [ac_flag,ac_vec,phi0,L,R,se,snext] = stacf_fyp(wavfile,fs,ss,ac_level,Lm,Rm,Km,Klowm);
    
    PauseVec_n(ss:ss+L) = PauseVec_n(ss:ss+L) + ac_flag;
    
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

save('D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_44_mono_var.mat','PauseVec_n');

figure
subplot(2,1,1)
n = length(wavfile);
half_n = round(n/2);

PauseVec_n = (PauseVec_n > 1)*0.5*max(wavfile); %%%%


% SMOOTHING

% % This doesn't work
% gausswidth = 10000;
% gaussKernel = gausswin(gausswidth);
% gaussKernel = gaussKernel/sum(gaussKernel);
% PauseVec_n_smooth = conv(PauseVec_n,gaussKernel,'same');

% Try a "Glitch"Detection Algorith

PauseVec_n_smooth = GlitchDetector(PauseVec_n,fs,min_pause,min_speech,safety);
PauseVec_n_smooth = (PauseVec_n_smooth > 0)*0.6*max(wavfile); %%%%


plot(1:half_n,wavfile(1:half_n))
hold on
plot(1:half_n,PauseVec_n(1:half_n),'r','Linewidth',2)
plot(1:half_n,PauseVec_n_smooth(1:half_n),'g','Linewidth',2)


subplot(2,1,2)
plot(half_n:n,wavfile(half_n:n))
hold on
% plot(half_n:n,PauseVec_n(half_n:n),'r','Linewidth',2)
plot(half_n:n,PauseVec_n_smooth(half_n:n),'g','Linewidth',2)


%% Process Test

PauseVec_n = double(logical(PauseVec_n_smooth));
gausswidth = 150000;
gaussKernel = gausswin(gausswidth,4);
gaussKernel = gaussKernel/sum(gaussKernel);
PauseVec_n = conv(gaussKernel,PauseVec_n,'same');

plot_colour = 'm';

subplot(2,1,1)
plot(1:half_n,PauseVec_n(1:half_n)*0.6*max(wavfile)+0.1,plot_colour,'Linewidth',2)
subplot(2,1,2)
plot(half_n:n,PauseVec_n(half_n:n)*0.6*max(wavfile)+0.1,plot_colour,'Linewidth',2)

wavfile_clean = wavfile.*(PauseVec_n+0.1);

% wavfile_clean(PauseVec_n==0) = wavfile_clean(PauseVec_n==0); %%Scaling - should maybe use log??

figure
subplot(2,1,1)
plot(wavfile);
subplot(2,1,2)
plot(wavfile_clean);


soundsc(wavfile_clean,fs);
wavwrite(wavfile_clean,fs,nbits,[filename(1:end-4) '_matlab.wav']);

% soundsc(aa,fs);

