%SPEAKER PROCESSING AND PLAYBOX



FILENAME = {... 
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\2031 Presentations\Speaker1_hrt.wav',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\HRT\Uptalk_(High_Rising_Terminal).mp3',...
'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\HRT\Uptalk_(High_Rising_Terminal)-2.mp3'};


for i = 1:length(FILENAME)
    Sp(i) = spprocess(FILENAME(i));
end



% Sp(i) = spprocess(FILENAME(1),0,1,Sp(i));