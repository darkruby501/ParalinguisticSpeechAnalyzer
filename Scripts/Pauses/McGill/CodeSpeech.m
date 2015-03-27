function CodeSpeechwPlot
% Sample file to code the active speech frames

x = wavread('FI49wcar.wav');
FID = fopen('CodedData.cod', 'w');

CActive = 1;
CSilence = 0;
CSID = 2;

Ns = length(x);
NsFrame = 80;       % Frame size (10ms)
NsLA = 40;          % Look-ahead size for VAD / DTX
NsWin = 240;
NFrame = floor(Ns/NsFrame);

% Append zeros to input data (to allow look-ahead for the last frame)
x = [x; zeros(NsFrame, 1)];

% HPFilt is a simple HPF that is used to remove dc components from
% the input signal that is mu-law coded
HPFilt.b = [1 -1];
HPFilt.a = [1 -127/128];

% Highpass filter to create the signal to be coded
x_hp = filter(HPFilt.b, HPFilt.a, x);

% Set up the quantizer tables
[Yq, Xq, Code, ICode] = QuantMuLawTables;

% Initialize the VAD and DTX
VADPar = InitVADPar;
DTXPar = InitDTXPar;

% Set up memory for windowing in VAD / DTX
%    saved 160   new 80
% |xxxxxxxxxxxx|nnnnnnnn|  window 240
%          cccc|cccc       current frame 80
%                   vvvv   look-ahead 40
% Set up memory for coding frames
%      saved 40  new 80
%         |xxxx|nnnnnnnn|
%          cccc|cccc       current frame 80

x_hp_mem = zeros(NsLA, 1);

for (k = 0:NFrame-1)

  ist = k*NsFrame + 1;
  ifn = ist + NsFrame - 1;       % New data limits

  % VAD / DTX
  x_new = x(ist:ifn);
  [Ivd, VADPar] = VAD(x_new, VADPar);
  [Ftype, DTXPar] = DTX(x_new, Ivd, DTXPar);

% Write data to the binary file
  x_hp_buffer = [x_hp_mem; x_hp(ist:ifn)];
  x_hp_curr = x_hp_buffer(1:NsFrame);           % Extract current frame
  if (Ftype == CActive)
    Qindex = Quant(x_hp_curr, Xq);
    xc = Code(Qindex+1);
    fwrite(FID, [CActive; xc], 'uint8');
  else
    fwrite(FID, Ftype, 'uint8');
  end

  % Memory for next frame
  x_hp_mem = x_hp_buffer(end-NsLA+1:end);
  
end

fclose(FID);

return
