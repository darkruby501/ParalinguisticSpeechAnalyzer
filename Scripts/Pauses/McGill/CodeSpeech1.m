function [x,VoicedVector] = CodeSpeech1(wavname)
% Sample file to code the active speech frames

x = wavread(wavname);

% % % FID = fopen('CodedData.cod', 'w');


CActive = 1;
CSilence = 0;
CSID = 2;

Ns = length(x);     %Number of samples
NsFrame = 80;       % Frame size (10ms) --- NEED TO CHANGE FOR 
NsLA = 40;          % Look-ahead size for VAD / DTX --- MAYBE THIS TOO
NsWin = 240;
NFrame = floor(Ns/NsFrame);

% Append zeros to input data (to allow look-ahead for the last frame)
x = [x; zeros(NsFrame, 1)];
VoicedVector = zeros(length(x),1);


% Initialize the VAD and DTX
VADPar = InitVADPar;


for (k = 0:NFrame-1) %Iterates over frames

  ist = k*NsFrame + 1;
  ifn = ist + NsFrame - 1;       % New data limits

  % VAD / DTX
  x_new = x(ist:ifn);
  [Ivd, VADPar] = VAD(x_new, VADPar);
  
  VoicedVector(ist:ifn) = Ivd;
  
%  % Write data to the binary file
%   x_hp_buffer = [x_hp_mem; x_hp(ist:ifn)];
%   x_hp_curr = x_hp_buffer(1:NsFrame);           % Extract current frame
%   if (Ftype == CActive)
%     Qindex = Quant(x_hp_curr, Xq);
%     xc = Code(Qindex+1);
%     fwrite(FID, [CActive; xc], 'uint8');
%   else
%     fwrite(FID, Ftype, 'uint8');
%   end
% 
%   % Memory for next frame
%   x_hp_mem = x_hp_buffer(end-NsLA+1:end);
  
end

return

% Need to create new variable which marks for the speech whether there is
% or isn't activity.