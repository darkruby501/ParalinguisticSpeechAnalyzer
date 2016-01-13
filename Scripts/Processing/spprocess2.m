function [Sp] = spprocess(filename,reSFS,SFSreuse,reCalc,Sp)

SPGLOBALVARIABLES

% Extraction of Global Features for Speaker
%input: filename of audiofile for speaker
%output: speaker object

if(nargin<5)
    Sp = struct('Name',[],'filename',[]);
end

if(nargin<4)
    reSFS = true;
    reCalc = true;
    SFSreuse = false;
end

SMTH = 200; %linear smoothing width (ms)
% min_pause = 200;

% for SMTH = 50:50:300



%% Create Speaker Records




Sp.filename = cell2mat(filename);


[PATHSTR,NAME,EXT] = fileparts(Sp.filename);
Sp.Name = NAME;



%% - Pitch Extraction

if(reSFS)

[SpeechHeader,SpeechData,FHeader,FData] = sfspitch2(Sp.filename,0,0,SFSreuse);
[~,~,~,FDataIntrp] = sfspitch2(Sp.filename,0,1,SFSreuse);

% [~,~,FHeader,] = sfspitch(Sp.filename,SMTH,1);
% [~,~,FHeader,FDataS] = sfspitch(Sp.filename,SMTH,0);



Sp.SpeechHeader = SpeechHeader;
Sp.SpeechData = SpeechData;
Sp.FData = FData;
% Sp.FDataS = FDataS;
Sp.FHeader = FHeader;
% Sp.FDataIntrp = FDataIntrp;
Sp.FDataIntrp = smooth(FDataIntrp,10);

Sp.fs = 1/Sp.SpeechHeader.frameduration;
Sp.fs0 = double(int32(1/Sp.FHeader.frameduration));
Sp.TotalDuration = length(SpeechData)/Sp.fs;



end


%% - Pause Statistics
if(reCalc)

% 1) VADMOD

pitchfile = [Sp.Name '_pitch'];

VADSEG = vad_mod(Sp.SpeechData,Sp.fs,pitchfile); %Apply voice activity detection
VADSEG = VADdur(VADSEG,min_pause,min_speech); %remove pauses below minimum duration

Sp.SpeechVec = seg2win(VADSEG,Sp.fs);
Sp.SpeechVecF = seg2win(VADSEG,Sp.fs0);
Sp.SpeechMat = seg2mat(VADSEG,Sp.fs);

VADSEGn = [VADSEG(1:end-1,2) VADSEG(2:end,1)];

Sp.PauseMat = seg2mat(VADSEGn,Sp.fs);

% 
%     
% [Sp.SpeechVec, Sp.SpeechMat, Sp.PauseMat] = pausedetector2(Sp.SpeechData,1/Sp.SpeechHeader.frameduration,...
%     Sp.FData,Sp.FDataS, 1/Sp.FHeader.frameduration,min_pause,energy_threshold);


[num, mean_dur, var_dur, total_dur] = matstat(Sp.SpeechMat,1);
Sp.UtterStat.num = num;
Sp.UtterStat.mean_dur = mean_dur;
Sp.UtterStat.var_dur = var_dur;
Sp.UtterStat.total_dur = total_dur;

[num, mean_dur, var_dur, total_dur] = matstat(Sp.PauseMat,1);
Sp.PauseStat.num = num;
Sp.PauseStat.mean_dur = mean_dur;
Sp.PauseStat.var_dur = var_dur;
Sp.PauseStat.total_dur = total_dur;
Sp.PauseStat.percent = Sp.PauseStat.total_dur / (Sp.UtterStat.total_dur + Sp.PauseStat.total_dur);

Sp.UtterStat.percent = Sp.UtterStat.total_dur / (Sp.UtterStat.total_dur + Sp.PauseStat.total_dur);
end


%% Pitch Statistcs


%Global Pitch Stats
N = min(length(Sp.SpeechVecF),length(Sp.FDataIntrp));
fdata = Sp.FDataIntrp(1:N).*Sp.SpeechVecF(1:N)';

% N = min(length(Sp.SpeechVecF),length(Sp.FData));
% fdata = Sp.FData(1:N).*Sp.SpeechVecF(1:N)';

FDataNZ = (fdata(fdata>0)); %Vector of non-zero frequencies. Which are from NZ
% mean(FDataNZ)
% std(FDataNZ)

Sp.PitchStat.Fmean = mean(FDataNZ);
Sp.PitchStat.Fstd = std(FDataNZ);
Sp.PitchStat.Fmin = min(FDataNZ);
Sp.PitchStat.Fmax = max(FDataNZ);
Sp.PitchStat.Frange = range(FDataNZ);


%% Segment

Sp.Utter = uttercutter(Sp,min_utter);

for i = 1:length(Sp.Utter)
    [HRT,ratio,diff] = hrtdetector(Sp.Utter(i).FData,Sp.fs0,HRT_syll,HRT_phrase,1.2);
    Sp.Utter(i).HRTratio = ratio;
    Sp.Utter(i).HRT = HRT;
    Sp.Utter(i).HRTdiff = diff;
end

Sp.HRTmat = [vertcat(Sp.Utter(:).HRTratio) vertcat(Sp.Utter(:).HRT) vertcat(Sp.Utter(:).HRTdiff)];
Sp.HRTstat = hrtstat(Sp.HRTmat);

% for j = 1:length(Sp.Utter)
%     X = Sp.Utter(j).FIntrp;
%     Sp.Utter(j).Fnrml = (X - Sp.PitchStat.Fmean)/Sp.PitchStat.Fstd;
% end



%% PLOT SCRAPS

display('Done!')

end