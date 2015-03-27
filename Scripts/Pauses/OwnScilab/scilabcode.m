[yorg,fs,bt]=wavread('wavfile/sakshaat.wav');
newfs=16000;
conversion_factor = newfs/fs;
y16 = intdec(yorg,conversion_factor);
y=y16;

y=y(floor(20001*(newfs/fs)):floor(55000*(newfs/fs)));

y=y./(1.01*abs(max(y)));

y2=y(floor(12501*(newfs/fs)):floor(13604*(newfs/fs)));

ycorr=corr(y2,400);

figure;
subplot(2,1,1);plot(y2);
xtitle('voiced speech segment','time(samples)','amplitude');
subplot(2,1,2);plot(ycorr);
xtitle('Autocorrelation of voiced speech','time(samples)','amplitude');







[y,fs,bt]=wavread('wavfile/sakshaat.wav');
y=y(20001:55000);
y=y./(1.01*abs(max(y)));
y3=y(19501:20604);
ycorr=corr(y3,400);
figure;
subplot(2,1,1);plot(y3);
xtitle('Unvoiced speech segment','time(samples)','amplitude');
subplot(2,1,2);plot(ycorr);
xtitle('Autocorrelation of unvoiced speech','time(samples)','amplitude');

