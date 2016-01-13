function  X = sqrinterp(x,fs_old,fs_new)
%SQRINTERP Upsamples or downsamples a square wave

x = double(x); %just in case

R = int32(fs_old/fs_new);

if(fs_old > fs_new) %Downsample
    X = decimate(x,160);
%     X = decimate(x,10);
else
    Xq = linspace(1,length(x),length(x)*fs_new/fs_old);
    X = interp1(x,Xq)';      
end

