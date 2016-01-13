function [] = spprinter(Sp)
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
printmat(G,'GLOBAL',Rlabel,NAMES)



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
P = round(P);
printmat(P,'PITCH',Rlabel,NAMES)



%UTTERANCES
U = zeros(5,N);

for i = 1:N
    U(1,i) = Sp(i).UtterStat.num;
    U(2,i) = Sp(i).UtterStat.mean_dur;
    U(3,i) = Sp(i).UtterStat.var_dur;
    U(4,i) = Sp(i).UtterStat.total_dur;
    U(5,i) = Sp(i).UtterStat.percent;
end

Rlabel = ['N MeanDuration VarDuration TotalDuration Percentage'];
U = round(U);
printmat(U,'UTTERANCES',Rlabel,NAMES)



%PAUSES
Ps = zeros(5,N);

for i = 1:N
    Ps(1,i) = Sp(i).PauseStat.num;
    Ps(2,i) = Sp(i).PauseStat.mean_dur;
    Ps(3,i) = Sp(i).PauseStat.var_dur;
    Ps(4,i) = Sp(i).PauseStat.total_dur;
    Ps(5,i) = Sp(i).PauseStat.percent;
end
Rlabel = ['N MeanDuration VarDuration TotalDuration Percentage'];
Ps = round(Ps);
printmat(Ps,'PAUSES',Rlabel,NAMES)









% array2table(P,'VariableNames',names,'RowNames',Rlabel)    
    
    

end

