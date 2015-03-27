function VADPar = InitVADPar()

% initialize constant parameters
VADPar.M = 10;     % LP order
VADPar.NP = 12;    % autocorrelation order

VADPar.N0 = 128;   % number of frames for long-term min energy calculation
VADPar.Ni = 32;    % number of frames for initialization of running averages
VADPar.INIT_COUNT = 20;

% HPFilt is a HPF that is used to preprocess the signal applied to the VAD.
% 140 Hz cutoff, unity gain near 200 Hz, falling to 0.971 at high freq.
VADPar.HPFilt.b = [ 0.92727435, -1.8544941,  0.92727435 ];
VADPar.HPFilt.a = [ 1,          -1.9059465,  0.91140240 ];
VADPar.HPFilt.Mem = [];

VADPar.N = 240;    % window size
VADPar.LA = 40;    % Look-ahead
VADPar.NF = 80;    % Frame size

LWmem = VADPar.N - VADPar.NF;
VADPar.Wmem = zeros(LWmem, 1);

LA = VADPar.LA;
LB = VADPar.N - VADPar.LA;
VADPar.Window = [0.54 - 0.46*cos(2*pi*(0:LB-1)'/(2*LB-1));
                 cos(2*pi*(0:LA-1)'/(4*LA-1))];

% LP analysis, lag window applied to autocorrelation coefficients
Fs = 8000;
BWExp = 60;         % 60 Hz bandwidth expansion, Gaussian window
w0 = 2 * pi * BWExp / Fs;
NP = VADPar.NP;
Wn = 1.0001;        % White noise compensation (diagonal loading)
VADPar.LagWindow = [Wn; exp(-0.5 * (w0 * (1:NP)').^2)] / Wn;

% Correlation for a lowpass filter (3 dB point on the power spectrum is
% at about 2 kHz)
VADPar.LBF_CORR = ...
    [ 0.24017939691329, 0.21398822343783, 0.14767692339633, ...
      0.07018811903116, 0.00980856433051,-0.02015934721195, ...
     -0.02388269958005,-0.01480076155002,-0.00503292155509, ...
      0.00012141366508, 0.00119354245231, 0.00065908718613, ...
      0.00015015782285]';

% initialize variable parameters
VADPar.FrmCount = 0;
VADPar.FrmEn = Inf * ones(1,VADPar.N0);
VADPar.MeanLSF = zeros(VADPar.M, 1);
VADPar.MeanSE = 0;
VADPar.MeanSLE = 0;
VADPar.MeanE = 0;
VADPar.MeanSZC = 0;
VADPar.count_sil = 0;
VADPar.count_inert = 0;     % modified for AppendixII
VADPar.count_update = 0;
VADPar.count_ext = 0;
VADPar.less_count = 0;
VADPar.flag = 1;

VADPar.PrevMarkers = [1, 1];
VADPar.PrevEnergy = 0;

VADPar.Prev_MinE = Inf;
VADPar.Next_MinE = Inf;
VADPar.MinE_buffer = Inf * ones(1, VADPar.N0/8);

return
