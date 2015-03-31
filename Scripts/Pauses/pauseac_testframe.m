% PauseDetection - Test Frame
function [] = pauseac_testframe(ss,wavfile,fs)
 
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short1.wav';
% [wavfile,fs] = wavread(filename);

ac_level = 0.35;

Lm = 30; %size of frame in ms
Rm = 15; %size of shift in ms

Km = 12.5; % Longest pitch period in ms (lowest frequency)
Klowm = 0.1;


[ac_flag,ac_vec,phi0,L,R,se,snext] = stacf_fyp(wavfile,fs,ss,ac_level,Lm,Rm,Km,Klowm);

ac_flag

subplot(2,1,1)
plot(wavfile(ss:ss+L))
subplot(2,1,2)
plot(ac_vec);


end