function [] = spprintertr(Sp)
%SPPRINTER 
clc
% May update to use table later

NAMES = ['NATE TARA RIVA RUBY OLI MIRANDA'];
names = {'NATE', 'TARA', 'RIVA', 'RUBY', 'OLI', 'MIRANDA'};
N = length(Sp);
a = 2;

%GLOBAL

% G = zeros(
for i = 1:N
    G(1,i) = Sp(i).TotalDuration;
    G(2,i) = Sp(i).fs; 
end

Rlabel = ['TotalDuration Sampling Rate'];
G = round(G);
printmat_v3(G','GLOBAL',NAMES,Rlabel,0)



%PITCH
P = zeros(5,N);

for i = 1:N
    P(1,i) = Sp(i).PitchStat.Fmean;
    P(2,i) = Sp(i).PitchStat.Fstd;
    P(3,i) = Sp(i).PitchStat.Fmin;
    P(4,i) = Sp(i).PitchStat.Fmax;
    P(5,i) = Sp(i).PitchStat.Frange;
end
Rlabel = ['Mean Std Min Max Range'];
P = int16(P);
printmat_v3(P','PITCH',NAMES,Rlabel,0)



%UTTERANCES
U = zeros(5,N);

for i = 1:N
    U(1,i) = Sp(i).UtterStat.num;
    U(2,i) = Sp(i).UtterStat.mean_dur;
    U(3,i) = Sp(i).UtterStat.var_dur;
    U(4,i) = Sp(i).UtterStat.total_dur;
    U(5,i) = Sp(i).UtterStat.percent*100;
end

Rlabel = ['N MeanDuration Var_Dur Total_Dur Percentage'];
% U = round(U);
printmat_v3(U','UTTERANCES',NAMES,Rlabel,2)



%PAUSES
Ps = zeros(5,N);

for i = 1:N
    Ps(1,i) = Sp(i).PauseStat.num;
    Ps(2,i) = Sp(i).PauseStat.mean_dur;
    Ps(3,i) = Sp(i).PauseStat.var_dur;
    Ps(4,i) = Sp(i).PauseStat.total_dur;
    Ps(5,i) = Sp(i).PauseStat.percent*100;
end
Rlabel = ['N MeanDuration Var_Dur Total_Dur Percentage'];
% Ps = round(Ps);
printmat_v3(Ps','PAUSES',NAMES,Rlabel,2)









% array2table(P,'VariableNames',names,'RowNames',Rlabel)    
    
    

end

