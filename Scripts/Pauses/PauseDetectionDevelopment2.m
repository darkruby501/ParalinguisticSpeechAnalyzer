% My Pause Detection Development Script

% close all;
clear all;

% Debug

filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_44_mono.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_sample_mono.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\ceremony_sample_short_Brienne_noise.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short1.wav';

[wavfile,fs,nbits] = wavread(filename);



%% Select Segment

% if(length(wavfile) > 10*fs)
%     wavfile = wavfile((1:10*fs)+20*fs);
% end

% if(length(wavfile) > 10*fs)
%     wavfile = wavfile((1:180*fs));
% end



%% Variables

plot_n = min(fs*60,length(wavfile));

ac_level = 0.4;
min_pause = 200;
min_speech = 200;
safety = 150;

gausswidth = 4410; %5000;
% gausswidth = round(safety*(fs/1000));

alpha = 2.5;



Lm = 30; %size of frame in ms
Rm = 10; %size of shift in ms

Km = 12.5; % Longest pitch period in ms (lowest frequency)
Klowm = 0.1;

PauseVec_n = zeros(length(wavfile),1);
Phi_vec = 0;

%% Iterate

if(exist([filename(1:end-4) '.mat'],'file'))
    load([filename(1:end-4) '.mat']);
%     if(length(PauseVec_n) > 10*fs)
%     PauseVec_n = PauseVec_n((1:180*fs));
%     end
else
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

%      fprintf('Percentage complete %5.2f\n',100*ss/length(wavfile))   

    end 

    PauseVec_n = (PauseVec_n > 1);

    save([filename(1:end-4) '.mat'],'PauseVec_n');

end

A = figure;
set(gcf, 'Position', [100 800 2200 500]); % Maximize figure.
% subplot(2,1,1)
n = (1:length(PauseVec_n))/fs;
plot(n(1:min(length(PauseVec_n),plot_n)),wavfile(1:min(length(PauseVec_n),plot_n)),n(1:min(length(PauseVec_n),plot_n)),PauseVec_n(1:min(length(PauseVec_n),plot_n))*0.6*max(wavfile),'r')
hold on

%%Glitch Filtering

% if(exist([filename(1:end-4) '_var_glitchfree.mat'],'file'))
%     load([filename(1:end-4) '_var_glitchfree.mat']);
% else
    PauseVec_n2 = GlitchDetector(PauseVec_n,fs,min_pause,min_speech,0);
    PauseVec_n = GlitchDetector(PauseVec_n,fs,min_pause,min_speech,safety);

    plot(n(1:min(length(PauseVec_n),plot_n)),PauseVec_n(1:min(length(PauseVec_n),plot_n))*1*max(wavfile),'g','Linewidth',2)
    hold on
    plot(n(1:min(length(PauseVec_n),plot_n)),PauseVec_n2(1:min(length(PauseVec_n),plot_n))*1*max(wavfile),'m','Linewidth',2)
    ylim([-1,1.2])
    % 
%     save([filename(1:end-4) '_var_glitchfree.mat'],'PauseVec_n');
% end

%% Smooth 
PauseVec_n = double(logical(PauseVec_n));
% PauseVec_n2 = PauseVec_n;

% Full Result
% TSTART = tic;
% gausswidth = 150000;
% gaussKernel = gausswin(gausswidth,4);
% gaussKernel = gaussKernel/sum(gaussKernel);
% 
% PauseVec_n = conv(PauseVec_n,gaussKernel,'same');
% toc(TSTART)


% Decimated/Interpolated
TSTART = tic;
D = 10;
PauseVec_d = decimate(PauseVec_n,D);
gaussKernel = gausswin(gausswidth,alpha);
gaussKernel = gaussKernel/sum(gaussKernel);

PauseVec_d = conv(PauseVec_d,gaussKernel,'same');
X = linspace(1,length(PauseVec_d),length(PauseVec_d));
Xq = linspace(1,length(PauseVec_d),length(PauseVec_n));
PauseVec_d = interp1(PauseVec_d,Xq)';

toc(TSTART)


% % Compare
% B = figure;
% set(gcf, 'Position', [100 180 2200 500]); % Maximize figure.
% plot(n(1:min(length(PauseVec_n),plot_n)),PauseVec_n(1:min(length(PauseVec_n),plot_n)),n(1:min(length(PauseVec_n),plot_n)),PauseVec_d(1:min(length(PauseVec_n),plot_n))+0.1,'r','Linewidth',2)



%% Clean

PauseVec_d = PauseVec_d + 0.2;
PauseVec_d(PauseVec_d > 1) = 1;
plot(n,PauseVec_n,n,PauseVec_d,'k','Linewidth',1)

wavfile_clean = wavfile.*(PauseVec_d);



% PLOT CONVOLVED PAUSE VECTOR OVER WAVEFORM
figure(A);
% plot(n,wavfile)
% hold on
plot(n(1:min(length(PauseVec_n),plot_n)),PauseVec_d(1:min(length(PauseVec_n),plot_n)),'k','Linewidth',2)
% plot(n,PauseVec_d,'m','Linewidth',2)


% PLOT CLEANED WAVEFORM VS ORIGINAL
C = figure;
set(gcf, 'Position', [100 800 2200 500]); % Maximize figure.
subplot(2,1,1)
plot(n,wavfile);
subplot(2,1,2)
plot(n,wavfile_clean);




% plot_colour = 'm';
% 
% subplot(2,1,1)
% plot(1:half_n,PauseVec_n(1:half_n)*0.6*max(wavfile)+0.1,plot_colour,'Linewidth',2)
% subplot(2,1,2)
% plot(half_n:n,PauseVec_n(half_n:n)*0.6*max(wavfile)+0.1,plot_colour,'Linewidth',2)
% 
% wavfile_clean = wavfile.*(PauseVec_n+0.1);
% 
% % wavfile_clean(PauseVec_n==0) = wavfile_clean(PauseVec_n==0); %%Scaling - should maybe use log??
% 
% figure
% subplot(2,1,1)
% plot(wavfile);
% subplot(2,1,2)
% plot(wavfile_clean);
% 
% 
% soundsc(wavfile_clean,fs);
% wavwrite(wavfile_clean,fs,nbits,[filename(1:end-4) '_matlab_4a.wav']);
% 
% soundsc(wavfile,fs);

