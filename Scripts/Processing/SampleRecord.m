function [ ] = SampleRecord(filename,duration)
%SampleRecord Summary of this function goes here
%  Ruben Bloom
%  2-6-2014 

% duration = 5;
samplerate = 16000;

r = audiorecorder(samplerate,16,1);

input('Press enter when ready to record')
record(r)
input('Press enter to end recording')
stop(r)
% play(r)

recording = getaudiodata(r,'int16');

audiowrite(filename,recording,samplerate); % Write file to file

end

