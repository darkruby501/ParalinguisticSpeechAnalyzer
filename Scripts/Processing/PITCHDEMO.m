% PITCH DEMO

filename = 'C:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short1.wav'
[ SpeechHeader, SpeechData, FHeader, FData] = sfspitch( filename );
plot(FData)