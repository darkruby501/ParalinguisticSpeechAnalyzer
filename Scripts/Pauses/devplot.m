figure
% subplot(2,1,1)
n = (1:length(wavfile))/fs;
plot(n,wavfile,n,PauseVec_n*0.6*max(wavfile),'r')
hold on