function [L,M,K,pdlow,period,plevel,peakac,ac1,ac2,ac3,ac4,xw1,xw2,xw3,xw4,xwe2,xwe3,xwe4]=...
    autocorrelation_analysis(xin,fs,wtype,ss,...
        Lmsec,Mmsec,pdlow,K,P,fid)
%
% compute four different types of autocorrelation function
%   type 1: short-time autocorrelation
%   type 2: short-time modified autocorrelation
%   type 3: short-time modified center clipped autocorrelation
%   type 4: short-time modified 3 level autocorrelation
%
% Inputs:
%   xin: speech file (from ss to end)
%   fs: sampling rate of speech file
%   wtype: analysis window type (1:Hamming, 2:Rectangular)
%   ss: starting sample for frame analysis
%   Lmsec: analysis frame length in msec
%   Mmsec: analysis frame shift in msec
%   pdlow: shortest allowable pitch period in msec
%   K: longest allowable pitch period in msec (and extension limit of AC)
%   P: percentage clipping level for speech waveform
%   fid: file id of write file
%
% Outputs:
%   L: frame length in samples
%   M: frame shift in samples
%   K: longest pitch period in samples
%   pdlow: shortest pitch period in samples
%   period=[peak1, peak2, peak3, peak4]: estimate of pitch period for each of 4 AC estimates
%   plevel=[plev1, plev2, plev3, plev4]: value of AC at 0 lag
%   peakac=[level1, level2, level3, level4]: amplitude of AC peak
%   ac={ac1 ac2 ac3 ac4}: autocorrelation using types 1-4 analysis
%   xw={xw1 xw2 xw3 xw4}: frames used for each of 4 analyses
%   xwe={xwe2 xwe3 xwe4}: extended regions of signal for AC analysis

% save entire speech file in x
    x=xin(1:length(xin));
    
% subtract out the mean of x
    xm=sum(x)/length(x);
    x=(x-xm);
    
% convert frame duration (from msec to samples) and frame shift (from msec
% to samples) by scaling by fs/1000
    L=Lmsec*fs/1000;
    M=Mmsec*fs/1000;
    
% convert maximum lag (from msec to samples) for autocorrelation computation 
% (corresponding to minimum pitch frequency) 
    K=floor(K*fs/1000);

% convert minimum lag (from msec to samples) for autocorrelation computation 
% (corresponding to maximum pitch frequency)
    pdlow=floor(pdlow*fs/1000);
    
% write out basic analysis parameters
    fprintf(fid,'wtype: %d, window length: %d, window shift: %d\n',wtype,L,M);
    fprintf(fid,'maximum lag: %d, clipping pct: %d, low period: %d \n',K,P,pdlow);     
    
% create frame analysis window of length L samples
    if (wtype == 1)
        window=hamming(L);
    elseif (wtype == 2)
        window=ones(1,L)';
    end
    
% create extended signal array
    xs=x(ss:ss+L+K-1);
    
% 4 types of autocorrelations will be computed
% type 1 -- standard short time autocorrelation from samples ss to ss+L-1
% type 2 -- modified short time autocorrelation from samples ss to ss+L+K-1
% type 3 -- modified short time autocorrelation using center clipping at P
% percent of peak value in frame
% type 4 -- modified short time autocorrelation using 3-level clipping
% (either at center clipping level or using entire waveform)
        
% type 1 short time autocorrelation
        xw1=xs(1:L).*window(1:L);
        ac1p=xcorr(xw1,K);
        ac1=ac1p(K+1:2*K+1)'/ac1p(K+1);
        plev1=ac1p(K+1);
        peaks=find(ac1(pdlow:K) == max(ac1(pdlow:K)));
        peak1=peaks(1)+pdlow-2;
        level1=ac1(peak1);
        
% check for pitch period doubling
        [peak1,level1]=pitch_doubling_check(peak1,pdlow,ac1,level1);
        
% type 2 short time autocorrelation
        xw2=xs(1:L);
        xwe2=xs(1:K+L-1);
        ac2p=xcorr(xwe2,xw2,K);
        ac2=ac2p(K+1:2*K+1);
        plev2=ac2(1);
        ac2=ac2/ac2(1);
        ac2m=max(ac2(pdlow:K));
        peaks=find(ac2(pdlow:K) == ac2m);
        peak2=peaks(1)+pdlow-2;
        level2=ac2(peak2);
        
% check for pitch period doubling
        [peak2,level2]=pitch_doubling_check(peak2,pdlow,ac2,level2);
        
% type 3 short time autocorrelation
        xsm=min(max(xs(1:floor(L/3))),max(xs(floor(2*L/3):L)));
        xw3=xs(1:L);
        xwe3=xs(1:K+L-1);
        xw3(find(abs(xw3) < xsm*P/100))=0;
        xwe3(find(abs(xwe3) < xsm*P/100))=0;
        ac3p=xcorr(xwe3,xw3,K);
        ac3=ac3p(K+1:2*K+1);
        plev3=ac3(1);
        ac3=ac3/ac3(1);
        peaks=find(ac3(pdlow:K) == max(ac3(pdlow:K)));
        peak3=peaks(1)+pdlow-2;
        level3=ac3(peak3);
        
% check for pitch period doubling
        [peak3,level3]=pitch_doubling_check(peak3,pdlow,ac3,level3);
        
% type 4 short time autocorrelation
        xw4=xs(1:L);
        xwe4=xs(1:K+L-1);
        xw4(find(abs(xw4) < xsm*P/100))=0;
        xwe4(find(abs(xwe4) < xsm*P/100))=0;
        xw4(find(xw4 > 0))=1;
        xw4(find(xw4 < 0)) =-1;
        xwe4(find(xwe4 > 0))=1;
        xwe4(find(xwe4 < 0)) =-1;
        ac4p=xcorr(xwe4,xw4,K);
        ac4=ac4p(K+1:2*K+1);
        plev4=ac4(1);
        ac4=ac4/ac4(1);
        peaks=find(ac4(pdlow:K) == max(ac4(pdlow:K)));
        peak4=peaks(1)+pdlow-2;
        level4=ac4(peak4);
        
% check for pitch period doubling
        [peak4,level4]=pitch_doubling_check(peak4,pdlow,ac4,level4);
        
% save results in arrays
        period=[peak1 peak2 peak3 peak4];
        peakac=[level1 level2 level3 level4];
        ploc=[ss];
        plevel=[plev1 plev2 plev3 plev4];
end