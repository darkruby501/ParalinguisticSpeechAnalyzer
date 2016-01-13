filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\M05_short1.wav';
% filename = 'D:\Users\RMB\Drive\Monash\ECE4095\Code\FYP\Scripts\Speech Samples\bee.wav';

[x, fs] = wavread(filename);
[F0, T, C] = spPitchTrackCepstrum(x, fs, 30, 20, 'hamming', 'plot');
