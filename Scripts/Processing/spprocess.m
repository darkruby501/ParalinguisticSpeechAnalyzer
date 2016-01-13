function [Sp] = spprocess(filename,reSFS,reCalc,Sp)

SPGLOBALVARIABLES

% Extraction of Global Features for Speaker
%input: filename of audiofile for speaker
%output: speaker object

if(nargin<3)
    reSFS = true;
    reCalc = true;
    Sp = struct('name',[],'filename',[]);
end
    
SMTH = 200; %linear smoothing width (ms)
% min_pause = 200;

% for SMTH = 50:50:300



%% Create Speaker Records




Sp.filename = cell2mat(filename);


[PATHSTR,NAME,EXT] = fileparts(Sp.filename);
Sp.Name = NAME;



%% - Pitch statistics

if(reSFS)
[SpeechHeader,SpeechData,FHeader,FDataIntrp] = sfspitch(Sp.filename,SMTH,1);
[~,~,FHeader,FData] = sfspitch2(Sp.filename,50,0);
[~,~,FHeader,FDataS] = sfspitch(Sp.filename,SMTH,0);



Sp.SpeechHeader = SpeechHeader;
Sp.SpeechData = SpeechData;
Sp.FData = FData;
Sp.FDataS = FDataS;
Sp.FHeader = FHeader;
Sp.FDataIntrp = FDataIntrp;

% X = linspace(1,length(SpeechData),length(SpeechData));
% Xq = linspace(1,length(FData),length(SpeechData));
% % FData = interp1(FData,Xq,'spline')';
% FDataIntrp = interp1(FDataIntrp,Xq,'spline')';

Sp.fs = 1/Sp.SpeechHeader.frameduration;
Sp.fs0 = int32(1/Sp.FHeader.frameduration);
Sp.TotalDuration = length(SpeechData)/Sp.fs;



%Global Pitch Stats
FDataNZ = (FData(FData>0)); %Vector of non-zero frequencies. Which are from NZ
    
Sp.PitchStat.Fmean = mean(FDataNZ);
Sp.PitchStat.Fstd = std(FDataNZ);
Sp.PitchStat.Fmin = min(FDataNZ);
Sp.PitchStat.Fmax = max(FDataNZ);
Sp.PitchStat.Frange = range(FDataNZ);

end
% plot(FData)


%% - Pause Statistics
if(reCalc)
% [Sp.SpeechVec, Sp.SpeechMat, Sp.PauseMat] = pausedetector2(Sp.SpeechData,1/Sp.SpeechHeader.frameduration,...
%     Sp.FDataS,1/Sp.FHeader.frameduration,min_pause);

[Sp.SpeechVec, Sp.SpeechMat, Sp.PauseMat] = pausedetector2(Sp.SpeechData,1/Sp.SpeechHeader.frameduration,...
    Sp.FData,Sp.FDataS, 1/Sp.FHeader.frameduration,min_pause,energy_threshold);


[num, mean_dur, var_dur, total_dur] = matstat(Sp.SpeechMat,1);
Sp.UtterStat.num = num;
Sp.UtterStat.mean_dur = mean_dur;
Sp.UtterStat.var_dur = var_dur;
Sp.UtterStat.total_dur = total_dur;

[num, mean_dur, var_dur, total_dur] = matstat(Sp.PauseMat,0);
Sp.PauseStat.num = num;
Sp.PauseStat.mean_dur = mean_dur;
Sp.PauseStat.var_dur = var_dur;
Sp.PauseStat.total_dur = total_dur;
Sp.PauseStat.percent = Sp.PauseStat.total_dur / (Sp.UtterStat.total_dur + Sp.PauseStat.total_dur);

Sp.UtterStat.percent = Sp.UtterStat.total_dur / (Sp.UtterStat.total_dur + Sp.PauseStat.total_dur);
end


%% (- energy statistics)

%% Segment
Sp.Utter = uttercutter(Sp);

for j = 1:length(Sp.Utter)
    X = Sp.Utter(j).FIntrp;
    Sp.Utter(j).Fnrml = (X - Sp.PitchStat.Fmean)/Sp.PitchStat.Fstd;
end



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
display('Done!')

end