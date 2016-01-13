% PSY2031 GLOBAL

DIR = 'C:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\HRT\2031 Presentations\';
DIR1 = 'C:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\HRT\TED\';
DIR2 = 'C:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\';


D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers



%% PSY2031 Speakers
FILENAMES = filelist(DIR);

for i = 1:length(FILENAMES)
    Sp(i) = spprocess3(FILENAMES(i));
end

% for i = 1:length(FILENAMES)
%     Sp(i) = spprocess3(FILENAMES(i),0,1,0,Sp(i));
% end


for i = 1:length(Sp)
    SpPSY2031Profile(i) = Sp2SpProfile(Sp(i));
    SpPSY2031Profile(i).Group = 'PSY2031';
end

SpPSY2031ProfileDS = struct2dataset(SpPSY2031Profile');


%% TED Speakers

FILENAMES = filelist(DIR1);

for i = 1:length(FILENAMES)
    SpTED(i) = spprocess3(FILENAMES(i));
end

% for i = 1:length(FILENAMES)
%     SpTED(i) = spprocess3(FILENAMES(i),0,1,0,SpTED(i));
% end

for i = 1:length(SpTED)
    SpTEDProfile(i) = Sp2SpProfile(SpTED(i));
    SpTEDProfile(i).Group = 'TED';
end

SpTEDProfileDS = struct2dataset(SpTEDProfile');

%% WEDDING Speakers

FILENAMES = filelist(DIR2);

for i = 1:length(FILENAMES)
    SpWED(i) = spprocess3(FILENAMES(i));
end

% for i = 1:length(FILENAMES)
%     SpTED(i) = spprocess3(FILENAMES(i),0,1,0,SpTED(i));
% end

for i = 1:length(SpWED)
    SpWEDProfile(i) = Sp2SpProfile(SpWED(i));
    SpWEDProfile(i).Group = 'WEDDING';
end

SpWEDProfileDS = struct2dataset(SpWEDProfile');


%% Export

SpALLDS = cat(1,SpPSY2031ProfileDS,SpTEDProfileDS,SpWEDProfileDS);

Sp2DS = cat(1,SpPSY2031ProfileDS,SpTEDProfileDS);

export(SpALLDS,'XLSFile','D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\SpDataset1.xlsx')



