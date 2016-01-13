%SPEAKER PROCESSING AND PLAYBOX

clear all
Nate2mfile = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Nate_2m.wav';

FILENAME = {... 
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Nate_5m.wav',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Tara_5m1.wav',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Riva_5m.wav',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Ruby_5m.wav',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Oli_5m.wav',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\Miranda_5m.wav'};



M05_shortfile = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short.wav';
CeremonySamplefile = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony\ceremony_sample_mono.wav';

for i = 1:length(FILENAME)
    Sp(i) = spprocess(FILENAME(i));
end

save('D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\Ceremony Speakers\SpFile.mat','Sp')
display('All done!')


% 
% spprinter(Sp)
% 
% spprintertr(Sp)
% 
% i = 2;
% A = spprocess(FILENAME(i));
% 
% Sp(1) = spprocess(FILENAME(1),0,0,Sp(1));
% 
% for i = 1:length(FILENAME)
%     Sp(i) = spprocess(FILENAME(1),0,0,Sp(i));
% end