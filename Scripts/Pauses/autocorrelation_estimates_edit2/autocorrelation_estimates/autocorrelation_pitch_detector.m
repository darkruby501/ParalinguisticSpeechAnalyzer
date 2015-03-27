function [L,M,K,pdlow,period,plevel,peakac,ploc]=...
  autocorrelation_pitch_detector(xin,fs,wtype,ss,Lmsec,Mmsec,pdlow,K,P,fid,fname)

% Autocorrelation pitch detector using 4 variations of AC function
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
%   fname: speech filename
%
% Outputs:
%   L: frame length in samples
%   M: frame shift in samples
%   K: longest pitch period in samples
%   pdlow: shortest pitch period in samples
%   period=[peak1, peak2, peak3, peak4]: estimate of pitch period for each of 4 AC estimates
%   plevel=[plev1, plev2, plev3, plev4]: value of AC at 0 lag
%   peakac=[level1, level2, level3, level4]: amplitude of AC peak
%   ploc: array of frame starting samples

% save desired portion of speech file from starting sample ss to ending
% sample es
    x=xin(1:length(xin));
    ssi=ss;
    
% subtract out the mean of x
    xm=sum(x)/length(x);
    x=(x-xm)/32767;
    
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
        wind=hamming(L);
    elseif (wtype == 2)
        wind=ones(1,L)';
    end
     
% compute log energy contour and determine input log energy threshold 
% from peak log energy - ethresh
    eln=[];
    sse=1;
    ethresh=30;
    while (sse+L-1 < length(x))
        xs=x(sse:sse+L-1);
        eln=[eln 10*log10(sum(xs(1:L).^2.*wind(1:L)))];
        sse=sse+M;
    end
    elnm=max(eln);
    elt=elnm-ethresh;
    
% accumulate pitch values and peak autocorrelation values in arrays
    period=[];
    peakac=[];
    ploc=[];
    plevel=[];
    
    while (ss > 0)
        xs=x(ss:ss+L+K-1);
        
% check if log energy of frame > threshold; if not set frame to non-voiced
% with period 0, peak 0
        frame=floor(ss/M)+1;
        if (eln(frame) > elt)
            
% 4 types of autocorrelations will be computed
% type 1 -- standard short time autocorrelation from samples ss to ss+L-1
% type 2 -- modified short time autocorrelation from samples ss to ss+L+K-1
% type 3 -- modified short time autocorrelation using center clipping at P
% percent of peak value in frame
% type 4 -- modified short time autocorrelation using 3-level clipping
% (either at center clipping level or using entire waveform)
        
% type 1 short time autocorrelation
        xw1=xs(1:L).*wind(1:L);
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
        period=[period; peak1 peak2 peak3 peak4];
        peakac=[peakac; level1 level2 level3 level4];
        ploc=[ploc ss];
        plevel=[plevel; plev1 plev2 plev3 plev4];
        
% print out options
        s1=sprintf('%s, ss: %d, ',fname,ss);
        s2=sprintf(' L: %d,M: %d, ',L,M);
        s3=sprintf(' maxlag: %d, CL: %d',K,P);
        stitle=strcat(s1,s2,s3);
        
% save results in arrays
        else
            period=[period; 0 0 0 0];
            peakac=[peakac; 0 0 0 0];
            ploc=[ploc ss];
            plevel=[plevel; 0 0 0 0];
        end

        ss=ss+M;
        if (ss > length(x)-L-K)
            ss=0;
        end
    end
        
% extract pitch period contours, confidence scores and log energy for 4 detectors
    l1=length(period);
    pp1=period(1:l1,1)';
    pp2=period(1:l1,2)';
    pp3=period(1:l1,3)';
    pp4=period(1:l1,4)';
    cp1=peakac(1:l1,1)';
    cp2=peakac(1:l1,2)';
    cp3=peakac(1:l1,3');
    cp4=peakac(1:l1,4)';

% plot the contours
    h2=figure(9); orient landscape;
    % set(h2,'Position',[280 278 690 460]);
    
% align speech waveform (samples) with pitch period frames
    ss1=L/2+1-M;
    es1=L/2+1+l1*M;
    
% plot speech waveform in top panel
    subplot(411),plot((ss1:es1)/fs,xin(ss1:es1),'k');
    axis([(L/2+1-M)/fs, (L/2+1+l1*M)/fs, min(xin), max(xin)]);
    xpp=['Time in Seconds; fs=',num2str(fs),' samples/second'];
    xlabel(xpp),ylabel('Amplitude');grid on;
    
    s1=sprintf('file: %s, window type: %d,',fname,wtype);
    s2=sprintf(' window length: %d, window shift: %d, peak lag: %d,',L,M,K);
    s3=sprintf(' clipping level: %d',P);
    stitle=strcat(s1,s2,s3);
    title(stitle);
    
% plot 4 pitch period contours in second panel
    subplot(412),plot(1:l1,pp1,'b','LineWidth',2),hold on;
    plot(1:l1,pp2,'r:','LineWidth',2);
    plot(1:l1,pp3,'g--','LineWidth',2);
    plot(1:l1,pp4,'m-.','LineWidth',2);
    p1m=max(pp1);p2m=max(pp2);p3m=max(pp3);p4m=max(pp4);
    p=[p1m p2m p3m p4m];
    pmax=max(p)+10;
    axis([0 l1 0 pmax]);grid on;
    xpp=['Frame Number; fs=',num2str(fs),' samples/second'];
    xlabel(xpp),ylabel('Pitch Period (samples)');
    legend('ac','modified ac','center clipped','3-level');
    
% plot 4 pitch period confidence scores in third panel

    subplot(413),plot(1:l1,cp1,'b','LineWidth',2),hold on;
    plot(1:l1,cp2,'r:','LineWidth',2);
    plot(1:l1,cp3,'g--','LineWidth',2);
    plot(1:l1,cp4,'m-.','LineWidth',2);
    c1m=max(cp1);c2m=max(cp2);c3m=max(cp3);c4m=max(cp4);
    c=[c1m c2m c3m c4m];
    cmax=max(c)+0.5;
    axis([0 l1 0 cmax]);grid on;
    xlabel(xpp),ylabel('Confidence Score');
    legend('ac','modified ac','center clipped','3-level');
    
% plot log magnitude energy contour
    subplot(414),plot(1:l1,eln(1:l1),'b','LineWidth',2);
    axis([0 l1 min(eln) max(eln)+5]);grid on;
    xlabel(xpp);ylabel('Log Energy (dB)');
          
    % fclose(fid);
    
% save final pitch period contour in mat file
% determine filename for writing autocorrelation outputs
    % fsave=input('filename for saving median pitch period file:','s');
    % pmedvar='pmed';
    % save (fsave,pmedvar);
end
