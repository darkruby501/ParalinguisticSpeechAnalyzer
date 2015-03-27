% Pause Detection Test Bench

[x,VS] = CodeSpeech1('MK61wbabble.wav');

plot(1:length(x),x,1:length(x),VS*0.5*max(x),'linewidth',0.3)