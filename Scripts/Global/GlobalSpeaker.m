% Extraction of Global Features for Speaker

clear all
fs = 16000;
SMTH = 50; %linear smoothing width (ms)

% for SMTH = 50:50:300

%% Create Speaker Records


Sp = struct('Name',[],'filename',[]);



Sp.filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Nate_2m.wav';
% Sp.filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short.wav';
% Sp.filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony\ceremony_sample_mono.wav';

i = 1;
[PATHSTR,NAME,EXT] = fileparts(Sp.filename);
Sp.name = NAME;


%% - Pitch statistics
[SpeechHeader,SpeechData,FHeader,FDataIntrp] = sfspitch(Sp.filename,SMTH,1);
[~,~,FHeader,FData] = sfspitch(Sp.filename,SMTH,0);

Sp.SpeechHeader = SpeechHeader;
Sp.SpeechData = SpeechData;
Sp.FData = FData;
Sp.FHeader = FHeader;
Sp.FDataIntrp = FDataIntrp;

% X = linspace(1,length(SpeechData),length(SpeechData));
% Xq = linspace(1,length(FData),length(SpeechData));
% % FData = interp1(FData,Xq,'spline')';
% FDataIntrp = interp1(FDataIntrp,Xq,'spline')';

Sp.fs = 1/Sp.SpeechHeader.frameduration;
Sp.fs0 = 1/Sp.FHeader.frameduration;
Sp.length_sec = length(SpeechData)/Sp.fs;

% plot(FData)


%% - Pause Statistics
[Sp.SpeechVec, Sp.SpeechMat, Sp.PauseMat] = pausedetectorsfs(Sp.SpeechData,1/Sp.SpeechHeader.frameduration,...
    Sp.FData,1/Sp.FHeader.frameduration);

[num, mean_dur, var_dur, total_dur] = matstat(Sp.SpeechMat,1);
Sp.SpeechStat.num = num;
Sp.SpeechStat.mean_dur = mean_dur;
Sp.SpeechStat.var_dur = var_dur;
Sp.SpeechStat.total_dur = total_dur;

[num, mean_dur, var_dur, total_dur] = matstat(Sp.PauseMat,0);
Sp.PauseStat.num = num;
Sp.PauseStat.mean_dur = mean_dur;
Sp.PauseStat.var_dur = var_dur;
Sp.PauseStat.total_dur = total_dur;

Sp.SpeechPercent = Sp.SpeechStat.total_dur / Sp.length_sec;


%% (- energy statistics)


%% Segment
Sp.Utter = uttercutter(Sp)

%% PLOT SCRAPS

% figure
% subplot(2,1,1)
% N = 20*16000;
% n = (1:N)/16000;
% 
% plot(n, SpeechData(1:N));
% subplot(2,1,2)
% plot(FData,'Linewidth',2);
% title(['Smoothing = ' num2str(SMTH)]);
% 
% 
% 
% hold on
% plot(n,Sp.SpeechVec(1:N)*0.8*max(FData1(1:N)),'m','Linewidth',2)
% 
% subplot(2,1,1)
% hold on
% plot(n,Sp.SpeechVec(1:N)*0.8,'m','Linewidth',2)
% 
% % end
% 
% soundsc(SpeechData(1:N),fs);