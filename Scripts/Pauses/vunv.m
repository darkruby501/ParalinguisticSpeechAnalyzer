% This function determines whether x is voiced or unvoiced. It also
% determines the pitch period, i.e., 'pperiod', if x is voiced. 
% vu = 1 if voiced and vu = 0 if unvoiced. 

function [vu,pperiod] = vunv(x,B,A)

K = 0.6;                           % clipping factor
x = x .* hamming(length(x));       % windowing data
fltx = filter(B,A,x);              % filtering data


fthrd = 1:round(length(fltx)/3);   % first third indices
fmax1 = max(abs(fltx(fthrd)));

sthrd = (length(fltx)-length(fthrd)):length(fltx);  % last third indices
fmax2 = max(abs(fltx(sthrd)));

C = K*min([fmax1 fmax2]);          % clipping value 

fltx = (fltx - C*sign(fltx)).*(fltx > C | fltx < -C);   % clipping


cor = xcorr(fltx);
[amax,ind] = max(cor);              % maximum correlation value at center

rcor = cor(ind:length(cor));        % right half of original correlation
stem(rcor(1:100)); pause;

start = find(rcor < .3*amax);       
start = max([20 start(1)]);


[cmax,ind] = max(rcor(start:length(rcor)));

if (cmax > 0.3*amax)
   pperiod = ind + start - 1;
   vu = 1;
else
   pperiod = 0;
   vu = 0;
end;
    


